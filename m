From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain &
 PRM support for AM33XX device
Date: Thu, 3 May 2012 14:44:11 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA130F0@DBDE01.ent.ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <20120418231837.GT21106@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com>
 <20120426184312.GY3739@atomide.com>
 <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205020325100.19695@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab2ECOoW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 10:44:22 -0400
In-Reply-To: <alpine.DEB.2.00.1205020325100.19695@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, May 02, 2012 at 15:00:28, Paul Walmsley wrote:
> 
> Hello Vaibhav,
> 
> I've reworked these patches somewhat to separate the PRM and CM changes 
> into their own patches.  Also, the omap_hwmod changes have been separated 
> and moved into a different series, as have the clock tree changes.
> 
> So now, pending for 3.5, there are the SCM, voltagedomain, PRM, CM, 
> powerdomain, and clockdomain changes.  Under the (probably incorrect) 
> assumption that Tony will opt to create a CONFIG_ARCH_OMAPAM33XX, you 
> might wish to take a look at the 'am33xx_prcm_devel_3.5' branch of 
> git://git.pwsan.com/linux-2.6.  It is based on four patches, not yet 
> upstream, which create the appropriate board file, Kconfig options, etc.
> 
> Once we're able to reach a conclusion as to which of the CONFIG_ARCH_OMAP* 
> options the AM33xx belongs under, this branch will be updated and 
> reposted, and if everyone is happy with it, proposed for pulling. 
> 

Hi Paul,

I have reviewed the "am33xx_prcm_devel_3.5" branch for AM33xx support,
and below are few comments I have,


1) ARM: add CONFIG_ARCH_OMAP{AM33XX,TI81XX}

Description talks about TI81xx as well, but patch is created only for AM33xx.
Isn't same entry should be created for TI81xx in the patch?

2) ARM: OMAP: AM335x: add Kconfig, Makefile glue for CONFIG_ARCH_OMAPAM33XX

Looks ok to me. (Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>)

3) ARM: OMAP: AM33xx: Add AM335XEVM machine support

Looks ok to me.

4) arm:omap:am33xx: Add low level debugging support 

Subject line need to change to match it with our convention.

ARM: OMAP: am33xx: Add low level debugging support

5) ARM: OMAP2+: control: Add AM33XX control reg & sec clkctrl offset

Looks ok to me.

6) ARM: OMAP3+: am33xx: Add voltage domain data

Remove multiple entries for voltagedomain-common.o for AM33xx

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index cc44ea9..3b953c7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -109,7 +109,6 @@ obj-$(CONFIG_SOC_OMAPAM33XX)                += $(voltagedomain-common) \
                                           voltagedomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)               += $(voltagedomain-common) \
                                           voltagedomains44xx_data.o
-obj-$(CONFIG_ARCH_OMAPAM33XX)          += $(voltagedomain-common)


7) ARM: OMAP3+: am33xx: add PRM support

Remove multiple entries for prcm.o for AM33xx

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3b953c7..ae1399b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -96,7 +96,6 @@ obj-$(CONFIG_ARCH_OMAP4)              += prcm.o cm2xxx_3xxx.o cminst44xx.o \
                                           cm44xx.o prcm_mpu44xx.o \
                                           prminst44xx.o vc44xx_data.o \
                                           vp44xx_data.o prm44xx.o
-obj-$(CONFIG_ARCH_OMAPAM33XX)          += prcm.o


8) ARM: OMAP3+: cm33xx: Introduce AM33xx CM API's and register level details

Looks ok to me.

9) ARM: OMAP2+: powerdomain: add AM335x support

Remove multiple entries for target powerdomain-common for AM33xx


diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ae1399b..1147352 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -126,7 +126,6 @@ obj-$(CONFIG_SOC_OMAPAM33XX)                += $(powerdomain-common) \
 obj-$(CONFIG_ARCH_OMAP4)               += $(powerdomain-common) \
                                           powerdomain44xx.o \
                                           powerdomains44xx_data.o
-obj-$(CONFIG_ARCH_OMAPAM33XX)          += $(powerdomain-common)


10) ARM: OMAP3+: clockdomain33xx: Add clockdomain data and respective operations

Looks ok to me.



Paul,

I have also boot tested it on BeagleBone, since we would not catch any
issues from the changes. It is highly impossible to catch just by reviewing 
the patch or checking for build test. So I ported merged clocktree and hwmod
patches to see whether it boots up on BeagleBone, and found that, we need 
further changes here -

