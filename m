From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 2/3] arm: omap3: cm-t35: fix slow path warning
Date: Wed, 15 Jun 2011 00:16:13 +0300
Message-ID: <1308086174-3080-2-git-send-email-grinberg@compulab.co.il>
References: <20110614073648.GI3352@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:38858
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752366Ab1FNVQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jun 2011 17:16:18 -0400
In-Reply-To: <20110614073648.GI3352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>

Fix warning issued by gpio_set_value() call with TPS gpios.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 6c5881b..256b81c 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -466,9 +466,9 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	if (gpio_request_one(wlan_rst, GPIOF_OUT_INIT_HIGH, "WLAN RST") == 0) {
 		gpio_export(wlan_rst, 0);
 		udelay(10);
-		gpio_set_value(wlan_rst, 0);
+		gpio_set_value_cansleep(wlan_rst, 0);
 		udelay(10);
-		gpio_set_value(wlan_rst, 1);
+		gpio_set_value_cansleep(wlan_rst, 1);
 	} else {
 		pr_err("CM-T35: could not obtain gpio for WiFi reset\n");
 	}
-- 
1.7.3.4

