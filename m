From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2] omap2: fix assorted compiler warnings
Date: Tue, 10 Aug 2010 16:58:06 +0530
Message-ID: <1281439686-23713-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41590 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab0HJL2S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Aug 2010 07:28:18 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7ABSEml016337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 06:28:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch fixes these compiler warnings:

  CC      arch/arm/mach-omap2/mux.o
arch/arm/mach-omap2/mux.c: In function 'omap_mux_init_gpio':
arch/arm/mach-omap2/mux.c:90: warning: 'gpio_mux' may be used uninitial
ized in this function

  CC      arch/arm/plat-omap/gpio.o
arch/arm/plat-omap/gpio.c: In function 'omap2_gpio_resume_after_idle':
arch/arm/plat-omap/gpio.c:2152: warning: 'l' may be used uninitialized
in this function
arch/arm/plat-omap/gpio.c: In function 'omap2_gpio_prepare_for_idle':
arch/arm/plat-omap/gpio.c:2085: warning: 'l2' may be used uninitialized
in this function
arch/arm/plat-omap/gpio.c:2085: warning: 'l1' may be used uninitialized
in this function

  CC      arch/arm/mach-omap2/board-omap4panda.o
arch/arm/mach-omap2/board-omap4panda.c: In function 'omap4_panda_init':
arch/arm/mach-omap2/board-omap4panda.c:277: warning: unused variable 's
tatus'

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    2 --
 arch/arm/mach-omap2/mux.c              |    2 +-
 arch/arm/plat-omap/gpio.c              |    4 ++--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c03d1d5..96f5bbb 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -274,8 +274,6 @@ static int __init omap4_panda_i2c_init(void)
 }
 static void __init omap4_panda_init(void)
 {
-	int status;
-
 	omap4_panda_i2c_init();
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index ab403b2..6c2f8f0 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -87,7 +87,7 @@ static char *omap_mux_options;
 int __init omap_mux_init_gpio(int gpio, int val)
 {
 	struct omap_mux_entry *e;
-	struct omap_mux *gpio_mux;
+	struct omap_mux *gpio_mux = NULL;
 	u16 old_mode;
 	u16 mux_mode;
 	int found = 0;
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 9b7e354..ba3b9ab 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2082,7 +2082,7 @@ void omap2_gpio_prepare_for_idle(int power_state)
 
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l1, l2;
+		u32 l1 = 0, l2 = 0;
 
 		if (bank->dbck_enable_mask)
 			clk_disable(bank->dbck);
@@ -2149,7 +2149,7 @@ void omap2_gpio_resume_after_idle(void)
 		min = 1;
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l, gen, gen0, gen1;
+		u32 l = 0, gen, gen0, gen1;
 
 		if (bank->dbck_enable_mask)
 			clk_enable(bank->dbck);
-- 
1.6.6.1

