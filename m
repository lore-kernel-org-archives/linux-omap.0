From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/2] omap3sdp: Fix regulator mapping for ads7846 TS controller
Date: Thu,  3 Feb 2011 17:01:44 +0530
Message-ID: <1296732705-12818-2-git-send-email-rnayak@ti.com>
References: <1296732705-12818-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51043 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756250Ab1BCLbz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 06:31:55 -0500
In-Reply-To: <1296732705-12818-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On the OMAP3430SDP board, the ads7846 touchscreen controller
is powered by VAUX3 regulator (supplying 2.8v).
Fix this mapping in the board file, and hence prevent
the ads7846 driver init to fail with the below error..

ads7846 spi1.0: unable to get regulator: -19

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index d4e41ef..dcdc718 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -427,6 +427,10 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
 	.irq_line	= 1,
 };
 
+/* ads7846 on SPI */
+static struct regulator_consumer_supply sdp3430_vaux3_supply =
+	REGULATOR_SUPPLY("vcc", "spi1.0");
+
 /*
  * Apply all the fixed voltages since most versions of U-Boot
  * don't bother with that initialization.
@@ -469,6 +473,8 @@ static struct regulator_init_data sdp3430_vaux3 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies		= 1,
+	.consumer_supplies		= &sdp3430_vaux3_supply,
 };
 
 /* VAUX4 for OMAP VDD_CSI2 (camera) */
-- 
1.7.0.4

