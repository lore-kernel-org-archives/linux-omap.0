From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 16/28] [OMAPZOOM] OMAP: CAM: Add MMS Kernel changes
Date: Wed, 15 Oct 2008 20:29:30 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256884E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50349 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752892AbYJPB3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:29:37 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1TVBS012327
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:29:36 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1TVGj015658
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:29:31 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: Add MMS Kernel changes

This adds MMS changes to the OMAP34xx camera driver. Including:
- HQ capture

NOTE: Credits to MMS crew for all this.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c        |   40 ++++++++---
 drivers/media/video/isp/isp_af.c     |   28 +++++---
 drivers/media/video/isp/ispccdc.c    |  117 ++++++++++++++++++++++++++++++++---
 drivers/media/video/isp/ispccdc.h    |    4 -
 drivers/media/video/isp/isph3a.c     |   12 +++
 drivers/media/video/isp/ispmmu.h     |    2
 drivers/media/video/isp/isppreview.c |    3
 drivers/media/video/isp/isppreview.h |    9 ++
 8 files changed, 180 insertions(+), 35 deletions(-)

Index: omapkernel/drivers/media/video/isp/isp.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.c       2008-10-15 19:37:26.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp.c    2008-10-15 19:40:02.000000000 -0500
@@ -71,6 +71,10 @@
                .description = "Bayer10 (GrR/BGb)",
                .pixelformat = V4L2_PIX_FMT_SGRBG10,
        },
+       {
+               .description = "Bayer10 (pattern)",
+               .pixelformat = V4L2_PIX_FMT_PATT,
+       }
 };

 /* ISP Crop capabilities */
@@ -980,6 +984,14 @@
                goto out;
        }

+       if ((irqstatus & HS_VS) == HS_VS) {
+               if (irqdis->isp_callbk[CBK_HS_VS])
+                       irqdis->isp_callbk[CBK_HS_VS](HS_VS,
+                               irqdis->isp_callbk_arg1[CBK_HS_VS],
+                               irqdis->isp_callbk_arg2[CBK_HS_VS]);
+               is_irqhandled = 1;
+       }
+
        if ((irqstatus & CCDC_VD1) == CCDC_VD1) {
                if (irqdis->isp_callbk[CBK_CCDC_VD1])
                                irqdis->isp_callbk[CBK_CCDC_VD1](CCDC_VD1,
@@ -1028,14 +1040,6 @@
                is_irqhandled = 1;
        }

-       if ((irqstatus & HS_VS) == HS_VS) {
-               if (irqdis->isp_callbk[CBK_HS_VS])
-                       irqdis->isp_callbk[CBK_HS_VS](HS_VS,
-                               irqdis->isp_callbk_arg1[CBK_HS_VS],
-                               irqdis->isp_callbk_arg2[CBK_HS_VS]);
-               is_irqhandled = 1;
-       }
-
        if ((irqstatus & H3A_AF_DONE) == H3A_AF_DONE) {
                if (irqdis->isp_callbk[CBK_H3A_AF_DONE])
                        irqdis->isp_callbk[CBK_H3A_AF_DONE](H3A_AF_DONE,
@@ -1191,6 +1195,9 @@
                                                is_isppreview_enabled())
                isppreview_enable(1);

+       /* clear any pending IRQs */
+       omap_writel(0xFFFFFFFF, ISP_IRQ0STATUS);
+
        return;
 }
 EXPORT_SYMBOL(isp_start);
@@ -1258,7 +1265,8 @@

        isp_release_resources();
        if ((pix_input->pixelformat == V4L2_PIX_FMT_SGRBG10) &&
-               (pix_output->pixelformat != V4L2_PIX_FMT_SGRBG10)) {
+               ((pix_output->pixelformat == V4L2_PIX_FMT_YUYV) ||
+               (pix_output->pixelformat == V4L2_PIX_FMT_UYVY))) {
                        ispmodule_obj.isp_pipeline = OMAP_ISP_CCDC |
                                        OMAP_ISP_PREVIEW | OMAP_ISP_RESIZER;
                        ispccdc_request();
@@ -1277,15 +1285,23 @@
                isppreview_config_datapath(PRV_RAW_CCDC, PREVIEW_RSZ);
                ispresizer_config_datapath(RSZ_OTFLY_YUV);
 #endif
-       } else {
+       } else if (pix_input->pixelformat == pix_output->pixelformat) {
                ispmodule_obj.isp_pipeline = OMAP_ISP_CCDC;
                ispccdc_request();
                if (pix_input->pixelformat == V4L2_PIX_FMT_SGRBG10)
                        ispccdc_config_datapath(CCDC_RAW, CCDC_OTHERS_MEM);
-               else
+               else if (pix_input->pixelformat == V4L2_PIX_FMT_PATT) {
+                       /* MMS */
+                       ispccdc_config_datapath(CCDC_RAW_PATTERN,
+                                                       CCDC_OTHERS_LSC_MEM);
+               } else if ((pix_input->pixelformat == V4L2_PIX_FMT_YUYV) ||
+                               (pix_input->pixelformat == V4L2_PIX_FMT_UYVY)) {
                        ispccdc_config_datapath(CCDC_YUV_SYNC,
                                                        CCDC_OTHERS_MEM);
-       }
+               } else
+                       return -EINVAL;
+       } else
+               return -EINVAL;
        return 0;
 }

