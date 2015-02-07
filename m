From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP1: PM: fix some build warnings on 1510-only
 Kconfigs
Date: Sat, 7 Feb 2015 00:23:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1502070020530.3767@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1514372151-1423268584=:3767"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-ID: <alpine.DEB.2.02.1502070023190.3767@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jonathanh@nvidia.com, aaro.koskinen@iki.fi, tuukka.tikkanen@linaro.org, khilman@deeprootsystems.com, tony@atomide.com, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1514372151-1423268584=:3767
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.02.1502070023191.3767@utopia.booyaka.com>


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
---

Hi folks, if anyone out there is still experimenting with OMAP1 PM, or has=
=20
a copy of the OMAP1510 TRMs, could you please check this patch?  I'm=20
unable to test it since I don't have any OMAP1 devices currently active=20
in the testbed.  It at least compiles and deals with the build warnings:

http://www.pwsan.com/omap/testlogs/fix-omap-warnings-v3.21/20150206154619/

Non-critical; targeted for v3.20-rc1 or v3.21-rc1.


 arch/arm/mach-omap1/pm.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 34b4c0044961..d46d8a222fbb 100644
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
@@ -120,12 +114,11 @@ void omap1_pm_idle(void)
 =09local_fiq_disable();
=20
 #if defined(CONFIG_OMAP_MPU_TIMER) && !defined(CONFIG_OMAP_DM_TIMER)
-#warning Enable 32kHz OS timer in order to allow sleep states in idle
 =09use_idlect1 =3D use_idlect1 & ~(1 << 9);
-#else
+#endif
+
 =09if (enable_dyn_sleep)
 =09=09do_sleep =3D 1;
-#endif
=20
 #ifdef CONFIG_OMAP_DM_TIMER
 =09use_idlect1 =3D omap_dm_timer_modify_idlect_mask(use_idlect1);
@@ -635,15 +628,24 @@ static const struct platform_suspend_ops omap_pm_ops =
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
+=09    IS_ENABLED(CONFIG_OMAP_DM_TIMER) && cpu_is_omap16xx()) {
+=09=09pr_info("OMAP1 PM: sleep states in idle enabled\n");
+=09=09enable_dyn_sleep =3D 1;
+=09}
=20
 =09/*
 =09 * We copy the assembler sleep/wakeup routines to SRAM.
@@ -693,17 +695,15 @@ static int __init omap_pm_init(void)
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
--843723315-1514372151-1423268584=:3767--
