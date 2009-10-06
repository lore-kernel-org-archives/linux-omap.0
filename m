From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [OMAP] mmc: Add mux configuration for omap7xx
Date: Tue, 6 Oct 2009 06:54:06 -0700
Message-ID: <6cb013310910060654i7b90d8f3gfaada2cfa50b6cb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:38410 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbZJFNyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Oct 2009 09:54:36 -0400
Received: by mail-yx0-f199.google.com with SMTP id 37so3932974yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Oct 2009 06:54:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The MMC mux pins normally used by omap chips in devices.c
are different from what is needed by omap7xx chips.  This
change adds a conditional around the mux setup code to
enable the correct mux pins.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/devices.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 0680843..54f18e8 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -108,15 +108,22 @@ static inline void omap1_mmc_mux(struct
omap_mmc_platform_data *mmc_controller,
 			int controller_nr)
 {
 	if (controller_nr == 0) {
-		omap_cfg_reg(MMC_CMD);
-		omap_cfg_reg(MMC_CLK);
-		omap_cfg_reg(MMC_DAT0);
+		if (cpu_is_omap7xx()) {
+			omap_cfg_reg(MMC_7XX_CMD);
+			omap_cfg_reg(MMC_7XX_CLK);
+			omap_cfg_reg(MMC_7XX_DAT0);
+		} else {
+			omap_cfg_reg(MMC_CMD);
+			omap_cfg_reg(MMC_CLK);
+			omap_cfg_reg(MMC_DAT0);
+		}
+
 		if (cpu_is_omap1710()) {
 			omap_cfg_reg(M15_1710_MMC_CLKI);
 			omap_cfg_reg(P19_1710_MMC_CMDDIR);
 			omap_cfg_reg(P20_1710_MMC_DATDIR0);
 		}
-		if (mmc_controller->slots[0].wires == 4) {
+		if (mmc_controller->slots[0].wires == 4 && !cpu_is_omap7xx()) {
 			omap_cfg_reg(MMC_DAT1);
 			/* NOTE: DAT2 can be on W10 (here) or M15 */
 			if (!mmc_controller->slots[0].nomux)
-- 
1.5.6.3