Index: omapkernel/drivers/media/video/isp/isp_af.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp_af.c    2008-10-15 19:37:24.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp_af.c 2008-10-15 19:40:49.000000000 -0500
@@ -313,9 +313,10 @@
        busyaf = omap_readl(ISPH3A_PCR);

        if ((busyaf & AF_BUSYAF) == AF_BUSYAF) {
-               DPRINTK_ISPH3A("AF_register_setup_ERROR : Engine Busy");
-               DPRINTK_ISPH3A("\n Configuration cannot be done ");
-               return -AF_ERR_ENGINE_BUSY;
+               /* DPRINTK_ISPH3A("AF_register_setup_ERROR : Engine Busy"); */
+               /* DPRINTK_ISPH3A("\n Configuration cannot be done "); */
+               /* return -AF_ERR_ENGINE_BUSY; */
+               isp_af_enable(0);
        }

        /*Check IIR Coefficient and start Values */
@@ -396,8 +397,6 @@
        /*Set configuration flag to indicate HW setup done */
        if (af_dev_configptr->config->af_config)
                isp_af_enable(1);
-       else
-               isp_af_enable(0);

        /*Success */
        return 0;
@@ -702,9 +701,8 @@
 /* Function to Enable/Disable AF Engine */
 int isp_af_enable(int enable)
 {
-       unsigned int pcr;
-
-       pcr = omap_readl(ISPH3A_PCR);
+       /* Before enabling AF H3A we need to clear pending interrupts */
+       omap_writel(IRQ0STATUS_H3A_AF_DONE_IRQ, ISP_IRQ0STATUS);

        /* Set AF_EN bit in PCR Register */
        if (enable) {
@@ -714,12 +712,20 @@
                        return -EINVAL;
                }

-               pcr |= AF_EN;
+               omap_writel((omap_readl(ISPH3A_PCR) | AF_EN), ISPH3A_PCR);
        } else {
+               u32 timeout = 20;
                isp_unset_callback(CBK_H3A_AF_DONE);
-               pcr &= ~AF_EN;
+               omap_writel((omap_readl(ISPH3A_PCR) & ~AF_EN), ISPH3A_PCR);
+               while ((omap_readl(ISPH3A_PCR) & AF_BUSYAF) && timeout) {
+                       mdelay(10);
+                       timeout--;
+               }
+               if (timeout == 0) {
+                       printk(KERN_DEBUG "%s - can't disable AF H3A\n",
+                                                               __func__);
+               }
        }
-       omap_writel(pcr, ISPH3A_PCR);
        return 0;
 }

