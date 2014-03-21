From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
Date: Fri, 21 Mar 2014 00:52:42 -0500
Message-ID: <20140321055242.GA1959@saruman.home>
References: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395379213-15451-1-git-send-email-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2014 at 10:50:13AM +0530, Lokesh Vutla wrote:
> From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
>=20
> Do not reset GPIO5 at boot-up because GPIO5_7 is used
> on AM437x GP-EVM to control VTT regulators on DDR3.
> Without this some GP-EVM boards will fail to boot because
> of DDR3 corruption.
>=20
> Reported-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Tested-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>

every now and again we see a patch like this because yet another board
is using a GPIO to toggle DDR regulators.

Instead of constantly patching things like this, how about we try
something like below (build-tested only):

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 1f33f5d..f5962ff 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2610,6 +2610,10 @@ static int __init _setup_reset(struct omap_hwmod *oh)
 	if (oh->flags & HWMOD_EXT_OPT_MAIN_CLK)
 		return -EPERM;
=20
+	/* NEVER reset GPIO blocks */
+	if (strncmp(oh->name, "gpio", 4) =3D=3D 0)
+		return 0;
+
 	if (oh->rst_lines_cnt =3D=3D 0) {
 		r =3D _enable(oh);
 		if (r) {
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4243190..ce8b53a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1130,6 +1130,29 @@ static void omap_gpio_chip_init(struct gpio_bank *ba=
nk)
=20
 static const struct of_device_id omap_gpio_match[];
=20
+static void omap_gpio_init_context(struct gpio_bank *p)
+{
+	struct omap_gpio_reg_offs *regs =3D p->regs;
+	void __iomem *base =3D p->base;
+
+	p->context.ctrl		=3D readl_relaxed(base + regs->ctrl);
+	p->context.oe		=3D readl_relaxed(base + regs->direction);
+	p->context.wake_en	=3D readl_relaxed(base + regs->wkup_en);
+	p->context.leveldetect0	=3D readl_relaxed(base + regs->leveldetect0);
+	p->context.leveldetect1	=3D readl_relaxed(base + regs->leveldetect1);
+	p->context.risingdetect	=3D readl_relaxed(base + regs->risingdetect);
+	p->context.fallingdetect =3D readl_relaxed(base + regs->fallingdetect);
+	p->context.irqenable1	=3D readl_relaxed(base + regs->irqenable);
+	p->context.irqenable2	=3D readl_relaxed(base + regs->irqenable2);
+
+	if (regs->set_dataout && p->regs->clr_dataout)
+		p->context.dataout =3D readl_relaxed(base + regs->set_dataout);
+	else
+		p->context.dataout =3D readl_relaxed(base + regs->dataout);
+
+	p->context_valid =3D true;
+}
+
 static int omap_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
@@ -1246,6 +1269,7 @@ static int omap_gpio_probe(struct platform_device *pd=
ev)
 	omap_gpio_mod_init(bank);
 	omap_gpio_chip_init(bank);
 	omap_gpio_show_rev(bank);
+	omap_gpio_init_context(bank);
=20
 	pm_runtime_put(bank->dev);
=20
@@ -1325,8 +1349,6 @@ update_gpio_context_count:
 	return 0;
 }
=20
-static void omap_gpio_init_context(struct gpio_bank *p);
-
 static int omap_gpio_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -1466,29 +1488,6 @@ void omap2_gpio_resume_after_idle(void)
 }
=20
 #if defined(CONFIG_PM_RUNTIME)
-static void omap_gpio_init_context(struct gpio_bank *p)
-{
-	struct omap_gpio_reg_offs *regs =3D p->regs;
-	void __iomem *base =3D p->base;
-
-	p->context.ctrl		=3D readl_relaxed(base + regs->ctrl);
-	p->context.oe		=3D readl_relaxed(base + regs->direction);
-	p->context.wake_en	=3D readl_relaxed(base + regs->wkup_en);
-	p->context.leveldetect0	=3D readl_relaxed(base + regs->leveldetect0);
-	p->context.leveldetect1	=3D readl_relaxed(base + regs->leveldetect1);
-	p->context.risingdetect	=3D readl_relaxed(base + regs->risingdetect);
-	p->context.fallingdetect =3D readl_relaxed(base + regs->fallingdetect);
-	p->context.irqenable1	=3D readl_relaxed(base + regs->irqenable);
-	p->context.irqenable2	=3D readl_relaxed(base + regs->irqenable2);
-
-	if (regs->set_dataout && p->regs->clr_dataout)
-		p->context.dataout =3D readl_relaxed(base + regs->set_dataout);
-	else
-		p->context.dataout =3D readl_relaxed(base + regs->dataout);
-
-	p->context_valid =3D true;
-}
-
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
 	writel_relaxed(bank->context.wake_en,

Then, we can even remove ti,no-reset flag from all GPIO DT nodes.

--=20
balbi

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTK9OpAAoJEIaOsuA1yqREazMP/jTzFz43YZ6BhC8y0SFH/+yj
Vzwg1YDQlq9zRqJnuzaEjtykf8WvHE7L9dr+SIq9lBnht75dIKMql++UFo3UWtgb
i+F2oCPWOYewAoYQ97eIloF8b70Jjo3upt68QRMFb4wi6yh56BXa59somzdm6Y4S
pxcaiRPzIjrhleUG0zkav57HFaPoNMIkuwPF2M6c+uxU7i4lu0nridqNta2GsmOh
u6862HvPddvZKrAqW+WKlhbd8Ye5+moGmstHERKVxdOJo9LGTZv04kUc1F343Mwn
sRDh7dxkaHkmHfHAI/pEKxPxVGfG+xnpSr19ctg9v1miMGidGJE+HVKqfgjXIyAd
KM/ywb29wzQ8cOuR37iw7ruSDrOMdkYbuMfWGmQiyJI3RQRm0UEHe2pKQkSIN88P
w28gHTn0Bj8rdznBaNVl+8VX6YlaNhyUKUf1K68XOVDoFf6aKKJjtGeqLqA4xx/f
yxLvvFOG490mhQLFfZzDNwiC2POvDUgMHddIF5ogG1blGxncBwfBJX6ChGzOK+4O
maSsYe0QUNHjG8f67Vv62gG66x2Y1oSUIeOMFZ0kURUqoRuLiSxyeVma5SMWiArb
sIsbdvoKVE2gVk15UtAqD1V99zlydPeZcwRRkfYkPh6v7G2BGZgQRII1wJBnCj3j
KHRZ3Sx53dCd/rCXek+B
=P2dD
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
