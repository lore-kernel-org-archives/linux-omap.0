From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] HSMMC: Fix boot crash on boards without gpio_cd set
Date: Fri, 14 Nov 2008 21:45:16 +0200
Message-ID: <1226691917-6577-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:43101 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbYKNTpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 14:45:33 -0500
Received: by gv-out-0910.google.com with SMTP id e6so321415gvc.37
        for <linux-omap@vger.kernel.org>; Fri, 14 Nov 2008 11:45:31 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

If .gpio_cd is -EINVAL, twl_mmc_late_init() is not called and
hsmmc[x].mmc is not set, so don't use it in twl_mmc*_set_power().

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 0ea6ba6..626d668 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -239,6 +239,7 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 	u32 reg;
 	int ret = 0;
 	struct twl_mmc_controller *c = &hsmmc[0];
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
 	if (power_on) {
 		if (cpu_is_omap2430()) {
@@ -250,7 +251,7 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
 		}
 
-		if (c->mmc->slots[0].internal_clock) {
+		if (mmc->slots[0].internal_clock) {
 			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
 			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
 			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
@@ -293,11 +294,11 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 static int twl_mmc2_set_power(struct device *dev, int slot, int power_on, int vdd)
 {
 	int ret;
-
 	struct twl_mmc_controller *c = &hsmmc[1];
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
 
 	if (power_on) {
-		if (c->mmc->slots[0].internal_clock) {
+		if (mmc->slots[0].internal_clock) {
 			u32 reg;
 
 			reg = omap_ctrl_readl(control_devconf1_offset);
-- 
1.5.4.3

