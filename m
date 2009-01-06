From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [OMAPZOOM][PATCH 5/7] MT9P012: QVGA 30fps issue fix
Date: Tue, 6 Jan 2009 14:42:03 -0600
Message-ID: <A24693684029E5489D1D202277BE894416328062@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53339 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187AbZAFUmL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 15:42:11 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n06Kg6mo005843
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:11 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n06Kg6qa007699
	for <linux-omap@vger.kernel.org>; Tue, 6 Jan 2009 14:42:06 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

>From 346441c2b0ba1fbcc14b3e0a799919ee9b831d07 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 6 Jan 2009 14:17:34 -0600
Subject: [PATCH] MT9P012: QVGA 30fps issue fix

This patch will avoid the black band seen during the
QVGA 30 fps streaming and also improves the image
quality

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/mt9p012.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/mt9p012.c b/drivers/media/video/mt9p012.c
index 7633086..8765eb0 100755
--- a/drivers/media/video/mt9p012.c
+++ b/drivers/media/video/mt9p012.c
@@ -706,11 +706,11 @@ unsigned char enter_video_648_30fps_buf[][6] = {
 	/* hold */
 	{I2C_REG_GROUPED_PAR_HOLD, 0x00, 0x01, 0x00, 0x00},
 	{I2C_REG_VT_PIX_CLK_DIV, 0x00, 0x05, 0x00, 0x00},
-	{I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
-	{I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x03, 0x00, 0x00},
+	{I2C_REG_VT_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
+	{I2C_REG_PRE_PLL_CLK_DIV, 0x00, 0x06, 0x00, 0x00},
 	{I2C_REG_PLL_MULTIPLIER, 0x00, 0xc0, 0x00, 0x00},
 	{I2C_REG_OP_PIX_CLK_DIV, 0x00, 0x0a, 0x00, 0x00},
-	{I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x02, 0x00, 0x00},
+	{I2C_REG_OP_SYS_CLK_DIV, 0x00, 0x01, 0x00, 0x00},
 	{I2C_REG_RESERVED_MFR_3064, 0x08, 0x05, 0x00, 0x00},
 	{I2C_REG_X_OUTPUT_SIZE, I2C_VIDEO_WIDTH_4X_BINN},
 	{I2C_REG_Y_OUTPUT_SIZE, I2C_VIDEO_HEIGHT_4X_BINN},
@@ -1168,7 +1168,7 @@ static struct mt9p012_pll_settings all_pll_settings[] = {
 	.fine_int_tm = 1794, .frame_lines = 574, .line_len = 2712,
 	.min_pll = 92, .max_pll = 128},
 	/* PLL_648_30FPS */
-	{.vt_pix_clk_div = 5, .vt_sys_clk_div = 2, .pre_pll_div = 3,
+	{.vt_pix_clk_div = 5, .vt_sys_clk_div = 1, .pre_pll_div = 6,
 	.fine_int_tm = 1794, .frame_lines = 1374, .line_len = 3712,
 	.min_pll = 96, .max_pll = 192},
 	/* PLL_216_15FPS */
-- 
1.5.6.5

