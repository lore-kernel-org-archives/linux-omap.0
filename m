From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC PATCH 15/35] ARM: OMAP2+: twl: remove code from __init section
Date: Wed, 15 Apr 2015 15:53:02 +0300
Message-ID: <1429102402-5276-16-git-send-email-t-kristo@ti.com>
References: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52082 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755466AbbDOMw5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 08:52:57 -0400
In-Reply-To: <1429102402-5276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org

Needed by hwmod module boot.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c   |    4 ++--
 arch/arm/mach-omap2/twl-common.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 6bf6267..22ddd40 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -218,7 +218,7 @@ static struct omap_voltdm_pmic omap4_core_pmic = {
 	.uv_to_vsel		= twl6030_uv_to_vsel,
 };
 
-int __init omap4_twl_init(void)
+int omap4_twl_init(void)
 {
 	struct voltagedomain *voltdm;
 
@@ -237,7 +237,7 @@ int __init omap4_twl_init(void)
 	return 0;
 }
 
-int __init omap3_twl_init(void)
+int omap3_twl_init(void)
 {
 	struct voltagedomain *voltdm;
 
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 292eca0..2dd3440 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -34,7 +34,7 @@
 #include "voltage.h"
 #include "mux.h"
 
-static struct i2c_board_info __initdata pmic_i2c_board_info = {
+static struct i2c_board_info pmic_i2c_board_info = {
 	.addr		= 0x48,
 	.flags		= I2C_CLIENT_WAKE,
 };
@@ -85,7 +85,7 @@ void __init omap4_pmic_init(const char *pmic_type,
 }
 #endif
 
-void __init omap_pmic_late_init(void)
+void omap_pmic_late_init(void)
 {
 	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
 	if (!pmic_i2c_board_info.irq)
-- 
1.7.9.5

