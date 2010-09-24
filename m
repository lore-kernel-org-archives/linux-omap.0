From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/11] omap2: fix assorted compiler warnings
Date: Thu, 23 Sep 2010 18:50:43 -0700
Message-ID: <20100924015043.10325.3528.stgit@baageli.muru.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49580 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab0IXBuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 21:50:46 -0400
In-Reply-To: <20100924014938.10325.35279.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>

From: Sanjeev Premi <premi@ti.com>

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
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
index 11c5b0e..c05c653 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2084,7 +2084,7 @@ void omap2_gpio_prepare_for_idle(int power_state)
 
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l1, l2;
+		u32 l1 = 0, l2 = 0;
 		int j;
 
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)
@@ -2152,7 +2152,7 @@ void omap2_gpio_resume_after_idle(void)
 		min = 1;
 	for (i = min; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l, gen, gen0, gen1;
+		u32 l = 0, gen, gen0, gen1;
 		int j;
 
 		for (j = 0; j < hweight_long(bank->dbck_enable_mask); j++)

