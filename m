From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 24/28] [OMAPZOOM] OMAP: CAM: Add CSI2 changes to ISP driver
Date: Wed, 15 Oct 2008 20:35:23 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256885A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47481 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbYJPBfb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:35:31 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1ZPWd022389
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:35:30 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1ZPkc021364
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:35:25 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: Add CSI2 changes to ISP driver

This adds CSI2 related changes to the ISP driver.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isp.c        |   96 ++++++++++++++++++++++++++++-------
 drivers/media/video/isp/isp.h        |   13 ++++
 drivers/media/video/isp/ispccdc.c    |   40 +++++++++++---
 drivers/media/video/isp/ispccdc.h    |    2 
 drivers/media/video/isp/isppreview.c |   27 ++++++++-
 drivers/media/video/isp/isppreview.h |    2 
 6 files changed, 151 insertions(+), 29 deletions(-)

Index: omapkernel/drivers/media/video/isp/isp.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.c	2008-10-15 20:08:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp.c	2008-10-15 20:08:36.000000000 -0500
@@ -48,6 +48,7 @@
 #include "isp_af.h"
 #include "isppreview.h"
 #include "ispresizer.h"
+#include "ispcsi2.h"
 
 #if ISP_WORKAROUND
 void *buff_addr;
@@ -171,6 +172,7 @@
 	int ref_count;
 	struct clk *cam_ick;
 	struct clk *cam_mclk;
+	struct clk *csi2_fck;
 } isp_obj;
 
 struct isp_sgdma ispsg;
@@ -528,6 +530,14 @@
 					IRQ0ENABLE_CCDC_LSC_PREF_ERR_IRQ),
 					ISP_IRQ0ENABLE);
 		break;
+	case CBK_CSIA:
+		isp_csi2_irq_set(0);
+		break;
+	case CBK_CSIB:
+		omap_writel(IRQ0ENABLE_CSIB_IRQ, ISP_IRQ0STATUS);
+		omap_writel(omap_readl(ISP_IRQ0ENABLE)|IRQ0ENABLE_CSIB_IRQ,
+					ISP_IRQ0ENABLE);
+		break;
 	default:
 		break;
 	}
@@ -892,6 +902,29 @@
 		ispctrl_val |= (config->u.par.par_bridge
 						<< ISPCTRL_PAR_BRIDGE_SHIFT);
 		break;
+	case ISP_CSIA:
+		ispctrl_val |= ISPCTRL_PAR_SER_CLK_SEL_CSIA;
+		ispctrl_val &= ~ISPCTRL_PAR_BRIDGE_BENDIAN;
+		ispctrl_val |= (0x03 << ISPCTRL_PAR_BRIDGE_SHIFT);
+
+		isp_csi2_ctx_config_format(0, config->u.csi.format);
+		isp_csi2_ctx_update(0, false);
+
+		if (config->u.csi.crc)
+			isp_csi2_ctrl_config_ecc_enable(true);
+
+		isp_csi2_ctrl_config_vp_out_ctrl(config->u.csi.vpclk);
+		isp_csi2_ctrl_config_vp_only_enable(true);
+		isp_csi2_ctrl_config_vp_clk_enable(true);
+		isp_csi2_ctrl_update(false);
+
+		isp_csi2_irq_complexio1_set(1);
+		isp_csi2_irq_status_set(1);
+		isp_csi2_irq_set(1);
+
+		isp_csi2_enable(1);
+		mdelay(3);
+		break;
 	case ISP_CSIB:
 		ispctrl_val |= ISPCTRL_PAR_SER_CLK_SEL_CSIB;
 		r = isp_init_csi(config);
@@ -915,11 +948,32 @@
 						ISPCCDC_VDINT_1_SHIFT),
 						ISPCCDC_VDINT);
 
