From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/10] OMAP4: TWL: Add common omapdss supplies
Date: Tue, 20 Sep 2011 11:18:18 +0300
Message-ID: <1316506706-18941-3-git-send-email-tomi.valkeinen@ti.com>
References: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:53273 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753995Ab1ITISv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 04:18:51 -0400
Received: by bkbzt4 with SMTP id zt4so289339bkb.33
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 01:18:48 -0700 (PDT)
In-Reply-To: <1316506706-18941-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP DSS normally gets power from VCXIO on OMAP4. Add configuration for
this into twl-common.c

Mark VCXIO as always_on, as VCXIO is used by multiple components,
including the MPU, and turning it off when DSS doesn't need it would
lead the device to halt.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 4f6d216..52243577 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -235,6 +235,12 @@ static struct regulator_init_data omap4_vana_idata = {
 	},
 };
 
+static struct regulator_consumer_supply omap4_vcxio_supply[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.1"),
+};
+
 static struct regulator_init_data omap4_vcxio_idata = {
 	.constraints = {
 		.min_uV			= 1800000,
@@ -243,7 +249,10 @@ static struct regulator_init_data omap4_vcxio_idata = {
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
+		.always_on		= true,
 	},
+	.num_consumer_supplies	= ARRAY_SIZE(omap4_vcxio_supply),
+	.consumer_supplies	= omap4_vcxio_supply,
 };
 
 static struct regulator_init_data omap4_vusb_idata = {
-- 
1.7.4.1

