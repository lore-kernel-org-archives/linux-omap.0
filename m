From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Patch "REMOVE OMAP LEGACY CODE: Reset mach-omap1/board-*.c
	files to mainline" breaks nokia770
Date: Fri, 15 May 2009 00:18:55 +0100
Message-ID: <20090515001855.11164yyhzqzya58g@lidskialf.net>
References: <20090514004651.77342rqoq5tz86ww@lidskialf.net>
	<20090514002335.GA9538@nokia.com> <20090514014413.GE5593@atomide.com>
	<20090514080458.GC10386@nokia.com> <20090514153048.GH5593@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_4xf1yxb6e5ts"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 82-71-49-12.dsl.in-addr.zen.co.uk ([82.71.49.12]:33431 "EHLO
	mail.lidskialf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755732AbZENXSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 May 2009 19:18:55 -0400
In-Reply-To: <20090514153048.GH5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This message is in MIME format.

--=_4xf1yxb6e5ts
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Tony Lindgren <tony@atomide.com>:

> * Felipe Balbi <felipe.balbi@nokia.com> [090514 01:15]:
>> On Thu, May 14, 2009 at 03:44:14AM +0200, ext Tony Lindgren wrote:
>> > * Felipe Balbi <felipe.balbi@nokia.com> [090513 17:33]:
>> > > On Thu, May 14, 2009 at 01:46:51AM +0200, ext Andrew de Quincey wrote=
:
>> > > > Hi, I've just discovered that the patch at:
>> > > >
>> > > > =20
>> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git;a=
=3Dcommitdiff;h=3D3eae3ea7c443fc4330574dffea65b6f2f53a2574
>> > > >
>> > > > Breaks the nokia770's framebuffer as it removes the platform data f=
or
>> > > > the HWA742 LCD controller.
>> > > >
>> > > > As the patch says "Patches against the mainline tree are welcome to
>> > > > add back the missing functionality if needed!", I'm happy to do thi=
s.
>> > > >
>> > > > However, since I'm fairly new to the linux-omap project, is simply
>> > > > extracting the removed nokia770 code and generating a patch against
>> > > > the mainline kernel sufficient? or is there a newer style of some s=
ort
>> > > > that should be adopted for this?
>> > >
>> > > You can start by generating the new patch against mainline and runnin=
g
>> > > scripts/checkpatch.pl, then you should probably find out if there are
>> > > any API changes and stuff like that. Then send the patch to lkml ccin=
g
>> > > linux-omap and let's see what comments do you get from those guys :-)
>> >
>> > Please change the code to pass the struct clock to =20
>> drivers/video/omap/hwa742.c
>> > in hwa742_platform_data. The hw742.c can just do standard =20
>> clk_enable/disable
>> > there. Otherwise we won't be able to get this missing part to the mainl=
ine
>> > kernel.
>>
>> how about clkdev then ? are we gonna support that for omap1 still ?
>
> Yeah the clkdev is there, but in the case of the LCD the clock can be
> any clock, so we cannot set just one "fck" for all the omap1 LCD panels.
>
> In this case the "bclk" is used for the LCD, but "bclk" could be used
> for other devices as well, not just LCD.

Hi, is the attached patch the sort of thing you had in mind? This is =20
against linux-omap-2.6, latest git.

Unfortunately, both mainline linux-2.6 and linux-omap-2.6 gits lock up =20
on bootup before the LCD is initialised. However, the linux-omap =20
2.6.29 that is compiled by openembedded still boots ok, and with the =20
attached patch applied, the LCD works again!

I guess my next task is to figure out why the mainline kernels freeze; =20
I've seen that before, and it seemed to be something to do with =20
changes to the mcbsp support.

--=_4xf1yxb6e5ts
Content-Type: text/x-patch;
	charset=UTF-8;
	name="hwa742.patch"
Content-Disposition: attachment;
	filename="hwa742.patch"
Content-Transfer-Encoding: quoted-printable

Reinstate HWA742 platform data for nokia 770 platform.

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/boar=
d-nokia770.c
index 8780ca6..df5f38b 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -33,6 +33,7 @@
 #include <mach/common.h>
 #include <mach/dsp_common.h>
 #include <mach/omapfb.h>
+#include <mach/hwa742.h>
 #include <mach/lcd_mipid.h>
 #include <mach/mmc.h>
 #include <mach/usb.h>
@@ -163,6 +164,26 @@ static struct spi_board_info nokia770_spi_board_info[] =
__initdata =3D {
 =09},
 };
=20
+static struct hwa742_platform_data nokia770_hwa742_platform_data =3D {
+=09.sys_ck =09=09=3D NULL,
+=09.te_connected=09=09=3D 1,
+};
+
+static int hwa742_get_clocks(void)
+{
+=09nokia770_hwa742_platform_data.sys_ck =3D clk_get(NULL, "bclk");
+=09if (IS_ERR(nokia770_hwa742_platform_data.sys_ck)) {
+=09=09printk(KERN_ERR "can't get HWA742 clock\n");
+=09=09return PTR_ERR(nokia770_hwa742_platform_data.sys_ck);
+=09}
+=09return 0;
+}
+
+static void hwa742_dev_init(void)
+{
+=09hwa742_get_clocks();
+=09omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
+}
=20
 /* assume no Mini-AB port */
=20
@@ -371,6 +392,7 @@ static void __init omap_nokia770_init(void)
 =09omap_serial_init();
 =09omap_register_i2c_bus(1, 100, NULL, 0);
 =09omap_dsp_init();
+=09hwa742_dev_init();
 =09ads7846_dev_init();
 =09mipid_dev_init();
 =09omap_usb_init(&nokia770_usb_config);
diff --git a/arch/arm/plat-omap/include/mach/hwa742.h b/arch/arm/plat-omap/i=
nclude/mach/hwa742.h
index 577f492..c00e05d 100644
--- a/arch/arm/plat-omap/include/mach/hwa742.h
+++ b/arch/arm/plat-omap/include/mach/hwa742.h
@@ -2,10 +2,7 @@
 #define _HWA742_H
=20
 struct hwa742_platform_data {
-=09void=09=09(*power_up)(struct device *dev);
-=09void=09=09(*power_down)(struct device *dev);
-=09unsigned long=09(*get_clock_rate)(struct device *dev);
-
+=09struct clk =09*sys_ck;
 =09unsigned=09te_connected:1;
 };
=20
diff --git a/drivers/video/omap/hwa742.c b/drivers/video/omap/hwa742.c
index 8aa6e47..1230476 100644
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
+=09if (ctrl_conf =3D=3D NULL || ctrl_conf->sys_ck =3D=3D NULL) {
 =09=09dev_err(fbdev->dev, "HWA742: missing platform data\n");
 =09=09r =3D -ENOENT;
 =09=09goto err1;
 =09}
=20
-=09hwa742.power_down =3D ctrl_conf->power_down;
-=09hwa742.power_up =3D ctrl_conf->power_up;
+=09hwa742.sys_ck =3D ctrl_conf->sys_ck;
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
--=_4xf1yxb6e5ts--