+	/* Set sensor specific fields in CCDC and Previewer module.*/
+	isppreview_set_skip(config->prev_sph, config->prev_slv);
+	ispccdc_set_wenlog(config->wenlog);
+
 	return 0;
 }
 EXPORT_SYMBOL(isp_configure_interface);
 
 /**
+ * isp_configure_interface_bridge - Configure CCDC i/f bridge.
+ *
+ * Sets the bit field that controls the 8 to 16-bit bridge at
+ * the input to CCDC.
+ **/
+int isp_configure_interface_bridge(u32 par_bridge)
+{
+	u32 ispctrl_val = omap_readl(ISP_CTRL);
+
+	ispctrl_val &= ~ISPCTRL_PAR_BRIDGE_BENDIAN;
+	ispctrl_val |= (par_bridge << ISPCTRL_PAR_BRIDGE_SHIFT);
+	omap_writel(ispctrl_val, ISP_CTRL);
+	return 0;
+}
+EXPORT_SYMBOL(isp_configure_interface_bridge);
+
+/**
  * isp_CCDC_VD01_enable - Enables VD0 and VD1 IRQs.
  *
  * Sets VD0 and VD1 bits in IRQ0STATUS to reset the flag, and sets them in
@@ -1048,6 +1102,11 @@
 		is_irqhandled = 1;
 	}
 
+	if ((irqstatus & CSIA) == CSIA) {
+		isp_csi2_isr();
+		is_irqhandled = 1;
+	}
+
 	if (irqstatus & LSC_PRE_ERR) {
 		printk(KERN_ERR "isp_sr: LSC_PRE_ERR \n");
 		omap_writel(irqstatus, ISP_IRQ0STATUS);
@@ -1083,24 +1142,6 @@
 };
 
 /**
- * isp_set_pipeline - Set bit mask for submodules enabled within the ISP.
- * @soc_type: Sensor to use: 1 - Smart sensor, 0 - Raw sensor.
- *
- * Sets Previewer and Resizer in the bit mask only if its a Raw sensor.
- **/
-void isp_set_pipeline(int soc_type)
-{
-	ispmodule_obj.isp_pipeline |= OMAP_ISP_CCDC;
-
-	if (!soc_type)
-		ispmodule_obj.isp_pipeline |= (OMAP_ISP_PREVIEW |
-							OMAP_ISP_RESIZER);
-
-	return;
-}
-EXPORT_SYMBOL(isp_set_pipeline);
-
-/**
  * omapisp_unset_callback - Unsets all the callbacks associated with ISP module
  **/
 void omapisp_unset_callback()
@@ -2238,6 +2279,13 @@
 			ret_err = PTR_ERR(isp_obj.cam_mclk);
 			goto out_clk_get_mclk;
 		}
+		isp_obj.csi2_fck = clk_get(&camera_dev, "csi2_96m_fck");
+		if (IS_ERR(isp_obj.csi2_fck)) {
+			DPRINTK_ISPCTRL("ISP_ERR: clk_get for csi2_fclk"
+								" failed\n");
+			ret_err = PTR_ERR(isp_obj.csi2_fck);
+			goto out_clk_get_csi2_fclk;
+		}
 		ret_err = clk_enable(isp_obj.cam_ick);
 		if (ret_err) {
 			DPRINTK_ISPCTRL("ISP_ERR: clk_en for ick failed\n");
@@ -2248,6 +2296,12 @@
 			DPRINTK_ISPCTRL("ISP_ERR: clk_en for mclk failed\n");
 			goto out_clk_enable_mclk;
 		}
+		ret_err = clk_enable(isp_obj.csi2_fck);
+		if (ret_err) {
+			DPRINTK_ISPCTRL("ISP_ERR: clk_en for csi2_fclk"
+								" failed\n");
+			goto out_clk_enable_csi2_fclk;
+		}
 		if (off_mode == 1)
 			isp_restore_ctx();
 	}
@@ -2258,9 +2312,13 @@
 	DPRINTK_ISPCTRL("isp_get: new %d\n", isp_obj.ref_count);
 	return isp_obj.ref_count;
 
