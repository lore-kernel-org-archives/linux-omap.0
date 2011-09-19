From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 2/3] OMAPDSS: DISPC: VIDEO3 pipeline support
Date: Tue, 20 Sep 2011 01:13:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC811422@dbde02.ent.ti.com>
References: <1316155153-24351-1-git-send-email-archit@ti.com>
 <1316155153-24351-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57969 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab1ISTns convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 15:43:48 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8JJhjfw021024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 19 Sep 2011 14:43:47 -0500
In-Reply-To: <1316155153-24351-3-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Taneja, Archit
> Sent: Friday, September 16, 2011 12:09 PM
> To: Valkeinen, Tomi
> Cc: Hiremath, Vaibhav; linux-omap@vger.kernel.org; Taneja, Archit
> Subject: [PATCH v2 2/3] OMAPDSS: DISPC: VIDEO3 pipeline support
>
> Add support for VIDEO3 pipeline on OMAP4:
> - Add VIDEO3 pipeline information in dss_features and omapdss.h
> - Add VIDEO3 pipeline register coefficients in dispc.h
> - Create a new overlay structure corresponding to VIDEO3.
> - Make changes in dispc.c for VIDEO3
>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c        |   17 ++++++++--
>  drivers/video/omap2/dss/dispc.h        |   57
> ++++++++++++++++++++++++++++++++
>  drivers/video/omap2/dss/dss_features.c |   18 +++++++++-
>  drivers/video/omap2/dss/dss_features.h |    2 +-
>  drivers/video/omap2/dss/overlay.c      |    5 +++
>  include/video/omapdss.h                |    5 ++-
>  6 files changed, 97 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index e0639d3..fa7aadf 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -751,7 +751,7 @@ static void dispc_ovl_set_pre_mult_alpha(enum
> omap_plane plane, bool enable)
>
>  static void dispc_ovl_setup_global_alpha(enum omap_plane plane, u8
> global_alpha)
>  {
> -     static const unsigned shifts[] = { 0, 8, 16, };
> +     static const unsigned shifts[] = { 0, 8, 16, 24, };
>       int shift;
>       struct omap_overlay *ovl = omap_dss_get_overlay(plane);
>
> @@ -866,6 +866,7 @@ static void dispc_ovl_set_channel_out(enum omap_plane
> plane,
>               break;
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
> +     case OMAP_DSS_VIDEO3:
>               shift = 16;
>               break;
>       default:
> @@ -903,7 +904,7 @@ static void dispc_ovl_set_channel_out(enum omap_plane
> plane,
>  static void dispc_ovl_set_burst_size(enum omap_plane plane,
>               enum omap_burst_size burst_size)
>  {
> -     static const unsigned shifts[] = { 6, 14, 14, };
> +     static const unsigned shifts[] = { 6, 14, 14, 14, };
>       int shift;
>
>       shift = shifts[plane];
> @@ -988,7 +989,7 @@ static void dispc_ovl_set_vid_color_conv(enum
> omap_plane plane, bool enable)
>
>  static void dispc_ovl_enable_replication(enum omap_plane plane, bool
> enable)
>  {
> -     static const unsigned shifts[] = { 5, 10, 10 };
> +     static const unsigned shifts[] = { 5, 10, 10, 10 };
>       int shift;
>
>       shift = shifts[plane];
> @@ -2558,6 +2559,10 @@ void dispc_dump_irqs(struct seq_file *s)
>       PIS(VID1_END_WIN);
>       PIS(VID2_FIFO_UNDERFLOW);
>       PIS(VID2_END_WIN);
> +     if (dss_feat_get_num_ovls() > 3) {
> +             PIS(VID3_FIFO_UNDERFLOW);
> +             PIS(VID3_END_WIN);
> +     }
>       PIS(SYNC_LOST);
>       PIS(SYNC_LOST_DIGIT);
>       PIS(WAKEUP);
> @@ -2583,6 +2588,7 @@ void dispc_dump_regs(struct seq_file *s)
>               [OMAP_DSS_GFX]          = "GFX",
>               [OMAP_DSS_VIDEO1]       = "VID1",
>               [OMAP_DSS_VIDEO2]       = "VID2",
> +             [OMAP_DSS_VIDEO3]       = "VID3",
>       };
>       const char **p_names;
>
> @@ -2985,6 +2991,8 @@ static void print_irq_status(u32 status)
>       PIS(OCP_ERR);
>       PIS(VID1_FIFO_UNDERFLOW);
>       PIS(VID2_FIFO_UNDERFLOW);
> +     if (dss_feat_get_num_ovls() > 3)
> +             PIS(VID3_FIFO_UNDERFLOW);
>       PIS(SYNC_LOST);
>       PIS(SYNC_LOST_DIGIT);
>       if (dss_has_feature(FEAT_MGR_LCD2))
> @@ -3082,6 +3090,7 @@ static void dispc_error_worker(struct work_struct
> *work)
>               DISPC_IRQ_GFX_FIFO_UNDERFLOW,
>               DISPC_IRQ_VID1_FIFO_UNDERFLOW,
>               DISPC_IRQ_VID2_FIFO_UNDERFLOW,
> +             DISPC_IRQ_VID3_FIFO_UNDERFLOW,
>       };
>
>       static const unsigned sync_lost_bits[] = {
> @@ -3257,6 +3266,8 @@ static void _omap_dispc_initialize_irq(void)
>       dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
>       if (dss_has_feature(FEAT_MGR_LCD2))
>               dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
> +     if (dss_feat_get_num_ovls() > 3)
> +             dispc.irq_error_mask |= DISPC_IRQ_VID3_FIFO_UNDERFLOW;
>
>       /* there's SYNC_LOST_DIGIT waiting after enabling the DSS,
>        * so clear it */
> diff --git a/drivers/video/omap2/dss/dispc.h
> b/drivers/video/omap2/dss/dispc.h
> index 6c9ee0a..c06efc3 100644
> --- a/drivers/video/omap2/dss/dispc.h
> +++ b/drivers/video/omap2/dss/dispc.h
> @@ -291,6 +291,8 @@ static inline u16 DISPC_OVL_BASE(enum omap_plane
> plane)
>               return 0x00BC;
>       case OMAP_DSS_VIDEO2:
>               return 0x014C;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0300;
>       default:
>               BUG();
>       }
> @@ -304,6 +306,8 @@ static inline u16 DISPC_BA0_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0000;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0008;
>       default:
>               BUG();
>       }
> @@ -316,6 +320,8 @@ static inline u16 DISPC_BA1_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0004;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x000C;
>       default:
>               BUG();
>       }
> @@ -330,6 +336,8 @@ static inline u16 DISPC_BA0_UV_OFFSET(enum omap_plane
> plane)
>               return 0x0544;
>       case OMAP_DSS_VIDEO2:
>               return 0x04BC;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0310;
>       default:
>               BUG();
>       }
> @@ -344,6 +352,8 @@ static inline u16 DISPC_BA1_UV_OFFSET(enum omap_plane
> plane)
>               return 0x0548;
>       case OMAP_DSS_VIDEO2:
>               return 0x04C0;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0314;
>       default:
>               BUG();
>       }
> @@ -356,6 +366,8 @@ static inline u16 DISPC_POS_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0008;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x009C;
>       default:
>               BUG();
>       }
> @@ -368,6 +380,8 @@ static inline u16 DISPC_SIZE_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x000C;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x00A8;
>       default:
>               BUG();
>       }
> @@ -381,6 +395,8 @@ static inline u16 DISPC_ATTR_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0010;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0070;
>       default:
>               BUG();
>       }
> @@ -395,6 +411,8 @@ static inline u16 DISPC_ATTR2_OFFSET(enum omap_plane
> plane)
>               return 0x0568;
>       case OMAP_DSS_VIDEO2:
>               return 0x04DC;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x032C;
>       default:
>               BUG();
>       }
> @@ -408,6 +426,8 @@ static inline u16 DISPC_FIFO_THRESH_OFFSET(enum
> omap_plane plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0014;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x008C;
>       default:
>               BUG();
>       }
> @@ -421,6 +441,8 @@ static inline u16 DISPC_FIFO_SIZE_STATUS_OFFSET(enum
> omap_plane plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0018;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0088;
>       default:
>               BUG();
>       }
> @@ -434,6 +456,8 @@ static inline u16 DISPC_ROW_INC_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x001C;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x00A4;
>       default:
>               BUG();
>       }
> @@ -447,6 +471,8 @@ static inline u16 DISPC_PIX_INC_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0020;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0098;
>       default:
>               BUG();
>       }
> @@ -459,6 +485,7 @@ static inline u16 DISPC_WINDOW_SKIP_OFFSET(enum
> omap_plane plane)
>               return 0x0034;
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
> +     case OMAP_DSS_VIDEO3:
>               BUG();
>       default:
>               BUG();
> @@ -472,6 +499,7 @@ static inline u16 DISPC_TABLE_BA_OFFSET(enum
> omap_plane plane)
>               return 0x0038;
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
> +     case OMAP_DSS_VIDEO3:
>               BUG();
>       default:
>               BUG();
> @@ -486,6 +514,8 @@ static inline u16 DISPC_FIR_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0024;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0090;
>       default:
>               BUG();
>       }
> @@ -500,6 +530,8 @@ static inline u16 DISPC_FIR2_OFFSET(enum omap_plane
> plane)
>               return 0x0580;
>       case OMAP_DSS_VIDEO2:
>               return 0x055C;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0424;
>       default:
>               BUG();
>       }
> @@ -513,6 +545,8 @@ static inline u16 DISPC_PIC_SIZE_OFFSET(enum
> omap_plane plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0028;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0094;
>       default:
>               BUG();
>       }
> @@ -527,6 +561,8 @@ static inline u16 DISPC_ACCU0_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x002C;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0000;
>       default:
>               BUG();
>       }
> @@ -541,6 +577,8 @@ static inline u16 DISPC_ACCU2_0_OFFSET(enum omap_plane
> plane)
>               return 0x0584;
>       case OMAP_DSS_VIDEO2:
>               return 0x0560;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0428;
>       default:
>               BUG();
>       }
> @@ -554,6 +592,8 @@ static inline u16 DISPC_ACCU1_OFFSET(enum omap_plane
> plane)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0030;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0004;
>       default:
>               BUG();
>       }
> @@ -568,6 +608,8 @@ static inline u16 DISPC_ACCU2_1_OFFSET(enum omap_plane
> plane)
>               return 0x0588;
>       case OMAP_DSS_VIDEO2:
>               return 0x0564;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x042C;
>       default:
>               BUG();
>       }
> @@ -582,6 +624,8 @@ static inline u16 DISPC_FIR_COEF_H_OFFSET(enum
> omap_plane plane, u16 i)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0034 + i * 0x8;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0010 + i * 0x8;
>       default:
>               BUG();
>       }
> @@ -597,6 +641,8 @@ static inline u16 DISPC_FIR_COEF_H2_OFFSET(enum
> omap_plane plane, u16 i)
>               return 0x058C + i * 0x8;
>       case OMAP_DSS_VIDEO2:
>               return 0x0568 + i * 0x8;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0430 + i * 0x8;
>       default:
>               BUG();
>       }
> @@ -611,6 +657,8 @@ static inline u16 DISPC_FIR_COEF_HV_OFFSET(enum
> omap_plane plane, u16 i)
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
>               return 0x0038 + i * 0x8;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0014 + i * 0x8;
>       default:
>               BUG();
>       }
> @@ -626,6 +674,8 @@ static inline u16 DISPC_FIR_COEF_HV2_OFFSET(enum
> omap_plane plane, u16 i)
>               return 0x0590 + i * 8;
>       case OMAP_DSS_VIDEO2:
>               return 0x056C + i * 0x8;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0434 + i * 0x8;
>       default:
>               BUG();
>       }
> @@ -639,6 +689,7 @@ static inline u16 DISPC_CONV_COEF_OFFSET(enum
> omap_plane plane, u16 i)
>               BUG();
>       case OMAP_DSS_VIDEO1:
>       case OMAP_DSS_VIDEO2:
> +     case OMAP_DSS_VIDEO3:
>               return 0x0074 + i * 0x4;
>       default:
>               BUG();
> @@ -655,6 +706,8 @@ static inline u16 DISPC_FIR_COEF_V_OFFSET(enum
> omap_plane plane, u16 i)
>               return 0x0124 + i * 0x4;
>       case OMAP_DSS_VIDEO2:
>               return 0x00B4 + i * 0x4;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0050 + i * 0x4;
>       default:
>               BUG();
>       }
> @@ -670,6 +723,8 @@ static inline u16 DISPC_FIR_COEF_V2_OFFSET(enum
> omap_plane plane, u16 i)
>               return 0x05CC + i * 0x4;
>       case OMAP_DSS_VIDEO2:
>               return 0x05A8 + i * 0x4;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x0470 + i * 0x4;
>       default:
>               BUG();
>       }
> @@ -684,6 +739,8 @@ static inline u16 DISPC_PRELOAD_OFFSET(enum omap_plane
> plane)
>               return 0x0174;
>       case OMAP_DSS_VIDEO2:
>               return 0x00E8;
> +     case OMAP_DSS_VIDEO3:
> +             return 0x00A0;
>       default:
>               BUG();
>       }
> diff --git a/drivers/video/omap2/dss/dss_features.c
> b/drivers/video/omap2/dss/dss_features.c
> index 70d5b9e..e5e94f4 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -210,6 +210,16 @@ static const enum omap_color_mode
> omap4_dss_supported_color_modes[] = {
>       OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
>       OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
>       OMAP_DSS_COLOR_RGBX32,
> +
> +     /* OMAP_DSS_VIDEO3 */
> +     OMAP_DSS_COLOR_RGB16 | OMAP_DSS_COLOR_RGB12U |
> +     OMAP_DSS_COLOR_YUV2 | OMAP_DSS_COLOR_ARGB16_1555 |
> +     OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_NV12 |
> +     OMAP_DSS_COLOR_RGBA16 | OMAP_DSS_COLOR_RGB24U |
> +     OMAP_DSS_COLOR_RGB24P | OMAP_DSS_COLOR_UYVY |
> +     OMAP_DSS_COLOR_ARGB16 | OMAP_DSS_COLOR_XRGB16_1555 |
> +     OMAP_DSS_COLOR_ARGB32 | OMAP_DSS_COLOR_RGBX16 |
> +     OMAP_DSS_COLOR_RGBX32,
>  };
>
>  static const enum omap_overlay_caps omap2_dss_overlay_caps[] = {
> @@ -258,6 +268,10 @@ static const enum omap_overlay_caps
> omap4_dss_overlay_caps[] = {
>       /* OMAP_DSS_VIDEO2 */
>       OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
>               OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_ZORDER,
> +
> +     /* OMAP_DSS_VIDEO3 */
> +     OMAP_DSS_OVL_CAP_SCALE | OMAP_DSS_OVL_CAP_GLOBAL_ALPHA |
> +             OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA | OMAP_DSS_OVL_CAP_ZORDER,
>  };
>
>  static const char * const omap2_dss_clk_source_names[] = {
> @@ -401,7 +415,7 @@ static const struct omap_dss_features
> omap4430_es1_0_dss_features  = {
>               FEAT_ALPHA_FREE_ZORDER,
>
>       .num_mgrs = 3,
> -     .num_ovls = 3,
> +     .num_ovls = 4,
>       .supported_displays = omap4_dss_supported_displays,
>       .supported_color_modes = omap4_dss_supported_color_modes,
>       .overlay_caps = omap4_dss_overlay_caps,
> @@ -425,7 +439,7 @@ static const struct omap_dss_features
> omap4_dss_features = {
>               FEAT_PRELOAD | FEAT_FIR_COEF_V | FEAT_ALPHA_FREE_ZORDER,
>
>       .num_mgrs = 3,
> -     .num_ovls = 3,
> +     .num_ovls = 4,
>       .supported_displays = omap4_dss_supported_displays,
>       .supported_color_modes = omap4_dss_supported_color_modes,
>       .overlay_caps = omap4_dss_overlay_caps,
> diff --git a/drivers/video/omap2/dss/dss_features.h
> b/drivers/video/omap2/dss/dss_features.h
> index e81271a..6a6c05d 100644
> --- a/drivers/video/omap2/dss/dss_features.h
> +++ b/drivers/video/omap2/dss/dss_features.h
> @@ -25,7 +25,7 @@
>  #endif
>
>  #define MAX_DSS_MANAGERS     3
> -#define MAX_DSS_OVERLAYS     3
> +#define MAX_DSS_OVERLAYS     4
[Hiremath, Vaibhav] Not related to this patch as such, but I think we should now get rid of these macros and use run-time mechanism.

Overall this patch looks ok to me, I will test it tomorrow and will update you.

Thanks,
Vaibhav

>  #define MAX_DSS_LCD_MANAGERS 2
>  #define MAX_NUM_DSI          2
>
> diff --git a/drivers/video/omap2/dss/overlay.c
> b/drivers/video/omap2/dss/overlay.c
> index afb7583..11d21e3 100644
> --- a/drivers/video/omap2/dss/overlay.c
> +++ b/drivers/video/omap2/dss/overlay.c
> @@ -615,6 +615,11 @@ void dss_init_overlays(struct platform_device *pdev)
>                       ovl->id = OMAP_DSS_VIDEO2;
>                       ovl->info.global_alpha = 255;
>                       break;
> +             case 3:
> +                     ovl->name = "vid3";
> +                     ovl->id = OMAP_DSS_VIDEO3;
> +                     ovl->info.global_alpha = 255;
> +                     break;
>               }
>
>               ovl->set_manager = &omap_dss_set_manager;
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index 5f0ce5e..1f12559 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -41,6 +41,8 @@
>  #define DISPC_IRQ_WAKEUP             (1 << 16)
>  #define DISPC_IRQ_SYNC_LOST2         (1 << 17)
>  #define DISPC_IRQ_VSYNC2             (1 << 18)
> +#define DISPC_IRQ_VID3_END_WIN               (1 << 19)
> +#define DISPC_IRQ_VID3_FIFO_UNDERFLOW        (1 << 20)
>  #define DISPC_IRQ_ACBIAS_COUNT_STAT2 (1 << 21)
>  #define DISPC_IRQ_FRAMEDONE2         (1 << 22)
>  #define DISPC_IRQ_FRAMEDONEWB                (1 << 23)
> @@ -63,7 +65,8 @@ enum omap_display_type {
>  enum omap_plane {
>       OMAP_DSS_GFX    = 0,
>       OMAP_DSS_VIDEO1 = 1,
> -     OMAP_DSS_VIDEO2 = 2
> +     OMAP_DSS_VIDEO2 = 2,
> +     OMAP_DSS_VIDEO3 = 3,
>  };
>
>  enum omap_channel {
> --
> 1.7.1

