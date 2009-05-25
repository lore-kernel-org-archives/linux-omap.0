From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH 05/10] ARM: OMAP1: Make 770 LCD work
Date: Mon, 25 May 2009 17:40:55 +0100
Message-ID: <20090525174055.127744136qxu9vk0@lidskialf.net>
References: <20090519232905.12760.15490.stgit@localhost>
	<20090519233732.12760.34595.stgit@localhost>
	<20090525092911.GC28195@n2100.arm.linux.org.uk>
	<20090525142128.17675cl0tvdr0y1k@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_42g722dtta80"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:50456 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbZEYQkz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 12:40:55 -0400
In-Reply-To: <20090525142128.17675cl0tvdr0y1k@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, Imre Deak <imre.deak@nokia.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

This message is in MIME format.

--=_42g722dtta80
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Andrew de Quincey <adq_dvb@lidskialf.net>:

> Quoting Russell King - ARM Linux <linux@arm.linux.org.uk>:
>
>> On Tue, May 19, 2009 at 04:37:32PM -0700, Tony Lindgren wrote:
>>> Make 770 LCD work by passing the clock from platform data.
>>> Also remove the old unused functions.
>>
>> I don't like this - because its passing struct clk's through platform
>> data.  That's not how things are supposed to work.
>>
>> The way PXA solves this problem is to have clock aliases - see
>> clk_add_alias().
>
> Interesting idea - I now have a prototype patch implementing this, =20
> which I'll send when I get home (otherwise it would be an "it =20
> compiles" "test" :)
>
> There isn't a common definition of clk_add_alias() though - that =20
> symbol is defined in arch/arm/mach-pxa/clock.c, so I had to copy it =20
> into arch/arm/plat-omap/clock.c

Attached is a patch implementing this method. I don't like the =20
duplication of the clk_alias code, but I imagine that could be =20
resolved if this method was chosen....

--=_42g722dtta80
Content-Type: text/x-patch;
	charset=UTF-8;
	name="hwa-clk-alias.patch"
Content-Disposition: attachment;
	filename="hwa-clk-alias.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/boar=
d-nokia770.c
index 8780ca6..e70fc7c 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -33,9 +33,11 @@
 #include <mach/common.h>
 #include <mach/dsp_common.h>
 #include <mach/omapfb.h>
+#include <mach/hwa742.h>
 #include <mach/lcd_mipid.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
+#include <mach/clock.h>
=20
 #define ADS7846_PENDOWN_GPIO=0915
=20
@@ -163,6 +165,15 @@ static struct spi_board_info nokia770_spi_board_info[] =
__initdata =3D {
 =09},
 };
=20
+static struct hwa742_platform_data nokia770_hwa742_platform_data =3D {
+=09.te_connected=09=09=3D 1,
+};
+
+static void hwa742_dev_init(void)
+{
+=09clk_add_alias("hwa_sys_ck", NULL, "bclk", NULL);
+=09omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
+}
=20
 /* assume no Mini-AB port */
=20
@@ -371,6 +382,7 @@ static void __init omap_nokia770_init(void)
 =09omap_serial_init();
 =09omap_register_i2c_bus(1, 100, NULL, 0);
 =09omap_dsp_init();
+=09hwa742_dev_init();
 =09ads7846_dev_init();
 =09mipid_dev_init();
 =09omap_usb_init(&nokia770_usb_config);
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 29efc27..862eefd 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -24,6 +24,7 @@
 #include <linux/debugfs.h>
 #include <linux/io.h>
=20
+#include <asm/clkdev.h>
 #include <mach/clock.h>
=20
 static LIST_HEAD(clocks);
@@ -359,6 +360,24 @@ static int __init clk_disable_unused(void)
 late_initcall(clk_disable_unused);
 #endif
