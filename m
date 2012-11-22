From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2] OMAP: board-files: fix i2c_bus for tfp410
Date: Thu, 22 Nov 2012 10:39:56 +0200
Message-ID: <1353573596-5550-1-git-send-email-tomi.valkeinen@ti.com>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56334 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236Ab2KVTMJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Nov 2012 14:12:09 -0500
In-Reply-To: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Thomas Weber <thomas@tomweber.eu>, stable@vger.kernel.org

The i2c handling in tfp410 driver, which handles converting parallel RGB
to DVI, was changed in 958f2717b84e88bf833d996997fda8f73276f2af
(OMAPDSS: TFP410: pdata rewrite). The patch changed what value the
driver considers as invalid/undefined.  Before the patch, 0 was the
invalid value, but as 0 is a valid bus number, the patch changed this to
-1.

However, the fact was missed that many board files do not define the bus
number at all, thus it's left to 0. This causes the driver to fail to
get the i2c bus, exiting from the driver's probe with an error, meaning
that the DVI output does not work for those boards.

This patch fixes the issue by changing the i2c_bus number field in the
driver's platform data from u16 to int, and setting the bus number to -1
in the board files for the boards that did not define the bus. The
exception is devkit8000, for which the bus is set to 1, which is the
correct bus for that board.

The bug exists in v3.5+ kernels.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Thomas Weber <thomas@tomweber.eu>
Cc: Thomas Weber <thomas@tomweber.eu>
Cc: <stable@vger.kernel.org> # v3.5+
---
 arch/arm/mach-omap2/board-3430sdp.c      |    1 +
 arch/arm/mach-omap2/board-am3517evm.c    |    1 +
 arch/arm/mach-omap2/board-cm-t35.c       |    1 +
 arch/arm/mach-omap2/board-devkit8000.c   |    1 +
 arch/arm/mach-omap2/board-omap3evm.c     |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c |    1 +
 include/video/omap-panel-tfp410.h        |    2 +-
 7 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 96cd369..09e1790 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -157,6 +157,7 @@ static struct omap_dss_device sdp3430_lcd_device = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
+	.i2c_bus_num		= -1,
 };
 
 static struct omap_dss_device sdp3430_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index e162897..f2a920a 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -208,6 +208,7 @@ static struct omap_dss_device am3517_evm_tv_device = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
+	.i2c_bus_num		= -1,
 };
 
 static struct omap_dss_device am3517_evm_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 376d26e..7ed0270 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -243,6 +243,7 @@ static struct omap_dss_device cm_t35_lcd_device = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= CM_T35_DVI_EN_GPIO,
+	.i2c_bus_num		= -1,
 };
 
 static struct omap_dss_device cm_t35_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 1fd161e..6f04f0f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -139,6 +139,7 @@ static struct omap_dss_device devkit8000_lcd_device = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= -1,
+	.i2c_bus_num		= 1,
 };
 
 static struct omap_dss_device devkit8000_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b9b776b..5631eb9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -236,6 +236,7 @@ static struct omap_dss_device omap3_evm_tv_device = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= OMAP3EVM_DVI_PANEL_EN_GPIO,
+	.i2c_bus_num		= -1,
 };
 
 static struct omap_dss_device omap3_evm_dvi_device = {
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 731235e..797be22 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -119,6 +119,7 @@ static struct omap_dss_device omap3_stalker_tv_device = {
 
 static struct tfp410_platform_data dvi_panel = {
 	.power_down_gpio	= DSS_ENABLE_GPIO,
+	.i2c_bus_num		= -1,
 };
 
 static struct omap_dss_device omap3_stalker_dvi_device = {
diff --git a/include/video/omap-panel-tfp410.h b/include/video/omap-panel-tfp410.h
index 68c31d7..aef35e4 100644
--- a/include/video/omap-panel-tfp410.h
+++ b/include/video/omap-panel-tfp410.h
@@ -28,7 +28,7 @@ struct omap_dss_device;
  * @power_down_gpio: gpio number for PD pin (or -1 if not available)
  */
 struct tfp410_platform_data {
-	u16 i2c_bus_num;
+	int i2c_bus_num;
 	int power_down_gpio;
 };
 
-- 
1.7.10.4

