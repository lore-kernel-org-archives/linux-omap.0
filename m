From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 3/3] arm:omap:omap4: Hook-up am33xx support to
 existing prm code
Date: Thu, 2 Feb 2012 18:05:25 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317BDC0E@DBDE01.ent.ti.com>
References: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
	<1326017894-7632-4-git-send-email-hvaibhav@ti.com>	<87zkdvpgz1.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8317AF316@DBDE01.ent.ti.com>
	<877h0ikpxn.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8317BB167@DBDE01.ent.ti.com>
 <87obtifofv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49522 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684Ab2BBSFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 13:05:33 -0500
In-Reply-To: <87obtifofv.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Nayak, Rajendra" <rnayak@ti.com>

On Wed, Feb 01, 2012 at 23:03:56, Hilman, Kevin wrote:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> > On Tue, Jan 24, 2012 at 04:05:32, Hilman, Kevin wrote:
> >> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> >> 
> >> > On Wed, Jan 11, 2012 at 21:48:25, Hiremath, Vaibhav wrote:
> >> >> On Tue, Jan 10, 2012 at 23:39:22, Hilman, Kevin wrote:
> >> >> > Vaibhav Hiremath <hvaibhav@ti.com> writes:
> >> >> > 
> >> >> > > AM33XX PRM module (L4_WK domain) will be treated as another seperate
> >> >> > > partition in _prm_bases[] table.
> >> >> > >
> >> >> > > Also, since cpu_is_omap34xx check is true for am33xx family of
> >> >> > > devices, we must check cpu_is_am33xx fisrt, in order to follow
> >> >> > > omap4 execution path.
> >> >> > 
> >> >> > Can you remind me why cpu_is_omap34xx() is true for AM33xx family?
> >> >> 
> >> >> Yeah sure...
> >> >> 
> >> >> Kevin,
> >> >> As mentioned before, the main idea behind bringing am33xx under omap34xx
> >> >> was mainly due to "cortex-A8 family of devices".
> >> >> 
> >> >> It has been discussed and aligned long time back, so
> >> >> please refer to the thread -
> >> >> 
> >> >> http://www.spinics.net/lists/linux-omap/msg41046.html
> >> >> Multiple versions of -
> >> >> http://www.spinics.net/lists/linux-omap/msg45505.html
> >> >> 
> >> >> Thanks,
> >> >> Vaibhav
> >> >> 
> >> >> > These AM3xxx devices make my brain hurt.
> >> >> > 
> >> >> > > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> >> >> > > Cc: Kevin Hilman <khilman@ti.com>
> >> >> > > Cc: Rajendra Nayak <rnayak@ti.com>
> >> >> > 
> >> >> > [...]
> >> >> > 
> >> >> > > diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
> >> >> > > index 3d9894f..fcc4123 100644
> >> >> > > --- a/arch/arm/mach-omap2/prminst44xx.c
> >> >> > > +++ b/arch/arm/mach-omap2/prminst44xx.c
> >> >> > > @@ -19,6 +19,7 @@
> >> >> > >  #include "common.h"
> >> >> > >
> >> >> > >  #include "prm44xx.h"
> >> >> > > +#include "prm33xx.h"
> >> >> > >  #include "prminst44xx.h"
> >> >> > >  #include "prm-regbits-44xx.h"
> >> >> > >  #include "prcm44xx.h"
> >> >> > > @@ -31,6 +32,7 @@ static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
> >> >> > >  	[OMAP4430_CM2_PARTITION]		= 0,
> >> >> > >  	[OMAP4430_SCRM_PARTITION]		= 0,
> >> >> > >  	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
> >> >> > > +	[AM33XX_PRM_PARTITION]			= AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE),
> >> >> > >  };
> >> >> > 
> >> >> > I'm not crazy about just extending the "normal" OMAP4 table.  
> >> >> 
> >> >> If it is required then yes (with proper comment).
> >> >> 
> >> >> > That would
> >> >> > imply that with each OMAP4 derivatve we keep extending this table.
> >> >> > 
> >> >> 
> >> >> I would say anyway we will end up adding
> >> >> Cpu_is_xxx everywhere as we add new table for derivatives.
> >> >> 
> >> >> > Instead, how about rename this to one to omap44xx_prm_bases[], then
> >> >> > create a new one called am33xx_prm_bases[].  Then, at init time, assing
> >> >> > _prm_bases to the right one based on cpu_is_.
> >> >> > 
> >> >> 
> >> >> Just wanted to avoid cpu_is_xxxx check here. Will specific comment wouldn't
> >> >> help here (I have clearly mentioned in patch description), may be in c file
> >> >> it is required?
> >> >> OR 
> >> >> you want to be clearly separate table for code readability.
> >> >> 
> >> >
> >> > Kevin,
> >> >
> >> > Any comments on this? Should I stick to what is implemented now?
> >> >
> >> 
> >> cpu_is_* checks are acceptable at init time, and we use them often to
> >> initialize SoC-dependent tables/arrays etc.
> >> 
> > Kevin,
> >
> > Sorry for delayed response,
> >
> > Here is the ugly part, which I was referring to -
> >
> > 1) "_prm_bases" variable is static variable to the prminst44xx.c
> >
> > 2) prminst44xx.c file doesn't contain any boot time __init function,
> >    So I have to either add exported __init function OR extern __prm_bases
> >    variable and initialize somewhere outside this file.
> >
> > 3) Even if I create 2 separate variables, for example,
> >
> > static u32 omap44xx_prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
> > ...
> > };
> >
> > static u32 omap33xx_prm_bases[AM33XX_MAX_PRCM_PARTITIONS] = {
> > ...
> > };
> >
> > Makes it difficult and messy to handle inside below code, 
> > BUG_ON doesn't make sense from AM335x perspective.
> 
> Then you can change the BUG_ON.
> 
> static u32 omap44xx_max_partitions = ARRAY_SIZE(omap44xx_prm_bases)
> static u32 am33xx_max_partitions = ARRAY_SIZE(am33xx_prm_bases)
> static u32 max_partitions.
> 
> At init time, assign max_partitions when you assign prm_bases, then
> change the BUG_ON() to be something like:
> 
>        BUG_ON(part >= max_partitions || part == INVALID_PARTITION)
> 

