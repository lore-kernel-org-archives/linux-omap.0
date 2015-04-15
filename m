From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 03/35] ARM: OMAP2: n8x0: remove __initdata declarations from code
Date: Wed, 15 Apr 2015 15:52:50 +0300
Message-ID: <1429102402-5276-4-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47020 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbbDOMwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Apr 2015 08:52:39 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Parts of the n8x0 board support code is needed during pdata registration,
which will be moved later in the boot. Thus, it can't reside under __initdata
section anymore and must be moved out of it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/board-n8x0.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index b6443a4..d03a333 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -153,7 +153,7 @@ static struct omap2_mcspi_device_config p54spi_mcspi_config = {
 	.turbo_mode	= 0,
 };
 
-static struct spi_board_info n800_spi_board_info[] __initdata = {
+static struct spi_board_info n800_spi_board_info[] = {
 	{
 		.modalias	= "p54spi",
 		.bus_num	= 2,
@@ -569,11 +569,11 @@ static int n8x0_menelaus_late_init(struct device *dev)
 }
 #endif
 
-struct menelaus_platform_data n8x0_menelaus_platform_data __initdata = {
+struct menelaus_platform_data n8x0_menelaus_platform_data = {
 	.late_init = n8x0_menelaus_late_init,
 };
 
-struct aic3x_pdata n810_aic33_data __initdata = {
+struct aic3x_pdata n810_aic33_data = {
 	.gpio_reset = 118,
 };
 
@@ -593,7 +593,7 @@ omap_late_initcall(n8x0_late_initcall);
  * Legacy init pdata init for n8x0. Note that we want to follow the
  * I2C bus numbering starting at 0 for device tree like other omaps.
  */
-void * __init n8x0_legacy_init(void)
+void *n8x0_legacy_init(void)
 {
 	board_check_revision();
 	spi_register_board_info(n800_spi_board_info,
-- 
1.7.9.5