=======================diff for BeagleBone boot======================
diff --git a/arch/arm/mach-omap2/board-am335xevm.c b/arch/arm/mach-omap2/board-am335xevm.c
index 324752e..69d8aae 100644
--- a/arch/arm/mach-omap2/board-am335xevm.c
+++ b/arch/arm/mach-omap2/board-am335xevm.c
@@ -41,6 +41,7 @@ MACHINE_START(AM335XEVM, "am335xevm")
 	.map_io		= am33xx_map_io,
 	.init_early	= am33xx_init_early,
 	.init_irq	= ti81xx_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
 	.timer		= &omap3_am33xx_timer,
 	.init_machine	= am335x_evm_init,
 MACHINE_END

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 1549c11..77467b3 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -134,6 +134,9 @@ void __init ti81xx_map_io(void)
 {
 	omapti81xx_map_common_io();
 }
+#endif
+
+#if defined(CONFIG_ARCH_OMAPAM33XX)
 
 #define AM33XX_TAP_BASE		(AM33XX_CTRL_BASE + \
 				TI81XX_CONTROL_DEVICE_ID - 0x204)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6712199..3c9649a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -185,7 +185,7 @@ static struct map_desc omapti81xx_io_desc[] __initdata = {
 };
 #endif
 
-#ifdef CONFIG_SOC_OMAPAM33XX
+#ifdef CONFIG_ARCH_OMAPAM33XX
 static struct map_desc omapam33xx_io_desc[] __initdata = {
 	{
 		.virtual	= L4_34XX_VIRT,
@@ -294,7 +294,7 @@ void __init omapti81xx_map_common_io(void)
 }
 #endif

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 6712199..3c9649a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -470,10 +470,12 @@ void __init ti81xx_init_early(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
#ifdef CONFIG_SOC_OMAPAM33XX
void __init am33xx_init_early(void)
 {
 	omap2_set_globals_am33xx();
+	omap3xxx_check_revision();
+	ti81xx_check_features();
 	omap_common_init_early();
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 80f3ced..c5f8a48 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -280,7 +280,7 @@ int __init omap_intc_of_init(struct device_node *node,
 	return 0;
 }
 
-#ifdef CONFIG_ARCH_OMAP3
+#if defined (CONFIG_ARCH_OMAP3) || defined (CONFIG_ARCH_OMAPAM33XX)
 static struct omap3_intc_regs intc_context[ARRAY_SIZE(irq_banks)];
 
 void omap_intc_save_context(void)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 2883f5d..2a25dd9 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -373,6 +373,8 @@ OMAP_SYS_TIMER(3)
 OMAP_SYS_TIMER_INIT(3_secure, OMAP3_SECURE_TIMER, OMAP3_CLKEV_SOURCE,
 			2, OMAP3_MPU_SOURCE)
 OMAP_SYS_TIMER(3_secure)
+#endif
+#ifdef CONFIG_ARCH_OMAPAM33XX
 OMAP_SYS_TIMER_INIT(3_am33xx, 1, OMAP4_MPU_SOURCE, 2, OMAP4_MPU_SOURCE)
 OMAP_SYS_TIMER(3_am33xx)
 #endif

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index dc6a86b..0e8957b 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -357,8 +357,6 @@ IS_OMAP_TYPE(3517, 0x3517)
 # undef cpu_is_ti81xx
 # undef cpu_is_ti816x
 # undef cpu_is_ti814x
-# undef cpu_is_am33xx
-# undef cpu_is_am335x
 # define cpu_is_omap3430()		is_omap3430()
 # define cpu_is_omap3503()		(cpu_is_omap3430() &&		\
 						(!omap3_has_iva()) &&	\
@@ -378,6 +376,11 @@ IS_OMAP_TYPE(3517, 0x3517)
 # define cpu_is_ti81xx()		is_ti81xx()
 # define cpu_is_ti816x()		is_ti816x()
 # define cpu_is_ti814x()		is_ti814x()
+#endif
+
+# if defined(CONFIG_ARCH_OMAPAM33XX)
+# undef cpu_is_am33xx
+# undef cpu_is_am335x
 # define cpu_is_am33xx()		is_am33xx()
 # define cpu_is_am335x()		is_am335x()
 #endif
@@ -397,7 +400,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_class_is_omap1()	(cpu_is_omap7xx() || cpu_is_omap15xx() || \
 				cpu_is_omap16xx())
 #define cpu_class_is_omap2()	(cpu_is_omap24xx() || cpu_is_omap34xx() || \
-				cpu_is_omap44xx())
+				cpu_is_omap44xx() || cpu_is_am33xx())
 
 /* Various silicon revisions for omap2 */
 #define OMAP242X_CLASS		0x24200024
@@ -433,7 +436,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define TI8148_REV_ES2_0	(TI814X_CLASS | (0x1 << 8))
 #define TI8148_REV_ES2_1	(TI814X_CLASS | (0x2 << 8))
 
-#define AM335X_CLASS		0x33500034
+#define AM335X_CLASS		0x33500033
 #define AM335X_REV_ES1_0	AM335X_CLASS
 
 #define OMAP443X_CLASS		0x44300044

