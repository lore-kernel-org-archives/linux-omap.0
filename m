From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP CRAP: The Continuing Story Of Brokenness
Date: Mon, 7 Nov 2011 19:51:09 +0200
Message-ID: <20111107175108.GA3999@legolas.emea.dhcp.ti.com>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk>
 <20111107172600.GS31337@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:47062 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933043Ab1KGRvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 12:51:14 -0500
Received: by mail-bw0-f48.google.com with SMTP id r19so6097760bka.35
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 09:51:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111107172600.GS31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Per Forlin <per.forlin@linaro.org>, Chris Ball <cjb@laptop.org>, Felipe Balbi <balbi@ti.com>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 07, 2011 at 09:26:00AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 03:44]:
> > Yet again I find that I'm having to email about crap on OMAP3.
> >=20
> > I'm getting really fed up with OMAP stuff which keeps breaking in
> > idiotic ways - and the way there's fatal build errors at EVERY merge
> > window.  The OMAP workflow is totally broken.  Something MUST change
> > in the way the OMAP community works to stop the continual breakage
> > at every single bloody merge window.
>=20
> Hmm he following fixes are queued elsewhere and now merged:
>=20
> omap_hsmmc: fix missing parenthesis in pr_info
> PM / OPP: Fix build when CONFIG_PM_OPP is not set=20
> net: Add back alignment for size for __alloc_skb
>=20
> Or have you seen some other build errors?
>=20
> FYI, now all the compile warnings are finally gone with what
> I have in fixes branch.
> =20
> > One is new:
> >=20
> > WARNING: at arch/arm/mach-omap2/usb-musb.c:141 usb_musb_init+0xc0/0x174=
()
> > usb_musb_init: could not find omap_hwmod for usb_otg_hs
> > Modules linked in:
> > Backtrace:
> > [<c0017920>] (dump_backtrace+0x0/0x10c) from [<c02d9368>] (dump_stack+0=
x18/0x1c) r7:c181ff20 r6:c03ceb54 r5:c037545b r4:0000008d
> > [<c02d9350>] (dump_stack+0x0/0x1c) from [<c003adfc>] (warn_slowpath_com=
mon+0x58/0x70)
> > [<c003ada4>] (warn_slowpath_common+0x0/0x70) from [<c003aeb8>] (warn_sl=
owpath_fmt+0x38/0x40)
> >  r8:00000000 r7:00000013 r6:c0374b05 r5:c03f06e4 r4:c0374190
> > [<c003ae80>] (warn_slowpath_fmt+0x0/0x40) from [<c03ceb54>] (usb_musb_i=
nit+0xc0/0x174)
> >  r3:c02df894 r2:c03707d9
> > [<c03cea94>] (usb_musb_init+0x0/0x174) from [<c03ce02c>] (omap_ldp_init=
+0xb0/0x100)
> >  r6:c003e7d8 r5:c03f06e4 r4:c04053e4
> > [<c03cdf7c>] (omap_ldp_init+0x0/0x100) from [<c03c6788>] (customize_mac=
hine+0x24/0x30)
> >  r4:c03f03a8
> > [<c03c6764>] (customize_machine+0x0/0x30) from [<c0008710>] (do_one_ini=
tcall+0x9c/0x164)
> > [<c0008674>] (do_one_initcall+0x0/0x164) from [<c03c3284>] (kernel_init=
+0x7c/0x120)
> > [<c03c3208>] (kernel_init+0x0/0x120) from [<c003e7d8>] (do_exit+0x0/0x6=
2c)
> >  r5:c03c3208 r4:00000000
>=20
> Felipe, care to check what the status of the musb hwmod issue
> above is?

doesn't seem to be a bug on usb-musb.c, looking at
omap_hwmod_3xxx_data.c:

$ git grep -A 1 -e "static struct omap_hwmod \w\+usbhsotg_hwmod =3D {"\
	arch/arm/mach-omap2/omap_hwmod*data.c
