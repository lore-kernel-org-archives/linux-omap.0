From: "Stanley.Miao" <stanley.miao@windriver.com>
Subject: [PATCH 09/11] omap: init the gpio pinmux for mmc
Date: Tue, 13 Apr 2010 17:34:28 +0800
Message-ID: <1271151270-13038-1-git-send-email-stanley.miao@windriver.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:51513 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab0DMJZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 05:25:57 -0400
In-Reply-To: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, madhu.cr@ti.com

There is two gpio for mmc use, one is for card detecting, another is
used for checking write protect. Intialize its pinmux in case the bootloader
doesn't set it.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
---
 arch/arm/mach-omap2/devices.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 23e4d77..df9c62a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -591,6 +591,13 @@ static inline void omap_hsmmc_reset(void) {}
 static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
+	if (mmc_controller->slots[0].switch_pin > 0)
+		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
+					OMAP_PIN_INPUT_PULLUP);
+	if (mmc_controller->slots[0].gpio_wp > 0)
+		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
+					OMAP_PIN_INPUT_PULLUP);
+
 	if (cpu_is_omap2420() && controller_nr == 0) {
 		omap_cfg_reg(H18_24XX_MMC_CMD);
 		omap_cfg_reg(H15_24XX_MMC_CLKI);
-- 
1.5.4.3

