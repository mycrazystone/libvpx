sub vp8_common_forward_decls() {
print <<EOF
/*
 * VP8
 */

struct blockd;
struct macroblockd;
struct loop_filter_info;

/* Encoder forward decls */
struct block;
struct macroblock;
struct variance_vtable;
union int_mv;
struct yv12_buffer_config;
EOF
}
forward_decls qw/vp8_common_forward_decls/;

#
# Dequant
#
add_proto qw/void vp8_dequantize_b/, "struct blockd*, short *dqc";
specialize qw/vp8_dequantize_b mmx neon msa/;

add_proto qw/void vp8_dequant_idct_add/, "short *input, short *dq, unsigned char *output, int stride";
specialize qw/vp8_dequant_idct_add mmx neon dspr2 msa/;

add_proto qw/void vp8_dequant_idct_add_y_block/, "short *q, short *dq, unsigned char *dst, int stride, char *eobs";
specialize qw/vp8_dequant_idct_add_y_block sse2 neon dspr2 msa/;

add_proto qw/void vp8_dequant_idct_add_uv_block/, "short *q, short *dq, unsigned char *dst_u, unsigned char *dst_v, int stride, char *eobs";
specialize qw/vp8_dequant_idct_add_uv_block sse2 neon dspr2 msa/;

#
# Loopfilter
#
add_proto qw/void vp8_loop_filter_mbv/, "unsigned char *y, unsigned char *u, unsigned char *v, int ystride, int uv_stride, struct loop_filter_info *lfi";
specialize qw/vp8_loop_filter_mbv sse2 neon dspr2 msa/;

add_proto qw/void vp8_loop_filter_bv/, "unsigned char *y, unsigned char *u, unsigned char *v, int ystride, int uv_stride, struct loop_filter_info *lfi";
specialize qw/vp8_loop_filter_bv sse2 neon dspr2 msa/;

add_proto qw/void vp8_loop_filter_mbh/, "unsigned char *y, unsigned char *u, unsigned char *v, int ystride, int uv_stride, struct loop_filter_info *lfi";
specialize qw/vp8_loop_filter_mbh sse2 neon dspr2 msa/;

add_proto qw/void vp8_loop_filter_bh/, "unsigned char *y, unsigned char *u, unsigned char *v, int ystride, int uv_stride, struct loop_filter_info *lfi";
specialize qw/vp8_loop_filter_bh sse2 neon dspr2 msa/;


add_proto qw/void vp8_loop_filter_simple_mbv/, "unsigned char *y, int ystride, const unsigned char *blimit";
specialize qw/vp8_loop_filter_simple_mbv sse2 neon msa/;
$vp8_loop_filter_simple_mbv_c=vp8_loop_filter_simple_vertical_edge_c;
$vp8_loop_filter_simple_mbv_sse2=vp8_loop_filter_simple_vertical_edge_sse2;
$vp8_loop_filter_simple_mbv_neon=vp8_loop_filter_mbvs_neon;
$vp8_loop_filter_simple_mbv_msa=vp8_loop_filter_simple_vertical_edge_msa;

add_proto qw/void vp8_loop_filter_simple_mbh/, "unsigned char *y, int ystride, const unsigned char *blimit";
specialize qw/vp8_loop_filter_simple_mbh sse2 neon msa/;
$vp8_loop_filter_simple_mbh_c=vp8_loop_filter_simple_horizontal_edge_c;
$vp8_loop_filter_simple_mbh_sse2=vp8_loop_filter_simple_horizontal_edge_sse2;
$vp8_loop_filter_simple_mbh_neon=vp8_loop_filter_mbhs_neon;
$vp8_loop_filter_simple_mbh_msa=vp8_loop_filter_simple_horizontal_edge_msa;

add_proto qw/void vp8_loop_filter_simple_bv/, "unsigned char *y, int ystride, const unsigned char *blimit";
specialize qw/vp8_loop_filter_simple_bv sse2 neon msa/;
$vp8_loop_filter_simple_bv_c=vp8_loop_filter_bvs_c;
$vp8_loop_filter_simple_bv_sse2=vp8_loop_filter_bvs_sse2;
$vp8_loop_filter_simple_bv_neon=vp8_loop_filter_bvs_neon;
$vp8_loop_filter_simple_bv_msa=vp8_loop_filter_bvs_msa;

add_proto qw/void vp8_loop_filter_simple_bh/, "unsigned char *y, int ystride, const unsigned char *blimit";
specialize qw/vp8_loop_filter_simple_bh sse2 neon msa/;
$vp8_loop_filter_simple_bh_c=vp8_loop_filter_bhs_c;
$vp8_loop_filter_simple_bh_sse2=vp8_loop_filter_bhs_sse2;
$vp8_loop_filter_simple_bh_neon=vp8_loop_filter_bhs_neon;
$vp8_loop_filter_simple_bh_msa=vp8_loop_filter_bhs_msa;