Index: omapkernel/drivers/media/video/isp/ispccdc.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispccdc.c   2008-10-15 19:37:25.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispccdc.c        2008-10-15 19:42:28.000000000 -0500
@@ -189,6 +189,11 @@
        } else {
                if ((ISP_ABS_CCDC_BLCLAMP & ccdc_struct->update) ==
                                        ISP_ABS_CCDC_BLCLAMP) {
+                       if (copy_from_user(&bclamp_t,
+                               (struct ispccdc_bclamp *)(ccdc_struct->bclamp),
+                               sizeof(struct ispccdc_bclamp)))
+                               goto copy_from_user_err;
+
                        ispccdc_enable_black_clamp(0);
                        ispccdc_config_black_clamp(bclamp_t);
                }
@@ -571,6 +576,19 @@
                ispccdc_config_vp(vpcfg);
                ispccdc_enable_vp(1);
                break;
+       case CCDC_OTHERS_LSC_MEM: /* Added by MMS */
+               syn_mode |= ISPCCDC_SYN_MODE_VP2SDR;
+               syn_mode |= ISPCCDC_SYN_MODE_WEN;
+               /* Generally cam_wen is used with cam_hs, vs signals */
+               syn_mode |= ISPCCDC_SYN_MODE_EXWEN;
+               omap_writel((omap_readl(ISPCCDC_CFG))
+                       | ISPCCDC_CFG_WENLOG, ISPCCDC_CFG);
+               /* Video Port Configuration */
+               vpcfg.bitshift_sel = BIT9_0;
+               vpcfg.freq_sel = PIXCLKBY2;
+               ispccdc_config_vp(vpcfg);
+               ispccdc_enable_vp(1);
+               break;
        default:
                DPRINTK_ISPCCDC("ISP_ERR: Wrong CCDC Output");
                return -EINVAL;
@@ -616,6 +634,32 @@
                blkcfg.dcsubval = 0;
                ispccdc_config_black_clamp(blkcfg);
                break;
+       /* Added by MMS */
+       case CCDC_RAW_PATTERN:
+               /* Slave mode */
+               syncif.ccdc_mastermode = 0;
+               /* Normal */
+               syncif.datapol = 0;
+               syncif.datsz = DAT8;
+               /* Progressive Mode */
+               syncif.fldmode = 0;
+               /* Input */
+               syncif.fldout = 0;
+               /* Positive */
+               syncif.fldpol = 0;
+               /* Odd Field */
+               syncif.fldstat = 0;
+               /* Positive */
+               syncif.hdpol = 0;
+               syncif.ipmod = RAW;
+               /* Positive */
+               syncif.vdpol = 0;
+               ispccdc_config_sync_if(syncif);
+               ispccdc_config_imgattr(colptn);
+               /* Config DC sub */
+               blkcfg.dcsubval = 42;
+               ispccdc_config_black_clamp(blkcfg);
+               break;
        case CCDC_YUV_BT:
                break;
        case CCDC_OTHERS:
@@ -644,6 +688,7 @@
        u32 syn_mode = omap_readl(ISPCCDC_SYN_MODE);

        syn_mode |= ISPCCDC_SYN_MODE_VDHDEN;
+       syn_mode &= ~ISPCCDC_SYN_MODE_PACK8; /* Added by MMS */

        if (syncif.fldstat)
                syn_mode |= ISPCCDC_SYN_MODE_FLDSTAT;
@@ -668,6 +713,7 @@
        switch (syncif.datsz) {
        case DAT8:
                syn_mode |= ISPCCDC_SYN_MODE_DATSIZ_8;
+               syn_mode |= ISPCCDC_SYN_MODE_PACK8; /* Added by MMS */
                break;
        case DAT10:
                syn_mode |= ISPCCDC_SYN_MODE_DATSIZ_10;
@@ -837,10 +883,11 @@
 {
        u32 blcomp_val = 0;

-       blcomp_val |= blcomp.b_mg << ISPCCDC_BLKCMP_B_MG_SHIFT;
-       blcomp_val |= blcomp.gb_g << ISPCCDC_BLKCMP_GB_G_SHIFT;
-       blcomp_val |= blcomp.gr_cy << ISPCCDC_BLKCMP_GR_CY_SHIFT;
-       blcomp_val |= blcomp.r_ye << ISPCCDC_BLKCMP_R_YE_SHIFT;
+       blcomp_val |= (((u32)blcomp.b_mg & 0xFF) << ISPCCDC_BLKCMP_B_MG_SHIFT);
+       blcomp_val |= (((u32)blcomp.gb_g & 0xFF) << ISPCCDC_BLKCMP_GB_G_SHIFT);
+       blcomp_val |= (((u32)blcomp.gr_cy & 0xFF) <<
+                                               ISPCCDC_BLKCMP_GR_CY_SHIFT);
+       blcomp_val |= (((u32)blcomp.r_ye & 0xFF) << ISPCCDC_BLKCMP_R_YE_SHIFT);

        omap_writel(blcomp_val, ISPCCDC_BLKCMP);
 }
@@ -1087,7 +1134,9 @@

        if ((ispccdc_obj.ccdc_outfmt == CCDC_OTHERS_MEM) ||
                                                (ispccdc_obj.ccdc_outfmt ==
-                                               CCDC_OTHERS_VP_MEM)) {
+                                               CCDC_OTHERS_VP_MEM) ||
+                                               (ispccdc_obj.ccdc_outfmt ==
+                                               CCDC_OTHERS_LSC_MEM)) {
                if (*output_w % 16) {
                        *output_w -= (*output_w % 16);
                        *output_w += 16;
@@ -1197,10 +1246,17 @@
                                        (ispccdc_obj.ccdcout_h <<
                                        ISPCCDC_VP_OUT_VERT_NUM_SHIFT),
                                        ISPCCDC_VP_OUT);
+/* MMS: fix wrong pattern */
+/*
                omap_writel(0 << ISPCCDC_HORZ_INFO_SPH_SHIFT |
                                        ((ispccdc_obj.ccdcout_w - 1) <<
                                        ISPCCDC_HORZ_INFO_NPH_SHIFT),
                                        ISPCCDC_HORZ_INFO);
+*/
+               omap_writel(1 << ISPCCDC_HORZ_INFO_SPH_SHIFT |
+                                       ((ispccdc_obj.ccdcout_w - 1) <<
+                                       ISPCCDC_HORZ_INFO_NPH_SHIFT),
+                                       ISPCCDC_HORZ_INFO);
                omap_writel(0 << ISPCCDC_VERT_START_SLV0_SHIFT,
                                        ISPCCDC_VERT_START);
                omap_writel((ispccdc_obj.ccdcout_h - 1) <<
@@ -1212,10 +1268,47 @@
                                        ISPCCDC_VDINT_0_SHIFT) |
                                        ((50 & ISPCCDC_VDINT_1_MASK) <<
                                        ISPCCDC_VDINT_1_SHIFT), ISPCCDC_VDINT);
+       } else if (ispccdc_obj.ccdc_outfmt == CCDC_OTHERS_LSC_MEM) {
+               /* Added by MMS */
+               /* Start with 1 pixel apart */
+               omap_writel((1 << ISPCCDC_FMT_HORZ_FMTSPH_SHIFT)
+                               | (ispccdc_obj.ccdcin_w
+                               << ISPCCDC_FMT_HORZ_FMTLNH_SHIFT),
+                               ISPCCDC_FMT_HORZ);
+
+               omap_writel((0 << ISPCCDC_FMT_VERT_FMTSLV_SHIFT)
+                               | ((ispccdc_obj.ccdcin_h)
+                               << ISPCCDC_FMT_VERT_FMTLNV_SHIFT),
+                               ISPCCDC_FMT_VERT);
+
+               omap_writel((ispccdc_obj.ccdcout_w
+                               << ISPCCDC_VP_OUT_HORZ_NUM_SHIFT)
+                               | (ispccdc_obj.ccdcout_h
+                               << ISPCCDC_VP_OUT_VERT_NUM_SHIFT),
+                               ISPCCDC_VP_OUT);
+               omap_writel(0 << ISPCCDC_HORZ_INFO_SPH_SHIFT
+                               | ((ispccdc_obj.ccdcout_w - 1)
+                               << ISPCCDC_HORZ_INFO_NPH_SHIFT),
+                               ISPCCDC_HORZ_INFO);
+               omap_writel(0 << ISPCCDC_VERT_START_SLV0_SHIFT,
+                               ISPCCDC_VERT_START);
+               omap_writel((ispccdc_obj.ccdcout_h - 1)
+                               << ISPCCDC_VERT_LINES_NLV_SHIFT,
+                               ISPCCDC_VERT_LINES);
+               /*Configure the HSIZE_OFF with output buffer width*/
+
+               ispccdc_config_outlineoffset((ispccdc_obj.ccdcout_w * 2), 0, 0);
+               omap_writel((((ispccdc_obj.ccdcout_h - 25)
+                               & ISPCCDC_VDINT_0_MASK)
+                               << ISPCCDC_VDINT_0_SHIFT)
+                               | (((50) &  ISPCCDC_VDINT_1_MASK)
+                               << ISPCCDC_VDINT_1_SHIFT),
+                               ISPCCDC_VDINT);
        }

        if (is_isplsc_activated()) {
-               if (ispccdc_obj.ccdc_inpfmt == CCDC_RAW) {
+               if ((ispccdc_obj.ccdc_inpfmt == CCDC_RAW) ||
+                       (ispccdc_obj.ccdc_inpfmt == CCDC_RAW_PATTERN)) {
                        ispccdc_config_lsc(&lsc_config);
                        ispccdc_load_lsc(lsc_config.size);
                }
@@ -1318,9 +1411,10 @@
 {
        if (enable) {
                if (ccdc_use_lsc && !ispccdc_obj.lsc_en &&
-                       (ispccdc_obj.ccdc_inpfmt == CCDC_RAW))
+                       ((ispccdc_obj.ccdc_inpfmt == CCDC_RAW) ||
+                       (ispccdc_obj.ccdc_inpfmt == CCDC_RAW_PATTERN)))
                        ispccdc_enable_lsc(1);
-
+                       mdelay(10);
                        omap_writel(omap_readl(ISPCCDC_PCR) | (ISPCCDC_PCR_EN),
                                                                ISPCCDC_PCR);
        } else {
@@ -1442,6 +1536,13 @@
                                        omap_readl(ISPCCDC_LSC_TABLE_BASE));
        DPRINTK_ISPCCDC("###CCDC LSC TABLE OFFSET=0x%x\n",
                                        omap_readl(ISPCCDC_LSC_TABLE_OFFSET));
+       /* Added by MMS */
+       DPRINTK_ISPCCDC("###CCDC ISPCCDC_BLKCMP=0x%x\n",
+                                               omap_readl(ISPCCDC_BLKCMP));
+       DPRINTK_ISPCCDC("###CCDC ISPCCDC_DCSUB=0x%x\n",
+                                               omap_readl(ISPCCDC_DCSUB));
+       DPRINTK_ISPCCDC("###CCDC ISPCCDC_FPC=0x%x\n", omap_readl(ISPCCDC_FPC));
+
 }
 EXPORT_SYMBOL(ispccdc_print_status);

Index: omapkernel/drivers/media/video/isp/ispccdc.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispccdc.h   2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispccdc.h        2008-10-15 19:39:20.000000000 -0500
@@ -42,6 +42,7 @@
        CCDC_RAW,
        CCDC_YUV_SYNC,
        CCDC_YUV_BT,
+       CCDC_RAW_PATTERN,
        CCDC_OTHERS
 };

