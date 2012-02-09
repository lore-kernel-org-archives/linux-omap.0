From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Thu, 9 Feb 2012 09:18:31 -0800
Message-ID: <20120209171830.GH16877@atomide.com>
References: <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
 <20120208184539.GE29796@atomide.com>
 <87ty312ae0.fsf@ti.com>
 <20120208235358.GD16877@atomide.com>
 <20120208235620.GE25414@n2100.arm.linux.org.uk>
 <87sjikx3xv.fsf@ti.com>
 <20120209001135.GF25414@n2100.arm.linux.org.uk>
 <87ipjgx3g3.fsf@ti.com>
 <20120209004027.GF16877@atomide.com>
 <20120209164913.GB19159@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23595 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757240Ab2BIRSi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 12:18:38 -0500
Content-Disposition: inline
In-Reply-To: <20120209164913.GB19159@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120209 08:18]:
> On Wed, Feb 08, 2012 at 04:40:27PM -0800, Tony Lindgren wrote:
> > * Kevin Hilman <khilman@ti.com> [120208 15:49]:
> > > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > > 
> > > > On Wed, Feb 08, 2012 at 04:09:48PM -0800, Kevin Hilman wrote:
> > > >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > > >> > Does it fix the other issues I mention in the commit log as well?
> > > >> 
> > > >> Like your patches 1 & 5, my series fixes the oops and also makes the
> > > >> error strings simple, non-wrapping ones.
> > > >> 
> > > >> The one thing it doesn't fix is the spelling typo you fixed in the
> > > >> comment, but IMO we can leave that out for -rc.
> > > >
> > > > OK, but it would be much better for that simple fix to go with another
> > > > simple patch.  On its own it doesn't make sense as a commit.
> > > 
> > > Agreed.  We'll have some other VC/VP cleanup for v3.4, and I'll add this
> > > into that cleanup.
> > 
> > Eek, looking at it, I'd rather stay away from this formatting patch
> > for -rc series because the flaming potential causes me rash!
> > 
> > Russell's patch 5 has way better description for the -rc series.
> > 
> > So I now suggest that Russell drops patch 1 and updates patch 5 to
> > cover both vp.c and vc.c.
> 
> I'm not sure what you want me to update in patch 5.  vp.c already
> contains:
> 
>         if (!voltdm->pmic) {
>                 pr_err("%s: No PMIC info for vdd_%s\n", __func__, voltdm->name);
>                 return;
>         }
> 
> which is where I got the idea for the message I put into vc.c.

OK no need to update patch 5 then.
 
> > d269914ece0498f31603ecd85ed3d7a586b3cbcd ARM: OMAP2+: PM: only register TWL with voltage layer when device is present
> > af9a2ed9667b49e7e125eac526d8f655183ce53e ARM: OMAP2+: voltage: add check for missing PMIC info in VP init
> 
> I'd like at least the first in my tree too, otherwise my stuff becomes
> untestable without patch 1.  What's the second doing?

OK. Please use your updated patch 1 as it contains the oops in
the description. Kevin, are you OK with that?

So that leaves me only the second one to queue that adds checks
for the PMIC info for boards that don't have it, see below.

Regards,

Tony


>From d269914ece0498f31603ecd85ed3d7a586b3cbcd Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Fri, 30 Sep 2011 11:24:04 -0700
Subject: [PATCH] ARM: OMAP2+: PM: only register TWL with voltage layer when device is present

Current code registers voltage layer details for TWL PMIC even when a TWL
has not been registered.  Fix this to only register the TWL with voltage
layer when the TWL PMIC is initialized by board-level code.

Tested-by: Abhilash Koyamangalath <abhilash.kv@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1e79bdf..00bff46 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -24,6 +24,7 @@
 #include "powerdomain.h"
 #include "clockdomain.h"
 #include "pm.h"
+#include "twl-common.h"
 
 static struct omap_device_pm_latency *pm_lats;
 
@@ -226,11 +227,8 @@ postcore_initcall(omap2_common_pm_init);
 
 static int __init omap2_common_pm_late_init(void)
 {
-	/* Init the OMAP TWL parameters */
-	omap3_twl_init();
-	omap4_twl_init();
-
 	/* Init the voltage layer */
+	omap_pmic_late_init();
 	omap_voltage_late_init();
 
 	/* Initialize the voltages */
diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index 5224357..10b20c6 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -30,6 +30,7 @@
 #include <plat/usb.h>
 
 #include "twl-common.h"
+#include "pm.h"
 
 static struct i2c_board_info __initdata pmic_i2c_board_info = {
 	.addr		= 0x48,
@@ -48,6 +49,16 @@ void __init omap_pmic_init(int bus, u32 clkrate,
 	omap_register_i2c_bus(bus, clkrate, &pmic_i2c_board_info, 1);
 }
 
+void __init omap_pmic_late_init(void)
+{
+	/* Init the OMAP TWL parameters (if PMIC has been registerd) */
+	if (!pmic_i2c_board_info.irq)
+		return;
+
+	omap3_twl_init();
+	omap4_twl_init();
+}
+
 #if defined(CONFIG_ARCH_OMAP3)
 static struct twl4030_usb_data omap3_usb_pdata = {
 	.usb_mode	= T2_USB_MODE_ULPI,
diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
index 5e83a5b..275dde8 100644
--- a/arch/arm/mach-omap2/twl-common.h
+++ b/arch/arm/mach-omap2/twl-common.h
@@ -1,6 +1,8 @@
 #ifndef __OMAP_PMIC_COMMON__
 #define __OMAP_PMIC_COMMON__
 
+#include <plat/irqs.h>
+
 #define TWL_COMMON_PDATA_USB		(1 << 0)
 #define TWL_COMMON_PDATA_BCI		(1 << 1)
 #define TWL_COMMON_PDATA_MADC		(1 << 2)
@@ -30,6 +32,7 @@ struct twl4030_platform_data;
 
 void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
 		    struct twl4030_platform_data *pmic_data);
+void omap_pmic_late_init(void);
 
 static inline void omap2_pmic_init(const char *pmic_type,
 				   struct twl4030_platform_data *pmic_data)
