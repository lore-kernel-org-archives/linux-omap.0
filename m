From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 10:04:29 -0800
Message-ID: <20120303180428.GA10293@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50612 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab2CCSEe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 13:04:34 -0500
Content-Disposition: inline
In-Reply-To: <20120303154650.GA16132@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120303 07:15]:
> There's not much more to say other than that in the subject over this
> level of build breakage:
> 
> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=267
> http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=268
> 
> which is the result of building:
> 
> commit 812108a6044b7b8978329ededb3171be89918a4f
> Merge: 8fe6b99 85631d2
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Fri Mar 2 09:27:55 2012 +0000
> 
>     Merge remote-tracking branch 'arm-soc'
>     
>     Conflicts:
>         arch/arm/Kconfig
>         arch/arm/mach-vexpress/Kconfig
> 
> commit 8fe6b99253c69412b08cb541155791ada1ba202a
> Merge: 8a27184 605ade3 492f076
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Fri Mar 2 09:23:30 2012 +0000
> 
>     Merge branches 'private-fixes' and 'sa11x0-asoc' into devel-3.3
> 
> commit 85631d264c35ed7fc43fd92a9f0b0d48b6dbd839
> Merge: 92601fd 76374c6
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Thu Mar 1 14:01:56 2012 +0000
> 
>     Merge branch 'fixes' into for-next

Well 85631d2 builds fine, looks like now some more includes of
plat/hardware.h are now needed.Have not yet tracked down which
commit triggers the build errors. Eventually those should become
local headers too..

Then looks like there's a mismerge with ASoC. And ASoC patch
"[PATCH v3 2/3] MFD: twl6040: Convert to i2c driver, and separate
it from twl core" that produces another build error.

Looks like we also have a new section warning with ASoC changes:

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x14504): Section mismatch in reference from the function omap4_pmic_init() to th
The function omap4_pmic_init() references
the (unknown reference) __initdata (unknown).
This is often because omap4_pmic_init lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Peter, care to look if below is right resolve for the
mismerge? Also can you please also fix the new section
warning?

Regards,

Tony


diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c1a852d..9868d5a 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -279,7 +279,7 @@ static int __init omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
 	return 0;
 }
 
-static struct twl4030_codec_data twl6040_codec = {
+static struct twl6040_codec_data twl6040_codec = {
 	/* single-step ramp for headset and handsfree */
 	.hs_left_step	= 0x0f,
 	.hs_right_step	= 0x0f,
@@ -287,17 +287,14 @@ static struct twl4030_codec_data twl6040_codec = {
 	.hf_right_step	= 0x1d,
 };
 
-static struct twl4030_audio_data twl6040_audio = {
+static struct twl6040_platform_data twl6040_data = {
 	.codec		= &twl6040_codec,
 	.audpwron_gpio	= 127,
-	.naudint_irq	= OMAP44XX_IRQ_SYS_2N,
 	.irq_base	= TWL6040_CODEC_IRQ_BASE,
 };
 
 /* Panda board uses the common PMIC configuration */
-static struct twl4030_platform_data omap4_panda_twldata = {
-	.audio		= &twl6040_audio,
-};
+static struct twl4030_platform_data omap4_panda_twldata;
 
 /*
  * Display monitor features are burnt in their EEPROM as EDID data. The EEPROM
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index c79ed63..389f9f8 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -18,6 +18,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
+
 #include "iomap.h"
 #include "common.h"
 #include "cm.h"
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 93419de..1549c11 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
 #include <plat/board.h>
 #include <plat/mux.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2fd5fd1..08e674b 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
 #include <plat/sdrc.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 2c329a6..1133bb2 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
