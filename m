From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/5] OMAP2/3: mmc-twl4030: Free up MMC regulators while
	cleaning up
Date: Thu, 6 Aug 2009 09:52:55 +0300
Message-ID: <20090806065254.GA7374@atomide.com>
References: <20090805141051.1964.74687.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60574 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZHFGxC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 02:53:02 -0400
Content-Disposition: inline
In-Reply-To: <20090805141051.1964.74687.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

One more patch I missed below.

Tony

--JYK4vJDZwFMowpUq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mmc-free-regulators.patch"

>From 8b28d125dcfa4a250a897baa2425d1f30dd56219 Mon Sep 17 00:00:00 2001
From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Thu, 6 Aug 2009 09:49:18 +0300
Subject: [PATCH] OMAP2/3: mmc-twl4030: Free up MMC regulators while cleaning up

twl_mmc_cleanup() must free up the regulators that were
allocated by twl_mmc_late_init().
This eliminates the below error when 'omap_hsmmc' module is
repeatedly loaded and unloaded.

"sysfs: cannot create duplicate filename '/devices/platform
 /mmci-omap-hs.0/microamps_requested_vmmc'"

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 1541fd4..3c04c2f 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -119,6 +119,7 @@ static int twl_mmc_late_init(struct device *dev)
 				if (i != 0)
 					break;
 				ret = PTR_ERR(reg);
+				hsmmc[i].vcc = NULL;
 				goto err;
 			}
 			hsmmc[i].vcc = reg;
@@ -165,8 +166,13 @@ done:
 static void twl_mmc_cleanup(struct device *dev)
 {
 	struct omap_mmc_platform_data *mmc = dev->platform_data;
+	int i;
 
 	gpio_free(mmc->slots[0].switch_pin);
+	for(i = 0; i < ARRAY_SIZE(hsmmc); i++) {
+		regulator_put(hsmmc[i].vcc);
+		regulator_put(hsmmc[i].vcc_aux);
+	}
 }
 
 #ifdef CONFIG_PM

--JYK4vJDZwFMowpUq--
