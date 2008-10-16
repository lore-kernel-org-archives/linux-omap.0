From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 7/28] [OMAPZOOM] OMAP: CAM: ISP: Backend Fixes
Date: Wed, 15 Oct 2008 20:21:33 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256883E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50006 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbYJPBVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:21:41 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1LZWh007995
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:21:40 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1LZYD008160
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:21:35 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: ISP: Backend Fixes

This patch Adds the following changes:
ISP Preview
 - Remove table address and data from register context save/restore.
 - Added PCR register to context save/restore.
 - Added lower boundary checking for image size in try_size function.

ISP Resizer
 - Fixed default coefficients to be on sync with CDP
 - Added lower boundary check for resizer input size.

Signed-off-by: Vaibhav Hiremat <hvaibhav@ti.com>
Signed-off-by: Troy Laramy <t-laramy@ti.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isppreview.c |    8 ++++-
 drivers/media/video/isp/isppreview.h |    4 +-
 drivers/media/video/isp/ispresizer.c |   48 +++++++++++++++++++----------------
 3 files changed, 35 insertions(+), 25 deletions(-)

Index: omapkernel/drivers/media/video/isp/isppreview.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isppreview.c        2008-10-14 10:04:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isppreview.c     2008-10-14 10:12:29.000000000 -0500
@@ -65,12 +65,11 @@
        {ISPPRV_CNT_BRT, 0x0000},
        {ISPPRV_CSUP, 0x0000},
        {ISPPRV_SETUP_YC, 0x0000},
-       {ISPPRV_SET_TBL_ADDR, 0x0000},
-       {ISPPRV_SET_TBL_DATA, 0x0000},
        {ISPPRV_CDC_THR0, 0x0000},
        {ISPPRV_CDC_THR1, 0x0000},
        {ISPPRV_CDC_THR2, 0x0000},
        {ISPPRV_CDC_THR3, 0x0000},
+       {ISPPRV_PCR, 0x0000},
        {ISP_TOK_TERM, 0x0000}
 };

@@ -1437,6 +1436,11 @@
        ispprev_obj.previn_w = input_w;
        ispprev_obj.previn_h = input_h;

+       if (input_w < 32 || input_h < 32) {
+               printk(KERN_ERR "ISP_ERR : preview does not support "
+                               "width < 16 or height < 32 \n");
+               return -EINVAL;
+       }
        if (is_sil_rev_equal_to(OMAP3430_REV_ES1_0))
                max_out = ISPPRV_MAXOUTPUT_WIDTH;
        else
Index: omapkernel/drivers/media/video/isp/isppreview.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isppreview.h        2008-10-14 10:04:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isppreview.h     2008-10-14 10:12:29.000000000 -0500
@@ -91,8 +91,8 @@

 enum preview_color_effect {
        PREV_DEFAULT_COLOR = 0,
-       PREV_BW_COLOR = 1,
-       PREV_SEPIA_COLOR = 2
+       PREV_SEPIA_COLOR = 1,
+       PREV_BW_COLOR = 2
 };


Index: omapkernel/drivers/media/video/isp/ispresizer.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispresizer.c        2008-10-14 10:04:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispresizer.c     2008-10-14 10:12:29.000000000 -0500
@@ -33,14 +33,14 @@
 static struct isprsz_yenh ispreszdefaultyenh = {0, 0, 0, 0};
 static struct isprsz_coef ispreszdefcoef = {
        {
-               0x0000, 0x0100, 0x0000, 0x0000,
-               0x03FA, 0x00F6, 0x0010, 0x0000,
-               0x03F9, 0x00DB, 0x002C, 0x0000,
-               0x03FB, 0x00B3, 0x0053, 0x03FF,
-               0x03FD, 0x0082, 0x0084, 0x03FD,
-               0x03FF, 0x0053, 0x00B3, 0x03FB,
-               0x0000, 0x002C, 0x00DB, 0x03F9,
-               0x0000, 0x0010, 0x00F6, 0x03FA
+               0x0027, 0x00B2, 0x00B2, 0x0027,
+               0x0027, 0x00B2, 0x0027, 0x00B2,
+               0x0027, 0x00B2, 0x0027, 0x00B2,
+               0x0027, 0x00B2, 0x0027, 0x00B2,
+               0x0027, 0x00B2, 0x0027, 0x00B2,
+               0x0027, 0x00B2, 0x0027, 0x00B2,
+               0x0027, 0x00B2, 0x0027, 0x00B2,
+               0x0027, 0x00B2, 0x0027, 0x00B2,
        },
        {
                0x0000, 0x0100, 0x0000, 0x0000,
@@ -53,13 +53,13 @@
                0x0000, 0x0010, 0x00F6, 0x03FA
        },
        {
-               0x0004, 0x0023, 0x005A, 0x0058,
-               0x0023, 0x0004, 0x0000, 0x0002,
-               0x0018, 0x004d, 0x0060, 0x0031,
-               0x0008, 0x0000, 0x0001, 0x000f,
-               0x003f, 0x0062, 0x003f, 0x000f,
-               0x0001, 0x0000, 0x0008, 0x0031,
-               0x0060, 0x004d, 0x0018, 0x0002
+               0x0004, 0x0023, 0x0023, 0x005A,
+               0x005A, 0x0058, 0x0058, 0x0004,
+               0x0023, 0x0023, 0x005A, 0x005A,
+               0x0058, 0x0058, 0x0004, 0x0023,
+               0x0023, 0x005A, 0x005A, 0x0058,
+               0x0058, 0x0004, 0x0023, 0x0023,
+               0x005A, 0x005A, 0x0058, 0x0058
        },
        {
                0x0004, 0x0023, 0x005A, 0x0058,
@@ -335,6 +335,12 @@
        input_w = *input_width;
        input_h = *input_height;

+       if (input_w < 32 || input_h < 32) {
+               DPRINTK_ISPCCDC("ISP_ERR: RESIZER cannot handle input width"
+                               " less than 32 pixels or height less than"
+                               " 32\n");
+               return -EINVAL;
+       }
        input_w -= 6;
        input_h -= 6;

@@ -536,6 +542,7 @@
                                                h_filter_coef_4tap[j + 1] <<
                                                ISPRSZ_HFILT10_COEF1_SHIFT),
                                                ISPRSZ_HFILT10 + (i * 0x04));
+                       j += 2;
                }
        } else {
                j = 0;
@@ -606,14 +613,13 @@
  **/
 void ispresizer_enable(u8 enable)
 {
+       int val;
        DPRINTK_ISPRESZ("+ispresizer_enable()+\n");
        if (enable)
-               omap_writel((omap_readl(ISPRSZ_PCR)) | ISPRSZ_PCR_ENABLE,
-                                                               ISPRSZ_PCR);
-       else {
-               omap_writel((omap_readl(ISPRSZ_PCR)) & ~ISPRSZ_PCR_ENABLE,
-                                                               ISPRSZ_PCR);
-       }
+               val = (((omap_readl(ISPRSZ_PCR)) & 0x2) | ISPRSZ_PCR_ENABLE);
+       else
+               val = (omap_readl(ISPRSZ_PCR) & ~ISPRSZ_PCR_ENABLE);
+       omap_writel(val, ISPRSZ_PCR);
        DPRINTK_ISPRESZ("+ispresizer_enable()-\n");
 }
 EXPORT_SYMBOL(ispresizer_enable);
