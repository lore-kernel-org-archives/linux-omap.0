From: Felipe Balbi <balbi@ti.com>
Subject: Re: Division by zero caused by CCF
Date: Tue, 30 Jul 2013 17:04:41 +0300
Message-ID: <20130730140441.GK28162@radagast>
References: <20130716123709.GA15036@arwen.pp.htv.fi>
 <51E5465F.3090801@ti.com>
 <CAPtuhTiUsLffRaC+8Gd8me2OYeMUOuFM4CqW3vnXmkkp53P_yg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/ZYM6PqDyfNytx60"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44513 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893Ab3G3OFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 10:05:17 -0400
Content-Disposition: inline
In-Reply-To: <CAPtuhTiUsLffRaC+8Gd8me2OYeMUOuFM4CqW3vnXmkkp53P_yg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Luciano Coelho <coelho@ti.com>

--/ZYM6PqDyfNytx60
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is still broken on v3.11-rc3 and Luca got his Blaze (OMAP4) to fail
the same way

On Tue, Jul 16, 2013 at 10:45:38AM -0700, Mike Turquette wrote:
> On Tue, Jul 16, 2013 at 6:10 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> >
> >
> > Hi,
> >
> > Adding Mike's correct address.
> >
> > On 16-07-2013 08:37, Felipe Balbi wrote:
> >> Hi,
> >>
> >> trying to get USB host verified on OMAP5 uEVM with v3.11-rc1. The
> >> clk_set_rate() call ends up in a division by zero, which is quite
> >> interesting provided the driver will only call clk_set_rate() if the
> >> clock is valid and clk_rate is !=3D 0.
> >>
> >>
> >> [   22.009238] Division by zero in kernel.
> >> [   22.009250] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.=
11.0-rc1-00081-g3310d44-dirty #118
> >> [   22.009275] [<c001c83c>] (unwind_backtrace+0x0/0xf0) from [<c0018a1=
c>] (show_stack+0x10/0x14)
> >> [   22.009289] [<c0018a1c>] (show_stack+0x10/0x14) from [<c057403c>] (=
dump_stack+0x70/0x8c)
> >> [   22.009304] [<c057403c>] (dump_stack+0x70/0x8c) from [<c02e4154>] (=
Ldiv0+0x8/0x10)
> >> [   22.009319] [<c02e4154>] (Ldiv0+0x8/0x10) from [<c048d460>] (clk_di=
vider_set_rate+0x10/0xdc)
> >> [   22.009331] [<c048d460>] (clk_divider_set_rate+0x10/0xdc) from [<c0=
48c124>] (clk_change_rate+0x38/0xb0)
> >> [   22.009341] [<c048c124>] (clk_change_rate+0x38/0xb0) from [<c048c20=
c>] (clk_set_rate+0x70/0xa8)
> >> [   22.009354] [<c048c20c>] (clk_set_rate+0x70/0xa8) from [<c042b244>]=
 (nop_usb_xceiv_probe+0x1fc/0x2f8)