Kevin,

Sorry for delayed response on this, was into volleyball match whole day...
As I mentioned, I attempted to do this and below is output of git-diff.
Also, I have boot tested it on AM335xEVM board.

NOTE: Diff is created on top of my earlier submitted patches.

===============git diff=============
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b3da178..f387857 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -39,6 +39,7 @@
 #include <plat/omap-pm.h>
 #include "voltage.h"
 #include "powerdomain.h"
+#include "prminst44xx.h"

 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
@@ -475,6 +476,7 @@ void __init am33xx_init_early(void)
        omap2_set_globals_am33xx();
        omap_common_init_early();
        am33xx_voltagedomains_init();
+       omap44xx_prminst_init();
        am33xx_powerdomains_init();
        am33xx_clockdomains_init();
        am33xx_hwmod_init();
@@ -491,6 +493,7 @@ void __init omap4430_init_early(void)
        omap4xxx_check_features();
        omap_common_init_early();
        omap44xx_voltagedomains_init();
+       omap44xx_prminst_init();
        omap44xx_powerdomains_init();
        omap44xx_clockdomains_init();
        omap44xx_hwmod_init();
diff --git a/arch/arm/mach-omap2/prcm44xx.h b/arch/arm/mach-omap2/prcm44xx.h
index d193f91..c539eb0 100644
--- a/arch/arm/mach-omap2/prcm44xx.h
+++ b/arch/arm/mach-omap2/prcm44xx.h
@@ -32,7 +32,7 @@
 #define OMAP4430_SCRM_PARTITION                        4
 #define OMAP4430_PRCM_MPU_PARTITION            5
 /* AM33XX PRCM is closer to OMAP4, so try to reuse all API's */
-#define AM33XX_PRM_PARTITION                   6
+#define AM33XX_PRM_PARTITION                   1

 /*
  * OMAP4_MAX_PRCM_PARTITIONS: set to the highest value of the PRCM partition
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index fcc4123..d2748b7 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -25,20 +25,26 @@
 #include "prcm44xx.h"
 #include "prcm_mpu44xx.h"

-static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
+static u32 *_prm_bases;
+static u32 max_prm_partitions;
+
+static u32 omap44xx_prm_bases[] = {
        [OMAP4430_INVALID_PRCM_PARTITION]       = 0,
        [OMAP4430_PRM_PARTITION]                = OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
        [OMAP4430_CM1_PARTITION]                = 0,
        [OMAP4430_CM2_PARTITION]                = 0,
        [OMAP4430_SCRM_PARTITION]               = 0,
        [OMAP4430_PRCM_MPU_PARTITION]           = OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
-       [AM33XX_PRM_PARTITION]                  = AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE),
 };

+static u32 am33xx_prm_bases[] = {
+       [OMAP4430_INVALID_PRCM_PARTITION]       = 0,
+       [AM33XX_PRM_PARTITION]                  = AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE),
+};
 /* Read a register in a PRM instance */
 u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 {
-       BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
+       BUG_ON(part >= max_prm_partitions ||
               part == OMAP4430_INVALID_PRCM_PARTITION ||
               !_prm_bases[part]);
        return __raw_readl(_prm_bases[part] + inst + idx);
@@ -47,7 +53,7 @@ u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 /* Write into a register in a PRM instance */
 void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 {
-       BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
+       BUG_ON(part >= max_prm_partitions ||
               part == OMAP4430_INVALID_PRCM_PARTITION ||
               !_prm_bases[part]);
        __raw_writel(val, _prm_bases[part] + inst + idx);
@@ -175,3 +181,14 @@ void omap4_prminst_global_warm_sw_reset(void)
                                    OMAP4430_PRM_DEVICE_INST,
                                    OMAP4_PRM_RSTCTRL_OFFSET);
 }
+
+void __init omap44xx_prminst_init(void)
+{
+       if (cpu_is_omap44xx()) {
+               _prm_bases = omap44xx_prm_bases;
+               max_prm_partitions = ARRAY_SIZE(omap44xx_prm_bases);
+       } else if (cpu_is_am33xx()) {
+               _prm_bases = am33xx_prm_bases;
+               max_prm_partitions = ARRAY_SIZE(am33xx_prm_bases);
+       }
+}
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index 46f2efb..9a44c68 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -29,5 +29,5 @@ extern int omap4_prminst_assert_hardreset(u8 shift, u8 part, s16 inst,
                                          u16 rstctrl_offs);
 extern int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
                                            u16 rstctrl_offs);
-
+extern void __init omap44xx_prminst_init(void);
 #endif

