From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only
 Kconfigs
Date: Wed, 11 Feb 2015 02:25:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502110218090.3767@utopia.booyaka.com>
References: <alpine.DEB.2.02.1502070020530.3767@utopia.booyaka.com> <54D9CFBC.3070405@nvidia.com> <54D9E42C.7010105@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-131421830-1423621523=:3767"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60148 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbBKCZY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Feb 2015 21:25:24 -0500
In-Reply-To: <54D9E42C.7010105@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jgchunter@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, "aaro.koskinen@iki.fi >> Aaro Koskinen" <aaro.koskinen@iki.fi>, tuukka.tikkanen@linaro.org, "khilman@deeprootsystems.com >> Kevin Hilman" <khilman@deeprootsystems.com>, "tony@atomide.com >> Tony Lindgren" <tony@atomide.com>, "linux@arm.linux.org.uk >> Russell King" <linux@arm.linux.org.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-131421830-1423621523=:3767
Content-Type: TEXT/PLAIN; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi John,

thanks for the review,

On Tue, 10 Feb 2015, Jon Hunter wrote:

> On 07/02/2015 00:23, Paul Walmsley wrote:
> >=20
> > Building an OMAP1510-only Kconfig generates the following warnings:
> >=20
> > arch/arm/mach-omap1/pm.c: In function =A1omap1_pm_idle=A2:
> > arch/arm/mach-omap1/pm.c:123:2: warning: #warning Enable 32kHz OS timer
> > in order to allow sleep states in idle [-Wcpp]
> >  #warning Enable 32kHz OS timer in order to allow sleep states in idle
> >   ^
> > arch/arm/mach-omap1/pm.c: At top level:
> > arch/arm/mach-omap1/pm.c:76:23: warning: =A1enable_dyn_sleep=A2 defined=
 but
> > not used [-Wunused-variable]
> >  static unsigned short enable_dyn_sleep =3D 0;
> >                        ^
> >=20
> > These are not so easy to fix in an obviously correct fashion, since I
> > don't have these devices up and running in my testbed.  So, use
> > arch/arm/plat-omap/Kconfig and the existing pm.c source as a guide,
> > and posit that deep power saving states are only supported on OMAP16xx
> > chips with kernels built with both CONFIG_OMAP_DM_TIMER=3Dy and
> > CONFIG_OMAP_32K_TIMER=3Dy.
> >=20
> > While here, clean up a few printk()s and unnecessary #ifdefs.
> >=20
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: linux-omap@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >=20
> > Hi folks, if anyone out there is still experimenting with OMAP1 PM, or =
has
> > a copy of the OMAP1510 TRMs, could you please check this patch?  I'm
> > unable to test it since I don't have any OMAP1 devices currently active
> > in the testbed.  It at least compiles and deals with the build warnings=
:
>=20
> You can find the omap5910 documents here [1]. The omap5910 is equivalent
> to the omap1510.=20

OK good to be reminded of that :-)

> Unfortunately, there is not a single TRM for the omap5910 but individual=
=20
> documents for each chapter in the original TRM. Check out the "OMAP5910=
=20
> Dual-Core Processor Timer Reference Guide" and possibly the "OMAP5910=20
> Dual-Core Processor Clock Generation and System Reset Management=20
> Reference Guide"
>=20
> The omap15xx/5910 did have a 32k timer but as you can see it appears it
> was never supported by the kernel for this device (not sure why). I do
> recall that there is some errata regarding the 32k timer, if you look at
> the omap5910 errata document and search for 32k you should find it.

OK thanks for the context.  I probably am not going to investigate adding=
=20
support for this timer on OMAP1510/5910 - am primarily trying to avoid=20
causing a regression on the existing platforms.

> I no longer have access to omap15xx h/w to test. However, I do have
> omap5912 if you want me to test.

Only if you feel like it!  Am fine with just having the review.