@@ -50,7 +51,8 @@
        CCDC_YUV_MEM_RSZ,
        CCDC_OTHERS_VP,
        CCDC_OTHERS_MEM,
-       CCDC_OTHERS_VP_MEM
+       CCDC_OTHERS_VP_MEM,
+       CCDC_OTHERS_LSC_MEM
 };

 /* Enumeration constants for the sync interface parameters */
Index: omapkernel/drivers/media/video/isp/isph3a.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isph3a.c    2008-10-15 19:37:24.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isph3a.c 2008-10-15 19:43:30.000000000 -0500
@@ -28,6 +28,7 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#include <linux/delay.h>

 #include "isp.h"
 #include "ispreg.h"
@@ -215,9 +216,20 @@
                                                                ISPH3A_PCR);
                DPRINTK_ISPH3A("    H3A enabled \n");
        } else {
+               int timeout = 20;
                aewb_regs.reg_pcr &= ~ISPH3A_PCR_AEW_EN;
                omap_writel(omap_readl(ISPH3A_PCR) & ~ISPH3A_PCR_AEW_EN,
                                                                ISPH3A_PCR);
+               while ((omap_readl(ISPH3A_PCR) & ISPH3A_PCR_AEW_BUSY) &&
+                                                               timeout) {
+                       mdelay(10);
+                       timeout--;
+               }
+               if (timeout == 0) {
+                       printk(KERN_DEBUG "%s - can't disable AEWB H3A\n",
+                                                               __func__);
+               }
+
                DPRINTK_ISPH3A("    H3A disabled \n");
        }
        aewb_config_local.aewb_enable = enable;