=20
+int clk_add_alias(const char *alias, const char *alias_dev_name, char *id,
+=09struct device *dev)
+{
+=09struct clk *r =3D clk_get(dev, id);
+=09struct clk_lookup *l;
+
+=09if (!r)
+=09=09return -ENODEV;
+
+=09l =3D clkdev_alloc(r, alias, alias_dev_name);
+=09clk_put(r);
+=09if (!l)
+=09=09return -ENODEV;
+=09clkdev_add(l);
+=09return 0;
+}
+EXPORT_SYMBOL(clk_add_alias);=09=09=09=09=09=09=09=09=09=09=09=09
+
 int __init clk_init(struct clk_functions * custom_clocks)
 {
 =09if (!custom_clocks) {
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/in=
clude/mach/clock.h
index 073a2c5..b53b047 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -127,12 +127,14 @@ extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
 extern unsigned long followparent_recalc(struct clk *clk);
 extern void clk_enable_init_clocks(void);
+extern int clk_add_alias(const char *alias, const char *alias_dev_name, cha=
r *id, struct device *dev); =09
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #endif
=20
 extern const struct clkops clkops_null;
=20
+
 /* Clock flags */
 /* bit 0 is free */
 #define RATE_FIXED=09=09(1 << 1)=09/* Fixed clock rate */
diff --git a/arch/arm/plat-omap/include/mach/hwa742.h b/arch/arm/plat-omap/i=
nclude/mach/hwa742.h
index 577f492..886248d 100644
--- a/arch/arm/plat-omap/include/mach/hwa742.h
+++ b/arch/arm/plat-omap/include/mach/hwa742.h
@@ -2,10 +2,6 @@
 #define _HWA742_H
=20
 struct hwa742_platform_data {
-=09void=09=09(*power_up)(struct device *dev);
-=09void=09=09(*power_down)(struct device *dev);
-=09unsigned long=09(*get_clock_rate)(struct device *dev);
-
 =09unsigned=09te_connected:1;
 };
=20
diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index 8aa6e47..5d4f348 100644
--- a/drivers/video/omap/hwa742.c
+++ b/drivers/video/omap/hwa742.c
@@ -133,8 +133,7 @@ struct {
 =09struct lcd_ctrl_extif=09*extif;
 =09struct lcd_ctrl=09=09*int_ctrl;
=20
-=09void=09=09=09(*power_up)(struct device *dev);
-=09void=09=09=09(*power_down)(struct device *dev);
+=09struct clk=09=09*sys_ck;
 } hwa742;
=20
 struct lcd_ctrl hwa742_ctrl;
@@ -915,14 +914,13 @@ static void hwa742_suspend(void)
 =09hwa742_set_update_mode(OMAPFB_UPDATE_DISABLED);
 =09/* Enable sleep mode */
 =09hwa742_write_reg(HWA742_POWER_SAVE, 1 << 1);
-=09if (hwa742.power_down !=3D NULL)
-=09=09hwa742.power_down(hwa742.fbdev->dev);
+=09clk_disable(hwa742.sys_ck);
 }
=20
 static void hwa742_resume(void)
 {
-=09if (hwa742.power_up !=3D NULL)
-=09=09hwa742.power_up(hwa742.fbdev->dev);
+=09clk_enable(hwa742.sys_ck);
+
 =09/* Disable sleep mode */
 =09hwa742_write_reg(HWA742_POWER_SAVE, 0);
 =09while (1) {
@@ -955,14 +953,13 @@ static int hwa742_init(struct omapfb_device *fbdev, in=
t ext_mode,
 =09omapfb_conf =3D fbdev->dev->platform_data;
 =09ctrl_conf =3D omapfb_conf->ctrl_platform_data;
=20
-=09if (ctrl_conf =3D=3D NULL || ctrl_conf->get_clock_rate =3D=3D NULL) {
+=09if (ctrl_conf =3D=3D NULL) {
 =09=09dev_err(fbdev->dev, "HWA742: missing platform data\n");
 =09=09r =3D -ENOENT;
 =09=09goto err1;
 =09}
=20
-=09hwa742.power_down =3D ctrl_conf->power_down;
-=09hwa742.power_up =3D ctrl_conf->power_up;
+=09hwa742.sys_ck =3D clk_get(NULL, "hwa_sys_ck");
=20
 =09spin_lock_init(&hwa742.req_lock);
=20
@@ -972,12 +969,11 @@ static int hwa742_init(struct omapfb_device *fbdev, in=
t ext_mode,
 =09if ((r =3D hwa742.extif->init(fbdev)) < 0)
 =09=09goto err2;
=20
-=09ext_clk =3D ctrl_conf->get_clock_rate(fbdev->dev);
+=09ext_clk =3D clk_get_rate(hwa742.sys_ck);
 =09if ((r =3D calc_extif_timings(ext_clk, &extif_mem_div)) < 0)
 =09=09goto err3;
 =09hwa742.extif->set_timings(&hwa742.reg_timings);
-=09if (hwa742.power_up !=3D NULL)
-=09=09hwa742.power_up(fbdev->dev);
+=09clk_enable(hwa742.sys_ck);
=20
 =09calc_hwa742_clk_rates(ext_clk, &sys_clk, &pix_clk);
 =09if ((r =3D calc_extif_timings(sys_clk, &extif_mem_div)) < 0)
@@ -1040,8 +1036,7 @@ static int hwa742_init(struct omapfb_device *fbdev, in=
t ext_mode,
=20
 =09return 0;
 err4:
-=09if (hwa742.power_down !=3D NULL)
-=09=09hwa742.power_down(fbdev->dev);
+=09clk_disable(hwa742.sys_ck);
 err3:
 =09hwa742.extif->cleanup();
 err2:
@@ -1055,8 +1050,7 @@ static void hwa742_cleanup(void)
 =09hwa742_set_update_mode(OMAPFB_UPDATE_DISABLED);
 =09hwa742.extif->cleanup();
 =09hwa742.int_ctrl->cleanup();
-=09if (hwa742.power_down !=3D NULL)
-=09=09hwa742.power_down(hwa742.fbdev->dev);
+=09clk_disable(hwa742.sys_ck);
 }
=20
 struct lcd_ctrl hwa742_ctrl =3D {
--=_42g722dtta80--

