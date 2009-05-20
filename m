From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: PM: SDRC: ensure mux of SDRC clock enable pins for self-refresh
Date: Wed, 20 May 2009 09:08:19 -0700
Message-ID: <1242835699-11113-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:37448 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbZETQIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 12:08:21 -0400
Received: by wf-out-1314.google.com with SMTP id 26so177482wfd.4
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 09:08:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: mikechan@google.com, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>

For SDRAM self-refresh to work properly, the SDRC clock-enable pins
for both chip selects must be mux'd properly.

Since these pins are not shared with anything else (according to ES3.1
TRM ver. P), they should always be mux'd in the SDRC mode (mode 0.)

Special thanks to Paul Walmsley for pointing this out.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/mux.c             |    5 +++++
 arch/arm/mach-omap2/sdrc.c            |    8 ++++++++
 arch/arm/plat-omap/include/mach/mux.h |    3 +++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 026c4fc..4ed8047 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,11 @@ MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+
+MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index c832d83..d7807e2 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -136,5 +136,13 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sp)
 		(1 << SDRC_POWER_PWDENA_SHIFT) |
 		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
 	sdrc_write_reg(l, SDRC_POWER);
+
+	/* Ensure SDRC pins for both chip selcts are mux'd properly
+	 * for self-refresh */
+	if (cpu_is_omap34xx()) {
+		omap_cfg_reg(H16_34XX_SDRC_CKE0);
+		omap_cfg_reg(H17_34XX_SDRC_CKE1);
+	}
+
 	omap2_sms_save_context();
 }
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index f7e298a..9795d8d 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -803,6 +803,9 @@ enum omap34xx_index {
 	AE5_34XX_GPIO143,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
+
+	H16_34XX_SDRC_CKE0,
+	H17_34XX_SDRC_CKE1,
 };
 
 struct omap_mux_cfg {
-- 
1.6.2.2