Index: omapkernel/drivers/media/video/isp/ispmmu.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispmmu.h    2008-10-15 19:25:00.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispmmu.h 2008-10-15 19:39:20.000000000 -0500
@@ -65,7 +65,7 @@
  * to keep track of these 16 L2 page table's status.
  */
 #define L2P_TABLE_SIZE                 1024
-#define L2P_TABLE_NR                   41 /* Currently supports 4*5MP shots */
+#define L2P_TABLE_NR                   62 /* Currently supports 4*5MP shots */
 #define L2P_TABLES_SIZE                (L2P_TABLE_SIZE * L2P_TABLE_NR)

 /* Extra memory allocated to get ttb aligned on 16KB */
Index: omapkernel/drivers/media/video/isp/isppreview.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isppreview.c        2008-10-15 19:37:25.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isppreview.c     2008-10-15 19:44:09.000000000 -0500
@@ -69,7 +69,8 @@
        {ISPPRV_CDC_THR1, 0x0000},
        {ISPPRV_CDC_THR2, 0x0000},
        {ISPPRV_CDC_THR3, 0x0000},
-       {ISPPRV_PCR, 0x0000},
+/* Removed by MMS */
+/*     {ISPPRV_PCR, 0x0000}, */
        {ISP_TOK_TERM, 0x0000}
 };