+out_clk_enable_csi2_fclk:
+	clk_disable(isp_obj.cam_mclk);
 out_clk_enable_mclk:
 	clk_disable(isp_obj.cam_ick);
 out_clk_enable_ick:
+	clk_put(isp_obj.csi2_fck);
+out_clk_get_csi2_fclk:
 	clk_put(isp_obj.cam_mclk);
 out_clk_get_mclk:
 	clk_put(isp_obj.cam_ick);
@@ -2289,8 +2347,10 @@
 			ispmodule_obj.isp_pipeline = 0;
 			clk_disable(isp_obj.cam_ick);
 			clk_disable(isp_obj.cam_mclk);
+			clk_disable(isp_obj.csi2_fck);
 			clk_put(isp_obj.cam_ick);
 			clk_put(isp_obj.cam_mclk);
+			clk_put(isp_obj.csi2_fck);
 			memset(&ispcroprect, 0, sizeof(ispcroprect));
 			memset(&cur_rect, 0, sizeof(cur_rect));
 #if ISP_WORKAROUND
Index: omapkernel/drivers/media/video/isp/isp.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp.h	2008-10-15 20:08:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp.h	2008-10-15 20:08:36.000000000 -0500
@@ -83,6 +83,8 @@
 };
 
 enum isp_irqevents {
+	CSIA = 0x01,
+	CSIB = 0x10,
 	CCDC_VD0 = 0x100,
 	CCDC_VD1 = 0x200,
 	CCDC_VD2 = 0x400,
@@ -113,6 +115,8 @@
 	CBK_LSC_ISR,
 	CBK_H3A_AF_DONE,
 	CBK_CATCHALL,
+	CBK_CSIA,
+	CBK_CSIB,
 	CBK_END,
 };
 
@@ -175,6 +179,9 @@
  * @strobe: Strobe related parameter.
  * @prestrobe: PreStrobe related parameter.
  * @shutter: Shutter related parameter.
