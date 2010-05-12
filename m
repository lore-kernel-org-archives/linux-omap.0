From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH] OMAP: Remove compilation warnings
Date: Wed, 12 May 2010 10:52:30 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E08FAEA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34963 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756663Ab0ELPwd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 11:52:33 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4CFqWdM020649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 10:52:32 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o4CFqVEo022849
	for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 10:52:31 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4CFqVEt002429
	for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 10:52:31 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Against for-next branch

---

Add __attribute__ ((unused))

  arch/arm/mach-omap2/clockdomains.h:58
 	warning: 'gfx_sgx_wkdeps' defined but not used
  arch/arm/mach-omap2/mux.c:52
 	warning: 'mux_phys' defined but not used

Initialize to 0

  arch/arm/plat-omap/gpio.c
 	In function 'omap2_gpio_resume_after_retention':
 	2131: warning: 'l' may be used uninitialized in this function
  arch/arm/plat-omap/gpio.c
 	In function 'omap2_gpio_prepare_for_retention':
 	2074: warning: 'l2' may be used uninitialized in this function
  arch/arm/plat-omap/gpio.c:2074
	warning: 'l1' may be used uninitialized in this function

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 arch/arm/mach-omap2/clockdomains.h |    2 +-
 arch/arm/mach-omap2/mux.c          |    2 +-
 arch/arm/plat-omap/gpio.c          |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index 8fc19ff..cf23547 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -55,7 +55,7 @@
  * These can share data since they will never be present simultaneously
  * on the same device.
  */
-static struct clkdm_dep gfx_sgx_wkdeps[] = {
+static __attribute__ ((unused)) struct clkdm_dep gfx_sgx_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 8b3d269..269449a 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -49,7 +49,7 @@ struct omap_mux_entry {
 	struct list_head	node;
 };
 
-static unsigned long mux_phys;
+static __attribute__ ((unused)) unsigned long mux_phys;
 static void __iomem *mux_base;
 
 u16 omap_mux_read(u16 reg)
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index dddc9d6..fffc7f2 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2071,7 +2071,7 @@ void omap2_gpio_prepare_for_retention(void)
 	 * IRQs will be generated.  See OMAP2420 Errata item 1.101. */
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l1, l2;
+		u32 l1 = 0, l2 = 0;
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
@@ -2128,7 +2128,7 @@ void omap2_gpio_resume_after_retention(void)
 		return;
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l, gen, gen0, gen1;
+		u32 l = 0, gen, gen0, gen1;
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
-- 
1.5.4.3

