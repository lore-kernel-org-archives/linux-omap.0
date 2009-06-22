From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/12] OMAP2/3: mmc-twl4030: use correct controller in
	twl_mmc23_set_power
Date: Mon, 22 Jun 2009 14:42:17 +0300
Message-ID: <20090622114217.28477.43701.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64577 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbZFVLmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:42:24 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

From: Grazvydas Ignotas <notasas@gmail.com>

twl_mmc23_set_power() has MMC2 twl_mmc_controller hardcoded in it, which
breaks MMC3. Find the right controller to use instead.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 9756a87..1541fd4 100644
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

