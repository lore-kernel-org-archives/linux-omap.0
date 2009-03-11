From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7-omap-git] Overo: MMC regulator configuration
Date: Wed, 11 Mar 2009 12:34:59 -0800
Message-ID: <200903111334.59499.david-b@pacbell.net>
References: <200903111158.29860.david-b@pacbell.net> <20090311193347.GC19730@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:42336 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750728AbZCKUfC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 16:35:02 -0400
In-Reply-To: <20090311193347.GC19730@gandalf>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: OMAP <linux-omap@vger.kernel.org>, Steve Sakoman <steve@sakoman.com>, Mark Brown <broonie@sirena.org.uk>

On Wednesday 11 March 2009, Felipe Balbi wrote:
> with this patch I get:
>=20
> regulator: Unable to get requested regulator: vmmc_aux

That's completely safe; annoying and useless noise from
the regulator core, that's all.


> ------------[ cut here ]------------
> WARNING: at drivers/regulator/core.c:1216 regulator_disable+0x64/0x90=
()
> unbalanced disables for supply mmci-omap-hs.0-vmmc

This is that bug in the regulator framework which
Mark is so reluctant to fix ... the one whereby
regulators aren't initialized into a known state.

In this case, the Overo probably booted from MMC,
and U-Boot left the MMC1 regulator on.  The first
thing the MMC stack does is force the regulator
off, so Linux can properly enumerate the device.

(Of course, some boards will boot from flash and
not turn the regulator on...)

I posted a patch to address that regulator framework
bug earlier:

 http://marc.info/?l=3Dlinux-omap&m=3D123654568330807&w=3D2

I've appended a slightly simplified version of
that patch below.

=20

> Modules linked in:
> [<c0363198>] (dump_stack+0x0/0x14) from [<c004f0fc>] (warn_slowpath+0=
x6c/0x88)
> [<c004f090>] (warn_slowpath+0x0/0x88) from [<c01b2694>] (regulator_di=
sable+0x64/0x90)
> =A0r3:cf9deae0 r2:c0425c79
> =A0r7:cfa16e00 r6:cfa06c38 r5:cfa16e00 r4:fffffffb
> [<c01b2630>] (regulator_disable+0x0/0x90) from [<c025ed6c>] (mmc_regu=
lator_set_ocr+0xb0/0xcc)
> =A0r7:cfa16e00 r6:00000001 r5:00000000 r4:00000000
> [<c025ecbc>] (mmc_regulator_set_ocr+0x0/0xcc) from [<c003af08>] (twl_=
mmc1_set_power+0xc0/0xec)
> =A0r7:cfa93538 r6:00000000 r5:00000000 r4:c04a5b58
> [<c003ae48>] (twl_mmc1_set_power+0x0/0xec) from [<c0267b34>] (omap_mm=
c_set_ios+0x54/0x314)
> =A0r7:cfa93538 r6:cfa935c0 r5:cfa93400 r4:cf9a93c0
> [<c0267ae0>] (omap_mmc_set_ios+0x0/0x314) from [<c025e54c>] (mmc_powe=
r_off+0x90/0x9c)
> =A0r7:00000000 r6:00000000 r5:cfa93400 r4:00000000
> [<c025e4bc>] (mmc_power_off+0x0/0x9c) from [<c025ea98>] (mmc_start_ho=
st+0x14/0x24)
> =A0r5:00000000 r4:cfa93400
> [<c025ea84>] (mmc_start_host+0x0/0x24) from [<c025fcbc>] (mmc_add_hos=
t+0x64/0x70)
> =A0r5:00000000 r4:cfa93400
> [<c025fc58>] (mmc_add_host+0x0/0x70) from [<c0021cac>] (omap_mmc_prob=
e+0x464/0x614)
> =A0r5:cfa935c0 r4:cfa93470
> [<c0021848>] (omap_mmc_probe+0x0/0x614) from [<c01d7b60>] (platform_d=
rv_probe+0x20/0x24)
> [<c01d7b40>] (platform_drv_probe+0x0/0x24) from [<c01d6d54>] (driver_=
probe_device+0xd4/0x180)
> [<c01d6c80>] (driver_probe_device+0x0/0x180) from [<c01d6e68>] (__dri=
ver_attach+0x68/0x8c)
> =A0r7:cfa15120 r6:c0499e34 r5:cfa06290 r4:cfa06208
> [<c01d6e00>] (__driver_attach+0x0/0x8c) from [<c01d65f8>] (bus_for_ea=
ch_dev+0x4c/0x80)
> =A0r7:cfa15120 r6:c0499e34 r5:c01d6e00 r4:00000000
> [<c01d65ac>] (bus_for_each_dev+0x0/0x80) from [<c01d6b98>] (driver_at=
tach+0x20/0x28)
> =A0r6:c0499e34 r5:00000000 r4:00000000
> [<c01d6b78>] (driver_attach+0x0/0x28) from [<c01d5ed4>] (bus_add_driv=
er+0xa4/0x20c)
> [<c01d5e30>] (bus_add_driver+0x0/0x20c) from [<c01d708c>] (driver_reg=
ister+0x98/0x120)
> =A0r8:00000000 r7:c002182c r6:c0499e34 r5:00000000 r4:c0028a58
> [<c01d6ff4>] (driver_register+0x0/0x120) from [<c01d8008>] (platform_=
driver_register+0x6c/0x88)
> =A0r9:00000000 r8:00000000 r7:c002182c r6:00000000 r5:00000000
> r4:c0028a58
> [<c01d7f9c>] (platform_driver_register+0x0/0x88) from [<c0021840>] (o=
map_mmc_init+0x14/0x1c)
> [<c002182c>] (omap_mmc_init+0x0/0x1c) from [<c002d2bc>] (__exception_=
text_end+0x5c/0x19c)
> [<c002d260>] (__exception_text_end+0x0/0x19c) from [<c0008400>] (kern=
el_init+0x80/0xf4)
> =A0r8:00000000 r7:00000000 r6:00000000 r5:00000000 r4:c0028a58
> [<c0008380>] (kernel_init+0x0/0xf4) from [<c0051f50>] (do_exit+0x0/0x=
6a4)
> =A0r4:00000000
> ---[ end trace e00c52255ce89b8f ]---
> mmci-omap-hs mmci-omap-hs.1: Failed to get debounce clock
> regulator: Unable to get requested regulator: vmmc
>=20
> does this depend on any patch dave ? Using current omap HEAD.