> >> [   22.009369] [<c042b244>] (nop_usb_xceiv_probe+0x1fc/0x2f8) from [<c=
036b47c>] (platform_drv_probe+0x18/0x1c)
> >> [   22.009380] [<c036b47c>] (platform_drv_probe+0x18/0x1c) from [<c036=
9f44>] (really_probe+0x70/0x1f4)
> >> [   22.009390] [<c0369f44>] (really_probe+0x70/0x1f4) from [<c036a1dc>=
] (driver_probe_device+0x30/0x48)
> >> [   22.009401] [<c036a1dc>] (driver_probe_device+0x30/0x48) from [<c03=
6a288>] (__driver_attach+0x94/0x98)
> >> [   22.009411] [<c036a288>] (__driver_attach+0x94/0x98) from [<c036874=
8>] (bus_for_each_dev+0x54/0x88)
> >> [   22.009420] [<c0368748>] (bus_for_each_dev+0x54/0x88) from [<c03697=
2c>] (bus_add_driver+0xdc/0x29c)
> >> [   22.009430] [<c036972c>] (bus_add_driver+0xdc/0x29c) from [<c036a76=
0>] (driver_register+0x78/0x190)
> >> [   22.009440] [<c036a760>] (driver_register+0x78/0x190) from [<c00087=
b0>] (do_one_initcall+0x34/0x164)
> >> [   22.009453] [<c00087b0>] (do_one_initcall+0x34/0x164) from [<c07b18=
f4>] (do_basic_setup+0x90/0xc4)
> >> [   22.009466] [<c07b18f4>] (do_basic_setup+0x90/0xc4) from [<c07b199c=
>] (kernel_init_freeable+0x74/0x110)
> >> [   22.009478] [<c07b199c>] (kernel_init_freeable+0x74/0x110) from [<c=
05676c4>] (kernel_init+0x8/0xe4)
> >> [   22.009491] [<c05676c4>] (kernel_init+0x8/0xe4) from [<c0014648>] (=
ret_from_fork+0x14/0x2c)
> >>
> >> I believe the problem is the actual division reaching
> >> clk_divider_set_rate().
> >>
> >> drivers/clk/clk-divider.c::clk_divider_set_rate()
> >>
> >> | static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rat=
e,
> >> |                                 unsigned long parent_rate)
> >> | {
> >> |         struct clk_divider *divider =3D to_clk_divider(hw);
> >> |         unsigned int div, value;
> >> |         unsigned long flags =3D 0;
> >> |         u32 val;
> >> |
> >> |         div =3D parent_rate / rate;
> >>
> >> right here, but how come rate would zero provided driver checks for it
> >> as below.
> >>
> >> drivers/usb/phy/phy-nop.c::nop_usb_xceiv_probe()
> >>
> >> |         if (!IS_ERR(nop->clk) && clk_rate) {
> >> |                 err =3D clk_set_rate(nop->clk, clk_rate);
> >> |                 if (err) {
> >> |                         dev_err(&pdev->dev, "Error setting clock rat=
e\n");
> >> |                         return err;
> >> |                 }
> >> |         }
> >>
> >> I've added a few prints around CCF to try and track what's going on:
> >>
> >> [   21.592690] =3D=3D=3D=3D> nop_usb_xceiv_probe rate 19200000
> >> [   21.592700] =3D=3D=3D=3D> clk_set_rate rate 19200000
> >> [   21.592707] =3D=3D=3D=3D> clk_calc_new_rates rate 19200000
> >> [   21.592713] =3D=3D=3D=3D> clk_divider_round_rate rate 19200000
> >> [   21.592719] =3D=3D=3D=3D> clk_divider_bestdiv rate 19200000
> >> [   21.592726] =3D=3D=3D=3D> clk_change_rate best_parent_rate 0
> >
> > or because we reach:
> >         if (clk->ops->set_rate)
> >                 clk->ops->set_rate(clk->hw, clk->new_rate, best_parent_=
rate);
> >
> > with clk->new_rate =3D=3D 0.
>=20
> Hmm, I'll look into this. We used to have a check which would at least
> WARN on division by zero, but looks like that was replaced by some
> other code at some point.
>=20
> Also does your clock have the CLK_SET_RATE_PARENT flag set? If so then
> you could be propagating a rate request of zero up to the next parent,
> which would be a neat trick... however based on the dump that doesn't
> seem to be what is happening.
>=20
> Regards,
> Mike
>=20
> >
> >
> >> [   21.592732] =3D=3D=3D=3D> clk_divider_set_rate rate 0
> >> [   21.592737] Division by zero in kernel.
> >> [   21.592747] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W    3.=
11.0-rc1-00081-g3310d44-dirty #121
> >> [   21.592773] [<c001c83c>] (unwind_backtrace+0x0/0xf0) from [<c0018a1=
c>] (show_stack+0x10/0x14)
> >> [   21.592787] [<c0018a1c>] (show_stack+0x10/0x14) from [<c057400c>] (=
dump_stack+0x70/0x8c)
> >> [   21.592803] [<c057400c>] (dump_stack+0x70/0x8c) from [<c02e4154>] (=
Ldiv0+0x8/0x10)
> >> [   21.592819] [<c02e4154>] (Ldiv0+0x8/0x10) from [<c048d3e0>] (clk_di=
vider_set_rate+0x2c/0x100)
> >> [   21.592831] [<c048d3e0>] (clk_divider_set_rate+0x2c/0x100) from [<c=
048c050>] (clk_change_rate+0x48/0xe0)
> >> [   21.592841] [<c048c050>] (clk_change_rate+0x48/0xe0) from [<c048c17=
4>] (clk_set_rate+0x8c/0xc0)
> >> [   21.592855] [<c048c174>] (clk_set_rate+0x8c/0xc0) from [<c042b254>]=
 (nop_usb_xceiv_probe+0x20c/0x304)
> >> [   21.592869] [<c042b254>] (nop_usb_xceiv_probe+0x20c/0x304) from [<c=
036b47c>] (platform_drv_probe+0x18/0x1c)
> >> [   21.592880] [<c036b47c>] (platform_drv_probe+0x18/0x1c) from [<c036=
9f44>] (really_probe+0x70/0x1f4)
> >> [   21.592891] [<c0369f44>] (really_probe+0x70/0x1f4) from [<c036a1dc>=
] (driver_probe_device+0x30/0x48)
> >> [   21.592901] [<c036a1dc>] (driver_probe_device+0x30/0x48) from [<c03=
6a288>] (__driver_attach+0x94/0x98)
> >> [   21.592911] [<c036a288>] (__driver_attach+0x94/0x98) from [<c036874=
8>] (bus_for_each_dev+0x54/0x88)
> >> [   21.592921] [<c0368748>] (bus_for_each_dev+0x54/0x88) from [<c03697=
2c>] (bus_add_driver+0xdc/0x29c)
> >> [   21.592930] [<c036972c>] (bus_add_driver+0xdc/0x29c) from [<c036a76=
0>] (driver_register+0x78/0x190)
> >> [   21.592941] [<c036a760>] (driver_register+0x78/0x190) from [<c00087=
b0>] (do_one_initcall+0x34/0x164)
> >> [   21.592954] [<c00087b0>] (do_one_initcall+0x34/0x164) from [<c07b18=
f4>] (do_basic_setup+0x90/0xc4)
> >> [   21.592966] [<c07b18f4>] (do_basic_setup+0x90/0xc4) from [<c07b199c=
>] (kernel_init_freeable+0x74/0x110)
> >> [   21.592980] [<c07b199c>] (kernel_init_freeable+0x74/0x110) from [<c=
0567694>] (kernel_init+0x8/0xe4)
> >> [   21.592992] [<c0567694>] (kernel_init+0x8/0xe4) from [<c0014648>] (=
ret_from_fork+0x14/0x2c)
> >>
> >> even though driver passed 19.2MHz, best_parent_rate ends up being zero
> >> which triggers the division by zero above.
> >>
> >> cheers
> >>
> >
> >
> > - --
> > You have got to be excited about what you are doing. (L. Lamport)
> >
> > Eduardo Valentin
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.4.12 (GNU/Linux)
> > Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
> >
> > iF4EAREIAAYFAlHlRl8ACgkQCXcVR3XQvP00XQEAtQgDEJLt8OFCJiIhUj46Zq1h
> > PvNq67RSFTRXcq/zHa8A/0IZSPitTXt1TqDfalTKof/DR6n9/W6md8/C2Ovqb59o
> > =3DAKnu
> > -----END PGP SIGNATURE-----

--=20
balbi

--/ZYM6PqDyfNytx60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR98f5AAoJEIaOsuA1yqREQyQP/2veQv8Dr1ewxLbLKCmfSvb7
YPxXT2tSLhOu8CLoRFFWewAciISql/1qB0SLlAt2QJTDK7aiH4ecqD3c+h1v9H8f
XKNXHpRCOTGe/ErUA0M4rO2nQxJ6AbIV2kX4PXqLRSo8bEsjbXdP9Y9A26pZNv4K
bN4Hd3OqDcG6/AaaUGL2xwYjgmzx4fbdToM5zLcrbfFdB8zhEZBHkvL3NYrCXY6o
thdGqSo6R2EJlmMrMZsVGxnehbhBS50mA5LGggIKYCQXtWQ0HmAYzGZBqepnU24O
0mpMlsoXUYBVUvJwFUk5vFUR5welVWY1k87TjsYJFjaC1g8yBdQ4CgkidProdY+9
QcZyN7rOYaF3zxjjXlAYBI2uH65uPNNp9wBrYNeWE2Dvmivv2wRFHb0flrPOc3OM
v+SGd7IYMqE3/Ru/TotrWXdTX4SgGUw06EBsHneNjvwrK7doBPUCqFt9vxP+y4dt
BwZHLqHQu7SUfy+A+ZPcGj95uqOqrerft+X7L3sYAKnssUVmoaGo2+4vmbZokQpA
B9JreRm35Kh+bdo/ajj+fmFJkAqaB3wOA1EkWPKYMvDGSMOuTIifMh55F8ZMCJg3
PAcfoBAQt6QDZf3+Ldu8m7kuB6FbsK7I9FHy62PitBmjLanoRPuVFUB72OoV6cfT
gQqUl1HMRrHYr414Hggg
=0Rzf
-----END PGP SIGNATURE-----

--/ZYM6PqDyfNytx60--
