From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 4/4] OMAP4: hwmod data: Fix alignment and end of line in structure fields
Date: Thu, 23 Dec 2010 23:30:32 +0100
Message-ID: <1293143432-9891-4-git-send-email-b-cousson@ti.com>
References: <1293143432-9891-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39182 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751656Ab0LWWbA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 17:31:00 -0500
In-Reply-To: <1293143432-9891-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

In order to be fully aligned with the Python generator output,
change a couple of fields.

- Add tab in class structures to align attributes
- Add a comma at the end of the following line to simplify
  the generation by having always the same eol:
  ".pre_shutdown   = &omap2_wd_timer_disable,"
- Add a blank line before the first entry of the
  omap44xx_hwmods array.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   43 ++++++++++++++-------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f35a99d..c2806bd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -66,7 +66,7 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod;
  * instance(s): dmm
  */
 static struct omap_hwmod_class omap44xx_dmm_hwmod_class = {
-	.name = "dmm",
+	.name	= "dmm",
 };
 
 /* dmm interface data */
@@ -121,7 +121,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
  * instance(s): emif_fw
  */
 static struct omap_hwmod_class omap44xx_emif_fw_hwmod_class = {
-	.name = "emif_fw",
+	.name	= "emif_fw",
 };
 
 /* emif_fw interface data */
@@ -170,7 +170,7 @@ static struct omap_hwmod omap44xx_emif_fw_hwmod = {
  * instance(s): l3_instr, l3_main_1, l3_main_2, l3_main_3
  */
 static struct omap_hwmod_class omap44xx_l3_hwmod_class = {
-	.name = "l3",
+	.name	= "l3",
 };
 
 /* l3_instr interface data */
@@ -347,7 +347,7 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
  * instance(s): l4_abe, l4_cfg, l4_per, l4_wkup
  */
 static struct omap_hwmod_class omap44xx_l4_hwmod_class = {
-	.name = "l4",
+	.name	= "l4",
 };
 
 /* l4_abe interface data */
@@ -461,7 +461,7 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
  * instance(s): mpu_private
  */
 static struct omap_hwmod_class omap44xx_mpu_bus_hwmod_class = {
-	.name = "mpu_bus",
+	.name	= "mpu_bus",
 };
 
 /* mpu_private interface data */
@@ -667,7 +667,7 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
  */
 
 static struct omap_hwmod_class omap44xx_dsp_hwmod_class = {
-	.name = "dsp",
+	.name	= "dsp",
 };
 
 /* dsp */
@@ -764,15 +764,15 @@ static struct omap_hwmod_class_sysconfig omap44xx_gpio_sysc = {
 };
 
 static struct omap_hwmod_class omap44xx_gpio_hwmod_class = {
-	.name = "gpio",
-	.sysc = &omap44xx_gpio_sysc,
-	.rev = 2,
+	.name	= "gpio",
+	.sysc	= &omap44xx_gpio_sysc,
+	.rev	= 2,
 };
 
 /* gpio dev_attr */
 static struct omap_gpio_dev_attr gpio_dev_attr = {
-	.bank_width = 32,
-	.dbck_flag = true,
+	.bank_width	= 32,
+	.dbck_flag	= true,
 };
 
 /* gpio1 */
@@ -1109,8 +1109,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 };
 
 static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
-	.name = "i2c",
-	.sysc = &omap44xx_i2c_sysc,
+	.name	= "i2c",
+	.sysc	= &omap44xx_i2c_sysc,
 };
 
 /* i2c1 */
@@ -1331,7 +1331,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
  */
 
 static struct omap_hwmod_class omap44xx_iva_hwmod_class = {
-	.name = "iva",
+	.name	= "iva",
 };
 
 /* iva */
@@ -1440,7 +1440,7 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
  */
 
 static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
-	.name = "mpu",
+	.name	= "mpu",
 };
 
 /* mpu */
@@ -1495,9 +1495,9 @@ static struct omap_hwmod_class_sysconfig omap44xx_smartreflex_sysc = {
 };
 
 static struct omap_hwmod_class omap44xx_smartreflex_hwmod_class = {
-	.name = "smartreflex",
-	.sysc = &omap44xx_smartreflex_sysc,
-	.rev  = 2,
+	.name	= "smartreflex",
+	.sysc	= &omap44xx_smartreflex_sysc,
+	.rev	= 2,
 };
 
 /* smartreflex_core */
@@ -1656,8 +1656,8 @@ static struct omap_hwmod_class_sysconfig omap44xx_uart_sysc = {
 };
 
 static struct omap_hwmod_class omap44xx_uart_hwmod_class = {
-	.name = "uart",
-	.sysc = &omap44xx_uart_sysc,
+	.name	= "uart",
+	.sysc	= &omap44xx_uart_sysc,
 };
 
 /* uart1 */
@@ -1889,7 +1889,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_wd_timer_sysc = {
 static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
 	.name		= "wd_timer",
 	.sysc		= &omap44xx_wd_timer_sysc,
-	.pre_shutdown	= &omap2_wd_timer_disable
+	.pre_shutdown	= &omap2_wd_timer_disable,
 };
 
 /* wd_timer2 */
@@ -2002,6 +2002,7 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 };
 
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
+
 	/* dmm class */
 	&omap44xx_dmm_hwmod,
 
-- 
1.7.0.4