I was probably running with the patch appended below.

- Dave

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D CUT HERE
=46rom: David Brownell <dbrownell@users.sourceforge.net>

Make the regulator setup code simpler and more consistent:

 - The only difference between "boot_on" and "always_on" is
   that an "always_on" regulator won't be disabled.  Both will
   be active (and usecount will be 1) on return from setup.

 - Regulators not marked as "boot_on" or "always_on" won't
   be active (and usecount will be 0) on return from setup.

The exception to that simple policy is when there's a non-Linux
interface to the regulator ... e.g. if either a DSP or the CPU
running Linux can enable the regulator, and the DSP needs it to
be on, then it will be on.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/regulator/core.c |   47 +++++++++++++++++++++++++++++---------=
-------
 1 file changed, 31 insertions(+), 16 deletions(-)

--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -711,6 +711,7 @@ static int set_machine_constraints(struc
 	int ret =3D 0;
 	const char *name;
 	struct regulator_ops *ops =3D rdev->desc->ops;
+	int enable =3D 0;
=20
 	if (constraints->name)
 		name =3D constraints->name;
@@ -799,10 +800,6 @@ static int set_machine_constraints(struc
 			}
 	}
=20
-	/* are we enabled at boot time by firmware / bootloader */
-	if (rdev->constraints->boot_on)
-		rdev->use_count =3D 1;
-
 	/* do we need to setup our suspend state */
 	if (constraints->initial_state) {
 		ret =3D suspend_prepare(rdev, constraints->initial_state);
@@ -814,21 +811,39 @@ static int set_machine_constraints(struc
 		}
 	}
=20
-	/* if always_on is set then turn the regulator on if it's not
-	 * already on. */
-	if (constraints->always_on && ops->enable &&
-	    ((ops->is_enabled && !ops->is_enabled(rdev)) ||
-	     (!ops->is_enabled && !constraints->boot_on))) {
-		ret =3D ops->enable(rdev);
-		if (ret < 0) {
-			printk(KERN_ERR "%s: failed to enable %s\n",
-			       __func__, name);
-			rdev->constraints =3D NULL;
-			goto out;
+	/* Should this be enabled when we return from here?  The difference
+	 * between "boot_on" and "always_on" is that "always_on" regulators
+	 * won't ever be disabled.
+	 */
+	if (constraints->boot_on || constraints->always_on)
+		enable =3D 1;
+
+	/* Make sure the regulator isn't wrongly enabled or disabled.
+	 * Bootloaders are often sloppy about leaving things on; and
+	 * sometimes Linux wants to use a different model.
+	 */
+	if (enable) {
+		if (ops->enable) {
+			ret =3D ops->enable(rdev);
+			if (ret < 0)
+				pr_warning("%s: %s disable --> %d\n",
+					       __func__, name, ret);
+		}
+		if (ret >=3D 0)
+			rdev->use_count =3D 1;
+	} else {
+		if (ops->disable) {
+			ret =3D ops->disable(rdev);
+			if (ret < 0)
+				pr_warning("%s: %s disable --> %d\n",
+					       __func__, name, ret);
 		}
 	}
=20
-	print_constraints(rdev);
+	if (ret < 0)
+		rdev->constraints =3D NULL;
+	else
+		print_constraints(rdev);
 out:
 	return ret;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