> > http://www.pwsan.com/omap/testlogs/fix-omap-warnings-v3.21/201502061546=
19/
> >=20
> > Non-critical; targeted for v3.20-rc1 or v3.21-rc1.
> >=20
> >=20
> >  arch/arm/mach-omap1/pm.c | 42 +++++++++++++++++++++-------------------=
--
> >  1 file changed, 21 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> > index 34b4c0044961..d46d8a222fbb 100644
> > --- a/arch/arm/mach-omap1/pm.c
> > +++ b/arch/arm/mach-omap1/pm.c
> > @@ -71,13 +71,7 @@ static unsigned int
> > mpui7xx_sleep_save[MPUI7XX_SLEEP_SAVE_SIZE];
> >  static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
> >  static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
> >=20
> > -#ifndef CONFIG_OMAP_32K_TIMER
> > -
> > -static unsigned short enable_dyn_sleep =3D 0;
> > -
> > -#else
> > -
> > -static unsigned short enable_dyn_sleep =3D 1;
> > +static unsigned short enable_dyn_sleep;
> >=20
> >  static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *=
attr,
> >  =09=09=09 char *buf)
> > @@ -90,8 +84,9 @@ static ssize_t idle_store(struct kobject *kobj, struc=
t
> > kobj_attribute *attr,
> >  {
> >  =09unsigned short value;
> >  =09if (sscanf(buf, "%hu", &value) !=3D 1 ||
> > -=09    (value !=3D 0 && value !=3D 1)) {
> > -=09=09printk(KERN_ERR "idle_sleep_store: Invalid value\n");
> > +=09    (value !=3D 0 && value !=3D 1) ||
> > +=09    (value !=3D 0 && !IS_ENABLED(CONFIG_OMAP_32K_TIMER))) {
> > +=09=09pr_err("idle_sleep_store: Invalid value\n");
> >  =09=09return -EINVAL;
> >  =09}
> >  =09enable_dyn_sleep =3D value;
> > @@ -101,7 +96,6 @@ static ssize_t idle_store(struct kobject *kobj,
> > struct kobj_attribute *attr,
> >  static struct kobj_attribute sleep_while_idle_attr =3D
> >  =09__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
> >=20
> > -#endif
> >=20
> >  static void (*omap_sram_suspend)(unsigned long r0, unsigned long r1) =
=3D
> > NULL;
> >=20
> > @@ -120,12 +114,11 @@ void omap1_pm_idle(void)
> >  =09local_fiq_disable();
> >=20
> >  #if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
> > -#warning Enable 32kHz OS timer in order to allow sleep states in idle
> >  =09use_idlect1 =3D use_idlect1 & ~(1 << 9);
> > -#else
> > +#endif
> > +
> >  =09if (enable_dyn_sleep)
> >  =09=09do_sleep =3D 1;
>=20
> Do we still need this do_sleep variable now? Looking at the code, I
> think we could use enable_dyn_sleep directly.

OK dropped it.

>=20
> > -#endif
> >=20
> >  #ifdef CONFIG_OMAP_DM_TIMER
> >  =09use_idlect1 =3D omap_dm_timer_modify_idlect_mask(use_idlect1);
> > @@ -635,15 +628,24 @@ static const struct platform_suspend_ops
> > omap_pm_ops =3D {
> >=20
> >  static int __init omap_pm_init(void)
> >  {
> > -
> > -#ifdef CONFIG_OMAP_32K_TIMER
> > -=09int error;
> > -#endif
> > +=09int error =3D 0;
> >=20
> >  =09if (!cpu_class_is_omap1())
> >  =09=09return -ENODEV;
> >=20
> > -=09printk("Power Management for TI OMAP.\n");
> > +=09pr_info("Power Management for TI OMAP.\n");
> > +
> > +=09if (!IS_ENABLED(CONFIG_OMAP_32K_TIMER))
> > +=09=09pr_info("OMAP1 PM: sleep states in idle disabled due to no 32KiH=
z
> > timer\n");
> > +
> > +=09if (!IS_ENABLED(CONFIG_OMAP_DM_TIMER))
> > +=09=09pr_info("OMAP1 PM: sleep states in idle disabled due to no DMTIM=
ER
> > support\n");
> > +
> > +=09if (IS_ENABLED(CONFIG_OMAP_32K_TIMER) &&
> > +=09    IS_ENABLED(CONFIG_OMAP_DM_TIMER) && cpu_is_omap16xx()) {
>=20
> Do you need cpu_is_omap16xx() here? I believe DM_TIMER is only available
> on omap16xx onwards.

Makes sense, I'll drop the cpu_is* test.

> > +=09=09pr_info("OMAP1 PM: sleep states in idle enabled\n");
> > +=09=09enable_dyn_sleep =3D 1;
> > +=09}
> >=20
> >  =09/*
> >  =09 * We copy the assembler sleep/wakeup routines to SRAM.
> > @@ -693,17 +695,15 @@ static int __init omap_pm_init(void)
> >  =09omap_pm_init_debugfs();
> >  #endif
> >=20
> > -#ifdef CONFIG_OMAP_32K_TIMER
> >  =09error =3D sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr=
);
> >  =09if (error)
> >  =09=09printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
> > -#endif
> >=20
> >  =09if (cpu_is_omap16xx()) {
> >  =09=09/* configure LOW_PWR pin */
> >  =09=09omap_cfg_reg(T20_1610_LOW_PWR);
> >  =09}
> >=20
> > -=09return 0;
> > +=09return error;
> >  }
> >  __initcall(omap_pm_init);
> >=20
>=20
> Otherwise ...
>=20
> Acked-by: Jon Hunter <jgchunter@gmail.com>
>=20
> Cheers Jon

Updated patch follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 6 Feb 2015 15:56:07 -0700
Subject: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only Kconf=
igs

Building an OMAP1510-only Kconfig generates the following warnings:

arch/arm/mach-omap1/pm.c: In function =A1omap1_pm_idle=A2:
arch/arm/mach-omap1/pm.c:123:2: warning: #warning Enable 32kHz OS timer in =
order to allow sleep states in idle [-Wcpp]
 #warning Enable 32kHz OS timer in order to allow sleep states in idle
  ^
arch/arm/mach-omap1/pm.c: At top level:
arch/arm/mach-omap1/pm.c:76:23: warning: =A1enable_dyn_sleep=A2 defined but=
 not used [-Wunused-variable]
 static unsigned short enable_dyn_sleep =3D 0;
                       ^

These are not so easy to fix in an obviously correct fashion, since I
don't have these devices up and running in my testbed.  So, use
arch/arm/plat-omap/Kconfig and the existing pm.c source as a guide,
and posit that deep power saving states are only supported on OMAP16xx
chips with kernels built with both CONFIG_OMAP_DM_TIMER=3Dy and
CONFIG_OMAP_32K_TIMER=3Dy.

While here, clean up a few printk()s and unnecessary #ifdefs.

This second version of the patch incorporates several suggestions from
Jon Hunter <jgchunter@gmail.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tuukka Tikkanen <tuukka.tikkanen@linaro.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Jon Hunter <jgchunter@gmail.com>
---
 arch/arm/mach-omap1/pm.c | 51 ++++++++++++++++++++++++--------------------=
----
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 34b4c0044961..dd94567c3628 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -71,13 +71,7 @@ static unsigned int mpui7xx_sleep_save[MPUI7XX_SLEEP_SAV=
E_SIZE];
 static unsigned int mpui1510_sleep_save[MPUI1510_SLEEP_SAVE_SIZE];
 static unsigned int mpui1610_sleep_save[MPUI1610_SLEEP_SAVE_SIZE];
=20
-#ifndef CONFIG_OMAP_32K_TIMER
-
-static unsigned short enable_dyn_sleep =3D 0;
-
-#else
-
-static unsigned short enable_dyn_sleep =3D 1;
+static unsigned short enable_dyn_sleep;
=20
 static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr=
,
 =09=09=09 char *buf)
@@ -90,8 +84,9 @@ static ssize_t idle_store(struct kobject *kobj, struct ko=
bj_attribute *attr,
 {
 =09unsigned short value;
 =09if (sscanf(buf, "%hu", &value) !=3D 1 ||
-=09    (value !=3D 0 && value !=3D 1)) {
-=09=09printk(KERN_ERR "idle_sleep_store: Invalid value\n");
+=09    (value !=3D 0 && value !=3D 1) ||
+=09    (value !=3D 0 && !IS_ENABLED(CONFIG_OMAP_32K_TIMER))) {
+=09=09pr_err("idle_sleep_store: Invalid value\n");
 =09=09return -EINVAL;
 =09}
 =09enable_dyn_sleep =3D value;
@@ -101,7 +96,6 @@ static ssize_t idle_store(struct kobject *kobj, struct k=
obj_attribute *attr,
 static struct kobj_attribute sleep_while_idle_attr =3D
 =09__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
=20
-#endif
=20
 static void (*omap_sram_suspend)(unsigned long r0, unsigned long r1) =3D N=
ULL;
=20
@@ -115,16 +109,11 @@ void omap1_pm_idle(void)
 {
 =09extern __u32 arm_idlect1_mask;
 =09__u32 use_idlect1 =3D arm_idlect1_mask;
-=09int do_sleep =3D 0;
=20
 =09local_fiq_disable();
=20
 #if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
-#warning Enable 32kHz OS timer in order to allow sleep states in idle
 =09use_idlect1 =3D use_idlect1 & ~(1 << 9);
-#else
-=09if (enable_dyn_sleep)
-=09=09do_sleep =3D 1;
 #endif
=20
 #ifdef CONFIG_OMAP_DM_TIMER
@@ -134,10 +123,12 @@ void omap1_pm_idle(void)
 =09if (omap_dma_running())
 =09=09use_idlect1 &=3D ~(1 << 6);
=20
-=09/* We should be able to remove the do_sleep variable and multiple
+=09/*
+=09 * We should be able to remove the do_sleep variable and multiple
 =09 * tests above as soon as drivers, timer and DMA code have been fixed.
-=09 * Even the sleep block count should become obsolete. */
-=09if ((use_idlect1 !=3D ~0) || !do_sleep) {
+=09 * Even the sleep block count should become obsolete.
+=09 */
+=09if ((use_idlect1 !=3D ~0) || !enable_dyn_sleep) {
=20
 =09=09__u32 saved_idlect1 =3D omap_readl(ARM_IDLECT1);
 =09=09if (cpu_is_omap15xx())
@@ -635,15 +626,25 @@ static const struct platform_suspend_ops omap_pm_ops =
=3D {
=20
 static int __init omap_pm_init(void)
 {
-
-#ifdef CONFIG_OMAP_32K_TIMER
-=09int error;
-#endif
+=09int error =3D 0;
=20
 =09if (!cpu_class_is_omap1())
 =09=09return -ENODEV;
=20
-=09printk("Power Management for TI OMAP.\n");
+=09pr_info("Power Management for TI OMAP.\n");
+
+=09if (!IS_ENABLED(CONFIG_OMAP_32K_TIMER))
+=09=09pr_info("OMAP1 PM: sleep states in idle disabled due to no 32KiHz ti=
mer\n");
+
+=09if (!IS_ENABLED(CONFIG_OMAP_DM_TIMER))
+=09=09pr_info("OMAP1 PM: sleep states in idle disabled due to no DMTIMER s=
upport\n");
+
+=09if (IS_ENABLED(CONFIG_OMAP_32K_TIMER) &&
+=09    IS_ENABLED(CONFIG_OMAP_DM_TIMER)) {
+=09=09/* OMAP16xx only */
+=09=09pr_info("OMAP1 PM: sleep states in idle enabled\n");
+=09=09enable_dyn_sleep =3D 1;
+=09}
=20
 =09/*
 =09 * We copy the assembler sleep/wakeup routines to SRAM.
@@ -693,17 +694,15 @@ static int __init omap_pm_init(void)
 =09omap_pm_init_debugfs();
 #endif
=20
-#ifdef CONFIG_OMAP_32K_TIMER
 =09error =3D sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
 =09if (error)
 =09=09printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
-#endif
=20
 =09if (cpu_is_omap16xx()) {
 =09=09/* configure LOW_PWR pin */
 =09=09omap_cfg_reg(T20_1610_LOW_PWR);
 =09}
=20
-=09return 0;
+=09return error;
 }
 __initcall(omap_pm_init);
--=20
2.1.4

--843723315-131421830-1423621523=:3767--
