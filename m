From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 3/6] OMAP: mmc-twl4030 add cover switch
Date: Tue, 10 Mar 2009 11:33:16 +0200
Message-ID: <20090310093316.16889.58719.sendpatchset@ahunter-laptop>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55377 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070AbZCJJdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 05:33:18 -0400
In-Reply-To: <20090310093255.16889.30509.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, David Brownell <david-b@pacbell.net>, linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 1667cd29afa90d041c0782223253835e6bc25b18 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 26 Jan 2009 13:14:28 +0200
Subject: [PATCH] OMAP: mmc-twl4030 add cover switch

Allow a cover switch to be used to cause a rescan of the
MMC slot.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/mmc-twl4030.c |   13 ++++++++++++-
 arch/arm/mach-omap2/mmc-twl4030.h |    1 +
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 736b039..a58deba 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -105,6 +105,14 @@ static int twl_mmc_get_ro(struct device *dev, int slot)
 	return gpio_get_value_cansleep(mmc->slots[0].gpio_wp);
 }
 
+static int twl_mmc_get_cover_state(struct device *dev, int slot)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	/* NOTE: assumes card detect signal is active-low */
+	return !gpio_get_value_cansleep(mmc->slots[0].switch_pin);
+}
+
 /*
  * MMC Slot Initialization.
  */
@@ -427,7 +435,10 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 
 			mmc->slots[0].switch_pin = c->gpio_cd;
 			mmc->slots[0].card_detect_irq = gpio_to_irq(c->gpio_cd);
-			mmc->slots[0].card_detect = twl_mmc_card_detect;
+			if (c->cover_only)
+				mmc->slots[0].get_cover_state = twl_mmc_get_cover_state;
+			else
+				mmc->slots[0].card_detect = twl_mmc_card_detect;
 		} else
 			mmc->slots[0].switch_pin = -EINVAL;
 
diff --git a/arch/arm/mach-omap2/mmc-twl4030.h b/arch/arm/mach-omap2/mmc-twl4030.h
index 087a969..e87bc8d 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.h
+++ b/arch/arm/mach-omap2/mmc-twl4030.h
@@ -12,6 +12,7 @@ struct twl4030_hsmmc_info {
 	bool	transceiver;	/* MMC-2 option */
 	bool	ext_clock;	/* use external pin for input clock */
 	bool	vsim_18v;	/* MMC-2 option */
+	bool	cover_only;	/* No card detect - just cover switch */
 	int	gpio_cd;	/* or -EINVAL */
 	int	gpio_wp;	/* or -EINVAL */
 	struct device *dev;	/* returned: pointer to mmc adapter */
-- 
1.5.6.3

