From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP: Fix i2c init for twl4030
Date: Wed, 28 Sep 2011 14:48:19 -0700
Message-ID: <20110928214819.29263.83936.stgit@kaulin.local>
References: <20110928214707.29263.58095.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35108 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753196Ab1I1VsU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 17:48:20 -0400
In-Reply-To: <20110928214707.29263.58095.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Looks like 2600 kHz rate does not work reliably on 2430,
so just use the 100 kHz rate.

Otherwise the system often fails to boot properly with:

omap_i2c omap_i2c.2: timeout waiting for bus ready
omap_i2c omap_i2c.2: timeout waiting for bus ready
twl: i2c_write failed to transfer all messages
omap_i2c omap_i2c.2: timeout waiting for bus ready
twl: i2c_write failed to transfer all messages
omap_i2c omap_i2c.2: timeout waiting for bus ready
twl: i2c_write failed to transfer all messages
twl: clock init err [-110]
omap_i2c omap_i2c.2: timeout waiting for bus ready
twl: i2c_write failed to transfer all messages
TWL4030 Unable to unlock IDCODE registers --110

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 2028464..f79b7d2 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -193,7 +193,8 @@ static int __init omap2430_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
 			ARRAY_SIZE(sdp2430_i2c1_boardinfo));
-	omap2_pmic_init("twl4030", &sdp2430_twldata);
+	omap_pmic_init(2, 100, "twl4030", INT_24XX_SYS_NIRQ,
+			&sdp2430_twldata);
 	return 0;
 }
 