Index: omapkernel/drivers/media/video/isp/isppreview.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isppreview.h        2008-10-15 19:37:24.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isppreview.h     2008-10-15 19:44:50.000000000 -0500
@@ -28,13 +28,20 @@
 #define ISPPRV_BRIGHT_DEF              0x1
 #define ISPPRV_BRIGHT_LOW              0x0
 #define ISPPRV_BRIGHT_HIGH             0xF
-#define ISPPRV_BRIGHT_UNITS            0x7
+#define ISPPRV_BRIGHT_UNITS            0x1

+/*
 #define ISPPRV_CONTRAST_STEP           0x1
 #define ISPPRV_CONTRAST_DEF            0x2
 #define ISPPRV_CONTRAST_LOW            0x0
 #define ISPPRV_CONTRAST_HIGH           0xF
 #define ISPPRV_CONTRAST_UNITS          0x5
+*/
+#define ISPPRV_CONTRAST_STEP           0x1
+#define ISPPRV_CONTRAST_DEF            0x1 /* MMS */
+#define ISPPRV_CONTRAST_LOW            0x0
+#define ISPPRV_CONTRAST_HIGH           0xF
+#define ISPPRV_CONTRAST_UNITS          0x16 /* MMS */

 #define NO_AVE                         0x0
 #define AVE_2_PIX                      0x1