+ * @hskip: Horizontal Start Pixel performed in Preview module.
+ * @vskip: Vertical Start Line performed in Preview module.
+ * @wenlog: Store the value for the sensor specific wenlog field.
  */
 struct isp_interface_config {
 	enum isp_interface_type ccdc_par_ser;
@@ -185,6 +192,9 @@
 	int strobe;
 	int prestrobe;
 	int shutter;
+	u32 prev_sph;
+	u32 prev_slv;
+	u32 wenlog;
 	union {
 		struct par {
 			unsigned par_bridge:2;
@@ -308,6 +318,9 @@
 
 void isp_restore_ctx(void);
 
+/* Configure CCDC interface bridge*/
+int isp_configure_interface_bridge(u32 par_bridge);
+
 void isp_print_status(void);
 
 dma_addr_t isp_buf_get(void);
Index: omapkernel/drivers/media/video/isp/ispccdc.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispccdc.c	2008-10-15 20:08:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispccdc.c	2008-10-15 20:08:36.000000000 -0500
@@ -82,6 +82,7 @@
 	u8 obclamp_en;
 	u8 lsc_en;
 	struct mutex mutexlock; /* For checking/modifying ccdc_inuse */
+	u32 wenlog;
 } ispccdc_obj;
 
 static struct ispccdc_lsc_config lsc_config;
@@ -316,6 +317,16 @@
 EXPORT_SYMBOL(omap34xx_isp_ccdc_config);
 
 /**
+ * Set the value to be used for CCDC_CFG.WENLOG.
+ *  w - Value of wenlog.
+ */
+void ispccdc_set_wenlog(u32 wenlog)
+{
+	ispccdc_obj.wenlog = wenlog;
+}
+EXPORT_SYMBOL(ispccdc_set_wenlog);
+
+/**
  * ispccdc_request - Reserves the CCDC module.
  *
  * Reserves the CCDC module and assures that is used only once at a time.
@@ -560,17 +571,22 @@
 		syn_mode &= ~ISPCCDC_SYN_MODE_VP2SDR;
 		syn_mode &= ~ISPCCDC_SYN_MODE_SDR2RSZ;
 		syn_mode |= ISPCCDC_SYN_MODE_WEN;
-		syn_mode |= ISPCCDC_SYN_MODE_EXWEN;
-		omap_writel((omap_readl(ISPCCDC_CFG)) | ISPCCDC_CFG_WENLOG,
+		syn_mode &= ~ISPCCDC_SYN_MODE_EXWEN;
+		omap_writel((omap_readl(ISPCCDC_CFG)) & ~ISPCCDC_CFG_WENLOG,
 								ISPCCDC_CFG);
+		vpcfg.bitshift_sel = BIT11_2;
+		vpcfg.freq_sel = PIXCLKBY2;
+		ispccdc_config_vp(vpcfg);
+		ispccdc_enable_vp(0);
 		break;
 
 	case CCDC_OTHERS_VP_MEM:
 		syn_mode &= ~ISPCCDC_SYN_MODE_VP2SDR;
+		syn_mode &= ~ISPCCDC_SYN_MODE_SDR2RSZ;
 		syn_mode |= ISPCCDC_SYN_MODE_WEN;
 		syn_mode |= ISPCCDC_SYN_MODE_EXWEN;
-		omap_writel((omap_readl(ISPCCDC_CFG)) | ISPCCDC_CFG_WENLOG,
-								ISPCCDC_CFG);
+		omap_writel((omap_readl(ISPCCDC_CFG) & ~ISPCCDC_CFG_WENLOG) |
+					ispccdc_obj.wenlog, ISPCCDC_CFG);
 		vpcfg.bitshift_sel = BIT9_0;
 		vpcfg.freq_sel = PIXCLKBY2;
 		ispccdc_config_vp(vpcfg);
@@ -1209,16 +1225,24 @@
 					ISPCCDC_VDINT_1_SHIFT), ISPCCDC_VDINT);
 
 	} else if (ispccdc_obj.ccdc_outfmt == CCDC_OTHERS_MEM) {
+		omap_writel(0, ISPCCDC_VP_OUT);
 		if (cpu_is_omap3410()) {
 			omap_writel(0 << ISPCCDC_HORZ_INFO_SPH_SHIFT |
 						((ispccdc_obj.ccdcout_w - 1) <<
 						ISPCCDC_HORZ_INFO_NPH_SHIFT),
 						ISPCCDC_HORZ_INFO);
 		} else {
-			omap_writel(1 << ISPCCDC_HORZ_INFO_SPH_SHIFT |
-						((ispccdc_obj.ccdcout_w - 1) <<
-						ISPCCDC_HORZ_INFO_NPH_SHIFT),
+			if (ispccdc_obj.ccdc_inpfmt == CCDC_RAW) {
+				omap_writel(1 << ISPCCDC_HORZ_INFO_SPH_SHIFT
+						| ((ispccdc_obj.ccdcout_w - 1)
+						<< ISPCCDC_HORZ_INFO_NPH_SHIFT),
+						ISPCCDC_HORZ_INFO);
+			} else {
+				omap_writel(0 << ISPCCDC_HORZ_INFO_SPH_SHIFT
+						| ((ispccdc_obj.ccdcout_w - 1)
+						<< ISPCCDC_HORZ_INFO_NPH_SHIFT),
 						ISPCCDC_HORZ_INFO);
+			}
 		}
 		omap_writel(0 << ISPCCDC_VERT_START_SLV0_SHIFT,
 							ISPCCDC_VERT_START);
@@ -1227,7 +1251,7 @@
 						ISPCCDC_VERT_LINES);
 
 		ispccdc_config_outlineoffset(ispccdc_obj.ccdcout_w * 2, 0, 0);
-		omap_writel((((ispccdc_obj.ccdcout_h - 1) &
+		omap_writel((((ispccdc_obj.ccdcout_h - 2) &
 					ISPCCDC_VDINT_0_MASK) <<
 					ISPCCDC_VDINT_0_SHIFT) |
 					((50 & ISPCCDC_VDINT_1_MASK) <<
Index: omapkernel/drivers/media/video/isp/ispccdc.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispccdc.h	2008-10-15 20:08:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispccdc.h	2008-10-15 20:08:36.000000000 -0500
@@ -209,4 +209,6 @@
 
 int omap34xx_isp_ccdc_config(void *userspace_add);
 
+void ispccdc_set_wenlog(u32 wenlog);
+
 #endif		/* OMAP_ISP_CCDC_H */
Index: omapkernel/drivers/media/video/isp/isppreview.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isppreview.c	2008-10-15 20:08:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isppreview.c	2008-10-15 20:08:36.000000000 -0500
@@ -184,6 +184,8 @@
 	enum preview_color_effect color;
 	enum cfa_fmt cfafmt;
 	struct mutex ispprev_mutex; /* For checking/modifying prev_inuse */
+	u32 sph;
+	u32 slv;
 } ispprev_obj;
 
 /* Saved parameters */
@@ -759,6 +761,18 @@
 EXPORT_SYMBOL(isppreview_config_datapath);
 
 /**
+ * isppreview_set_skip - Set the number of rows/columns that should be skipped.
+ *  h - Start Pixel Horizontal.
+ *  v - Start Line Vertical.
+ **/
+void isppreview_set_skip(u32 h, u32 v)
+{
+	ispprev_obj.sph = h;
+	ispprev_obj.slv = v;
+}
+EXPORT_SYMBOL(isppreview_set_skip);
+
+/**
  * isppreview_config_ycpos - Configure byte layout of YUV image.
  * @mode: Indicates the required byte layout.
  **/
@@ -1487,7 +1501,12 @@
 	if ((ispprev_obj.yenh_en) || (ispprev_obj.csup_en))
 		prevout_w -= 2;
 
-	prevout_w -= 4;
+	/* Start at the correct row/column by skipping
+	 * a Sensor specific amount.
+	 */
+	prevout_w -= ispprev_obj.sph;
+	prevout_h -= ispprev_obj.slv;
+
 
 	if (prevout_w % 2)
 		prevout_w -= 1;
@@ -1530,10 +1549,10 @@
 		return -EINVAL;
 	}
 
