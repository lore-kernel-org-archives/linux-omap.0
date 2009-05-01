From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] mmc-twl4030: use correct controller in twl_mmc23_set_power
Date: Fri,  1 May 2009 17:22:09 +0300
Message-ID: <1241187729-11212-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:47590 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755602AbZEAOWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 May 2009 10:22:16 -0400
Received: by bwz7 with SMTP id 7so2334742bwz.37
        for <linux-omap@vger.kernel.org>; Fri, 01 May 2009 07:22:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>, David Brownell <david-b@pacbell.net>

twl_mmc23_set_power() has MMC2 twl_mmc_controller hardcoded in it, which
breaks MMC3. Find the right controller to use instead.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Cc: David Brownell <david-b@pacbell.net>
---
 arch/arm/mach-omap2/mmc-twl4030.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 46d6e9b..9928e72 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -263,8 +263,19 @@ static int twl_mmc1_set_power(struct device *dev, int slot, int power_on,
 static int twl_mmc23_set_power(struct device *dev, int slot, int power_on, int vdd)
 {
 	int ret = 0;
-	struct twl_mmc_controller *c = &hsmmc[1];
+	struct twl_mmc_controller *c = NULL;
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(hsmmc); i++) {
+		if (mmc == hsmmc[i].mmc) {
+			c = &hsmmc[i];
+			break;
+		}
+	}
+
+	if (c == NULL)
+		return -ENODEV;
 
 	/* If we don't see a Vcc regulator, assume it's a fixed
 	 * voltage always-on regulator.
-- 
1.5.6.3