#
# IDCT
#
#idct16
add_proto qw/void vp8_short_idct4x4llm/, "short *input, unsigned char *pred, int pitch, unsigned char *dst, int dst_stride";
specialize qw/vp8_short_idct4x4llm mmx neon dspr2 msa/;

#iwalsh1
add_proto qw/void vp8_short_inv_walsh4x4_1/, "short *input, short *output";
specialize qw/vp8_short_inv_walsh4x4_1 dspr2/;

#iwalsh16
add_proto qw/void vp8_short_inv_walsh4x4/, "short *input, short *output";
specialize qw/vp8_short_inv_walsh4x4 sse2 neon dspr2 msa/;

#idct1_scalar_add
add_proto qw/void vp8_dc_only_idct_add/, "short input, unsigned char *pred, int pred_stride, unsigned char *dst, int dst_stride";
specialize qw/vp8_dc_only_idct_add mmx neon dspr2 msa/;

#
# RECON
#
add_proto qw/void vp8_copy_mem16x16/, "unsigned char *src, int src_pitch, unsigned char *dst, int dst_pitch";
specialize qw/vp8_copy_mem16x16 sse2 neon dspr2 msa/;

add_proto qw/void vp8_copy_mem8x8/, "unsigned char *src, int src_pitch, unsigned char *dst, int dst_pitch";
specialize qw/vp8_copy_mem8x8 mmx neon dspr2 msa/;

add_proto qw/void vp8_copy_mem8x4/, "unsigned char *src, int src_pitch, unsigned char *dst, int dst_pitch";
specialize qw/vp8_copy_mem8x4 mmx neon dspr2 msa/;

#
# Postproc
#
if (vpx_config("CONFIG_POSTPROC") eq "yes") {

    add_proto qw/void vp8_blend_mb_inner/, "unsigned char *y, unsigned char *u, unsigned char *v, int y1, int u1, int v1, int alpha, int stride";

    add_proto qw/void vp8_blend_mb_outer/, "unsigned char *y, unsigned char *u, unsigned char *v, int y1, int u1, int v1, int alpha, int stride";

    add_proto qw/void vp8_blend_b/, "unsigned char *y, unsigned char *u, unsigned char *v, int y1, int u1, int v1, int alpha, int stride";

    add_proto qw/void vp8_filter_by_weight16x16/, "unsigned char *src, int src_stride, unsigned char *dst, int dst_stride, int src_weight";
    specialize qw/vp8_filter_by_weight16x16 sse2 msa/;

    add_proto qw/void vp8_filter_by_weight8x8/, "unsigned char *src, int src_stride, unsigned char *dst, int dst_stride, int src_weight";
    specialize qw/vp8_filter_by_weight8x8 sse2 msa/;

    add_proto qw/void vp8_filter_by_weight4x4/, "unsigned char *src, int src_stride, unsigned char *dst, int dst_stride, int src_weight";
}

#
# Subpixel
#
add_proto qw/void vp8_sixtap_predict16x16/, "unsigned char *src, int src_pitch, int xofst, int yofst, unsigned char *dst, int dst_pitch";
specialize qw/vp8_sixtap_predict16x16 sse2 ssse3 neon dspr2 msa mmi/;

add_proto qw/void vp8_sixtap_predict8x8/, "unsigned char *src, int src_pitch, int xofst, int yofst, unsigned char *dst, int dst_pitch";
specialize qw/vp8_sixtap_predict8x8 sse2 ssse3 neon dspr2 msa mmi/;

add_proto qw/void vp8_sixtap_predict8x4/, "unsigned char *src, int src_pitch, int xofst, int yofst, unsigned char *dst, int dst_pitch";
specialize qw/vp8_sixtap_predict8x4 sse2 ssse3 neon dspr2 msa mmi/;

add_proto qw/void vp8_sixtap_predict4x4/, "unsigned char *src, int src_pitch, int xofst, int yofst, unsigned char *dst, int dst_pitch";
specialize qw/vp8_sixtap_predict4x4 mmx ssse3 neon dspr2 msa mmi/;

add_proto qw/void vp8_bilinear_predict16x16/, "unsigned char *src, int src_pitch, int xofst, int yofst, unsigned char *dst, int dst_pitch";
specialize qw/vp8_bilinear_predict16x16 sse2 ssse3 neon msa/;

add_proto qw/void vp8_bilinear_predict8x8/, "unsigned char *src, int src_pitch, int xofst, int yofst, unsigned char *dst, int dst_pitch";
specialize qw/vp8_bilinear_predict8x8 sse2 ssse3 neon msa/;

add_proto qw/void vp8_bilinear_predict8x4/, "unsigned char *src, int src_pitch, int xofst, int yofst, unsigned char *dst, int dst_pitch";
specialize qw/vp8_bilinear_predict8x4 mmx neon msa/;