-	omap_writel((4 << ISPPRV_HORZ_INFO_SPH_SHIFT) |
+	omap_writel((ispprev_obj.sph << ISPPRV_HORZ_INFO_SPH_SHIFT) |
 						(ispprev_obj.previn_w - 1),
 						ISPPRV_HORZ_INFO);
-	omap_writel((0 << ISPPRV_VERT_INFO_SLV_SHIFT) |
+	omap_writel((ispprev_obj.slv << ISPPRV_VERT_INFO_SLV_SHIFT) |
 						(ispprev_obj.previn_h - 1),
 						ISPPRV_VERT_INFO);
 
@@ -1817,6 +1836,8 @@
 	}
 
 	/* Init values */
+	ispprev_obj.sph = 2;
+	ispprev_obj.slv = 0;
 	ispprev_obj.color = PREV_DEFAULT_COLOR;
 	ispprev_obj.contrast = ISPPRV_CONTRAST_DEF;
 	params->contrast = ISPPRV_CONTRAST_DEF;
Index: omapkernel/drivers/media/video/isp/isppreview.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isppreview.h	2008-10-15 20:08:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isppreview.h	2008-10-15 20:08:36.000000000 -0500
@@ -353,4 +353,6 @@
 
 int omap34xx_isp_tables_update(struct isptables_update *isptables_struct);
 
+void isppreview_set_skip(u32 h, u32 v);
+
 #endif/* OMAP_ISP_PREVIEW_H */