arch/arm/mach-omap2/omap_hwmod_2430_data.c:static struct omap_hwmod omap243=
0_usbhsotg_hwmod =3D {
arch/arm/mach-omap2/omap_hwmod_2430_data.c-     .name           =3D "usb_ot=
g_hs",
--
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:static struct omap_hwmod omap3xx=
x_usbhsotg_hwmod =3D {
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c-     .name           =3D "usb_ot=
g_hs",
--
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:static struct omap_hwmod am35xx_=
usbhsotg_hwmod =3D {
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c-     .name           =3D "am35x_=
otg_hs",

in fact, that part of the code hasn't changed during this merge window:

$ git log v3.1..linus/master -- arch/arm/mach-omap2/usb-musb.c

commit f718e2c034bf6ff872106344935006230764cb12
Author: Benoit Cousson <b-cousson@ti.com>
Date:   Wed Aug 10 15:30:09 2011 +0200

    ARM: OMAP2+: devices: Remove all omap_device_pm_latency structures
   =20
    Remove all these duplicated structures since a default one is now
    available.
   =20
    Signed-off-by: Benoit Cousson <b-cousson@ti.com>
    Signed-off-by: Kevin Hilman <khilman@ti.com>

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index d86af3c..47fb5d6 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -60,14 +60,6 @@ static struct musb_hdrc_platform_data musb_plat =3D {
=20
 static u64 musb_dmamask =3D DMA_BIT_MASK(32);
=20
-static struct omap_device_pm_latency omap_musb_latency[] =3D {
-	{
-		.deactivate_func	=3D omap_device_idle_hwmods,
-		.activate_func		=3D omap_device_enable_hwmods,
-		.flags			=3D OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
 {
 	switch (board_data->interface_type) {
@@ -150,8 +142,7 @@ void __init usb_musb_init(struct omap_musb_board_data *=
musb_board_data)
                 return;
=20
 	pdev =3D omap_device_build(name, bus_id, oh, &musb_plat,
-			       sizeof(musb_plat), omap_musb_latency,
-			       ARRAY_SIZE(omap_musb_latency), false);
+			       sizeof(musb_plat), NULL, 0, false);
 	if (IS_ERR(pdev)) {
 		pr_err("Could not build omap_device for %s %s\n",
 						name, oh_name);

commit c541c15fb5ab48c47bc9b90121538fd30d152f23
Merge: 5c30cdf be73246 7d33910 ab4eb8b dc9ca24
Author: Tony Lindgren <tony@atomide.com>
Date:   Tue Oct 4 09:47:06 2011 -0700

    Merge branches 'cleanup-part3', 'voltage', 'dmtimer' and 'l3' into dt-b=
ase

could the below be the bug ?

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_3xxx_data.c
index 3008e16..74f1454 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3232,7 +3232,6 @@ static __initdata struct omap_hwmod *omap3430es1_hwmo=
ds[] =3D {
 /* 3430ES2+-only hwmods */
 static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] =3D {
 	&omap3xxx_dss_core_hwmod,
-	&omap3xxx_usbhsotg_hwmod,
 	NULL
 };
=20
@@ -3240,6 +3239,7 @@ static __initdata struct omap_hwmod *omap3430es2plus_=
hwmods[] =3D {
 static __initdata struct omap_hwmod *omap34xx_hwmods[] =3D {
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
+	&omap3xxx_usbhsotg_hwmod,
 	NULL
 };
=20

clearly commit d6504acd (OMAP2+: hwmod: remove OMAP_CHIP*) is wrong at
thinking MUSB is only available on ES2+ revisions of OMAP3430.

--=20
balbi

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOuBqMAAoJEIaOsuA1yqREOHMQAKIKCXdM8wf5e0oQVecz9NaF
nfX4ugBVjVBSBDeMvZKn/tGsKZVPg53vz7hzymEbTGhICZlnfPzDX76jbSOiTFZn
0/LTxkFh2S0V7CaKHKa2rk/DDw4GbM8eyWGr6bAdX0Zp14WzAfs+w5HAP6aykrdY
bGIWiUNhe+aH0aAQdDaJkM7JAE/O+VAFMfW02OC+z4dnCaa1xPngycfBg7Bms+vg
kgsNp/liW2aLV8rIoLE/HjL/C06MClBuDGee8TOZpHv3t91FrZVX2u5kAn9f5zyV
YmXlJMXqNrFFqc2w5Wl2ILpWy7OhWdCiMnrgpjLNbPa87a7eMNnBve/M0puOX5ti
cxoVysOUoyZp4a05ms6t3MOeljZjRgwhLz+nwcGq7EH1Mtq8MqBtD+dgVm1/K7o8
EfDv/sjj2A2raMvoGh2S2VFRHnon23lBSOWZydGErXyA/LhALwAAbazeUOsNGR2B
ODtePY6VkXdD60Tmo5qHFop9B49rhiDu4l8BxMnsVnCJUe4sr32Rkh6yFwzYhFuc
/Kuax+RYhtxzgmF6HApozrHCmAxV/sQQ6jJwzfrUzh61MM1S9ZUY+CStjGy94gR1
VRv4WbORSwpJlKx5yk1gzEHYDoK2MoFhwkyIkcS2AtlciupEjIkdVZIk9WjpMWs+
Ve5xaK5uAiqBQbCXVqLS
=eGTG
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