add_proto qw/void vp8_bilinear_predict4x4/, "unsigned char *src, int src_pitch, int xofst, int yofst, unsigned char *dst, int dst_pitch";
specialize qw/vp8_bilinear_predict4x4 mmx neon msa/;

#
# Encoder functions below this point.
#
if (vpx_config("CONFIG_VP8_ENCODER") eq "yes") {

#
# Block copy
#
if ($opts{arch} =~ /x86/) {
    add_proto qw/void vp8_copy32xn/, "const unsigned char *src_ptr, int source_stride, unsigned char *dst_ptr, int dst_stride, int n";
    specialize qw/vp8_copy32xn sse2 sse3/;
}

#
# Forward DCT
#
add_proto qw/void vp8_short_fdct4x4/, "short *input, short *output, int pitch";
specialize qw/vp8_short_fdct4x4 sse2 neon msa/;

add_proto qw/void vp8_short_fdct8x4/, "short *input, short *output, int pitch";
specialize qw/vp8_short_fdct8x4 sse2 neon msa/;

add_proto qw/void vp8_short_walsh4x4/, "short *input, short *output, int pitch";
specialize qw/vp8_short_walsh4x4 sse2 neon msa/;

#
# Quantizer
#
add_proto qw/void vp8_regular_quantize_b/, "struct block *, struct blockd *";
specialize qw/vp8_regular_quantize_b sse2 sse4_1 msa/;

add_proto qw/void vp8_fast_quantize_b/, "struct block *, struct blockd *";
specialize qw/vp8_fast_quantize_b sse2 ssse3 neon msa/;

#
# Block subtraction
#
add_proto qw/int vp8_block_error/, "short *coeff, short *dqcoeff";
specialize qw/vp8_block_error sse2 msa/;

add_proto qw/int vp8_mbblock_error/, "struct macroblock *mb, int dc";
specialize qw/vp8_mbblock_error sse2 msa/;

add_proto qw/int vp8_mbuverror/, "struct macroblock *mb";
specialize qw/vp8_mbuverror sse2 msa/;

#
# Motion search
#
add_proto qw/int vp8_full_search_sad/, "struct macroblock *x, struct block *b, struct blockd *d, union int_mv *ref_mv, int sad_per_bit, int distance, struct variance_vtable *fn_ptr, int *mvcost[2], union int_mv *center_mv";
specialize qw/vp8_full_search_sad sse3 sse4_1/;
$vp8_full_search_sad_sse3=vp8_full_search_sadx3;
$vp8_full_search_sad_sse4_1=vp8_full_search_sadx8;

add_proto qw/int vp8_refining_search_sad/, "struct macroblock *x, struct block *b, struct blockd *d, union int_mv *ref_mv, int sad_per_bit, int distance, struct variance_vtable *fn_ptr, int *mvcost[2], union int_mv *center_mv";
specialize qw/vp8_refining_search_sad sse2 msa/;
$vp8_refining_search_sad_sse2=vp8_refining_search_sadx4;
$vp8_refining_search_sad_msa=vp8_refining_search_sadx4;

add_proto qw/int vp8_diamond_search_sad/, "struct macroblock *x, struct block *b, struct blockd *d, union int_mv *ref_mv, union int_mv *best_mv, int search_param, int sad_per_bit, int *num00, struct variance_vtable *fn_ptr, int *mvcost[2], union int_mv *center_mv";
specialize qw/vp8_diamond_search_sad sse2 msa/;
$vp8_diamond_search_sad_sse2=vp8_diamond_search_sadx4;
$vp8_diamond_search_sad_msa=vp8_diamond_search_sadx4;

#
# Alt-ref Noise Reduction (ARNR)
#
if (vpx_config("CONFIG_REALTIME_ONLY") ne "yes") {
    add_proto qw/void vp8_temporal_filter_apply/, "unsigned char *frame1, unsigned int stride, unsigned char *frame2, unsigned int block_size, int strength, int filter_weight, unsigned int *accumulator, unsigned short *count";
    specialize qw/vp8_temporal_filter_apply sse2 msa/;
}

#
# Denoiser filter
#
if (vpx_config("CONFIG_TEMPORAL_DENOISING") eq "yes") {
    add_proto qw/int vp8_denoiser_filter/, "unsigned char *mc_running_avg_y, int mc_avg_y_stride, unsigned char *running_avg_y, int avg_y_stride, unsigned char *sig, int sig_stride, unsigned int motion_magnitude, int increase_denoising";
    specialize qw/vp8_denoiser_filter sse2 neon msa/;
    add_proto qw/int vp8_denoiser_filter_uv/, "unsigned char *mc_running_avg, int mc_avg_stride, unsigned char *running_avg, int avg_stride, unsigned char *sig, int sig_stride, unsigned int motion_magnitude, int increase_denoising";
    specialize qw/vp8_denoiser_filter_uv sse2 neon msa/;
}

# End of encoder only functions
}
1;