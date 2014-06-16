From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Change hardreset soc_ops for
 AM43XX
Date: Mon, 16 Jun 2014 01:56:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406160150590.659@utopia.booyaka.com>
References: <1402347553-26029-1-git-send-email-d-gerlach@ti.com> <alpine.DEB.2.02.1406131939180.340@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:33994 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbaFPB4b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jun 2014 21:56:31 -0400
In-Reply-To: <alpine.DEB.2.02.1406131939180.340@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, 13 Jun 2014, Paul Walmsley wrote:

> On Mon, 9 Jun 2014, Dave Gerlach wrote:
> 
> > am43xx reset register layout is more similar to am33xx than omap4 so
> > use the am33xx functions for hwmod hardreset soc_ops rather than the
> > currently used omap4 functions. Without this, assert_hardreset and
> > deassert_hardreset will not work on am43xx.
> > 
> > Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> 
> Makes sense to me; queued for v3.16-rc.

The patch failed a build test for an AM43xx-only config:

----
arch/arm/mach-omap2/built-in.o: In function `_am33xx_is_hardreset_asserted':
arch/arm/mach-omap2/omap_hwmod.c:3223: undefined reference to `am33xx_prm_is_hardreset_asserted'
arch/arm/mach-omap2/built-in.o: In function `_am33xx_deassert_hardreset':
arch/arm/mach-omap2/omap_hwmod.c:3201: undefined reference to `am33xx_prm_deassert_hardreset'
arch/arm/mach-omap2/built-in.o: In function `_am33xx_assert_hardreset':
arch/arm/mach-omap2/omap_hwmod.c:3181: 
undefined reference to `am33xx_prm_assert_hardreset'
make: *** [vmlinux] Error 1
----

I went ahead and modified the patch to build (updated patch below), but it 
would be helpful if you could also build-test your AM43xx-specific patches 
with an AM43xx-specific .config (along with the usual 
omap2plus_defconfig).


- Paul

From: Dave Gerlach <d-gerlach@ti.com>
Date: Sun, 15 Jun 2014 16:02:17 -0600
Subject: [PATCH 1/2] ARM: OMAP2+: hwmod: Change hardreset soc_ops for AM43XX

am43xx reset register layout is more similar to am33xx than omap4 so
use the am33xx functions for hwmod hardreset soc_ops rather than the
currently used omap4 functions. Without this, assert_hardreset and
deassert_hardreset will not work on am43xx.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
[paul@pwsan.com: fixed build errors for an AM43xx-only Kconfig]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile     | 6 ++++--
 arch/arm/mach-omap2/cm33xx.h     | 2 +-
 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8421f38cf445..7a695362aee7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -110,14 +110,16 @@ obj-y					+= prm_common.o cm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prm2xxx_3xxx.o prm3xxx.o cm3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
-obj-$(CONFIG_SOC_AM33XX)		+= prm33xx.o cm33xx.o
 omap-prcm-4-5-common			=  cminst44xx.o cm44xx.o prm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o \
 					   vc44xx_data.o vp44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_DRA7XX)		+= $(omap-prcm-4-5-common)
-obj-$(CONFIG_SOC_AM43XX)		+= $(omap-prcm-4-5-common)
+am33xx-43xx-prcm-common			+= prm33xx.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(am33xx-43xx-prcm-common) cm33xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(omap-prcm-4-5-common) \
+					   $(am33xx-43xx-prcm-common)
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 15a778ce7707..bd2441790779 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -380,7 +380,7 @@ void am33xx_cm_clkdm_disable_hwsup(u16 inst, u16 cdoffs);
 void am33xx_cm_clkdm_force_sleep(u16 inst, u16 cdoffs);
 void am33xx_cm_clkdm_force_wakeup(u16 inst, u16 cdoffs);
 
-#ifdef CONFIG_SOC_AM33XX
+#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_AM43XX)
 extern int am33xx_cm_wait_module_idle(u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
 extern void am33xx_cm_module_enable(u8 mode, u16 inst, s16 cdoffs,
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f7bb435bb543..6c074f37cdd2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -4251,9 +4251,9 @@ void __init omap_hwmod_init(void)
 		soc_ops.enable_module = _omap4_enable_module;
 		soc_ops.disable_module = _omap4_disable_module;
 		soc_ops.wait_target_ready = _omap4_wait_target_ready;
-		soc_ops.assert_hardreset = _omap4_assert_hardreset;
-		soc_ops.deassert_hardreset = _omap4_deassert_hardreset;
-		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
+		soc_ops.assert_hardreset = _am33xx_assert_hardreset;
+		soc_ops.deassert_hardreset = _am33xx_deassert_hardreset;
+		soc_ops.is_hardreset_asserted = _am33xx_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 	} else if (soc_is_am33xx()) {
 		soc_ops.enable_module = _am33xx_enable_module;
-- 
2.0.0

