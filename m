From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Wed, 21 Sep 2011 09:43:06 -0700
Message-ID: <87d3et4zj9.fsf@ti.com>
References: <20110917014623.GC2937@atomide.com>
	<201109202334.43213.arnd@arndb.de> <201109202346.11393.arnd@arndb.de>
	<2241590.uiCS2D9jjt@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:51655 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752876Ab1IUQnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Sep 2011 12:43:11 -0400
Received: by gwm11 with SMTP id 11so646691gwm.2
        for <linux-omap@vger.kernel.org>; Wed, 21 Sep 2011 09:43:10 -0700 (PDT)
In-Reply-To: <2241590.uiCS2D9jjt@wuerfel> (Arnd Bergmann's message of "Wed, 21
	Sep 2011 11:28:31 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 20 September 2011 23:46:11 Arnd Bergmann wrote:
>
>> It seems that you replace the #ifdef in the board-flash.c file
>> with a similar #ifdef in the header that replaces this with an
>> empty inline function when the object is not built.
>
> Found another similar problem over night, presumably in the voltage series:
>

Found.  Patch below.

If this one is OK, I'll push to my for_3.2/voltage-cleanup branch (which
is already pulled into arm-soc/next/voltage) so just re-pulling will
pick up the fix.

Kevin


>From 473dc975c3ea468049732155467ff08fe3701f98 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Wed, 21 Sep 2011 09:24:53 -0700
Subject: [PATCH] ARM: OMAP: voltage layer present, even when CONFIG_PM=n

Even when CONFIG_PM=n, we try to scale the boot voltage to a sane,
known value using OPP table to find matching voltage based on boot
frequency.  This should be done, even when CONFIG_PM=n to avoid
mis-configured bootloaders and/or boot voltage assumptions made by
boot loaders.

Also fixes various compile problems due to depenencies between voltage
domain and powerdomain code (also present when CONFIG_PM=n).

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Compile tested with CONFIG_PM=n
Applies to arm-soc/next/voltage

 arch/arm/mach-omap2/Makefile  |    2 --
 arch/arm/mach-omap2/voltage.h |   14 --------------
 2 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 8bd389d..5129785 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -89,7 +89,6 @@ obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   vp44xx_data.o
 
 # OMAP voltage domains
-ifeq ($(CONFIG_PM),y)
 voltagedomain-common			:= voltage.o vc.o vp.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common) \
 					   voltagedomains2xxx_data.o
@@ -97,7 +96,6 @@ obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o
-endif
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 4c09809..16a1b09 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -148,25 +148,11 @@ void omap_voltage_get_volttable(struct voltagedomain *voltdm,
 		struct omap_volt_data **volt_data);
 struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
 		unsigned long volt);
-#ifdef CONFIG_PM
 int omap_voltage_register_pmic(struct voltagedomain *voltdm,
 			       struct omap_voltdm_pmic *pmic);
 void omap_change_voltscale_method(struct voltagedomain *voltdm,
 		int voltscale_method);
 int omap_voltage_late_init(void);
-#else
-static inline int omap_voltage_register_pmic(struct voltagedomain *voltdm,
-					     struct omap_voltdm_pmic *pmic)
-{
-	return -EINVAL;
-}
-static inline  void omap_change_voltscale_method(struct voltagedomain *voltdm,
-		int voltscale_method) {}
-static inline int omap_voltage_late_init(void)
-{
-	return -EINVAL;
-}
-#endif
 
 extern void omap2xxx_voltagedomains_init(void);
 extern void omap3xxx_voltagedomains_init(void);
-- 
1.7.6

