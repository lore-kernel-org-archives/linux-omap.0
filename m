From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH for v3.15] usb: musb: Fix panic upon musb_am335x module
 removal
Date: Mon, 23 Jun 2014 13:23:00 -0500
Message-ID: <20140623182300.GC5073@saruman.home>
References: <1400371473-2053-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <20140520165510.GA28859@arch.cereza>
 <20140614125902.GA1202@arch.cereza>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140614125902.GA1202@arch.cereza>
Sender: stable-owner@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tony Lindgren <tony@atomide.com>, Guido =?iso-8859-1?Q?Mart=EDnez?= <guido@vanguardiasur.com.ar>, George Cherian <george.cherian@ti.com>, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2014 at 09:59:02AM -0300, Ezequiel Garcia wrote:
> Hi Felipe,
>=20
> On 20 May 01:55 PM, Ezequiel Garcia wrote:
> > On 17 May 09:04 PM, Ezequiel Garcia wrote:
> > > At probe time, the musb_am335x driver register its childs by
> > > calling of_platform_populate(), which registers all childs in
> > > the devicetree hierarchy recursively.
> > >=20
> > > On the other side, the driver's remove() function uses of_device_unre=
gister()
> > > to remove each child of musb_am335x's.
> > >=20
> > > However, when musb_dsps is loaded, its devices are attached to the mu=
sb_am335x
> > > device as musb_am335x childs. Hence, musb_am335x remove() will attemp=
t to
> > > unregister the devices registered by musb_dsps, which produces a kern=
el panic.
> > >=20
> > > In other words, the childs in the "struct device" hierarchy are not t=
he same
> > > as the childs in the "devicetree" hierarchy.
> > >=20
> > > Ideally, we should enforce the removal of the devices registered by
> > > musb_am335x *only*, instead of all its child devices. However, becaus=
e of the
> > > recursive nature of of_platform_populate, this doesn't seem possible.
> > >=20
> > > Therefore, as the only solution at hand, this commit disables musb_am=
335x
> > > driver removal capability, preventing it from being ever removed. Thi=
s was
> > > originally suggested by Sebastian Siewior:
> > >=20
> > > https://www.mail-archive.com/linux-omap@vger.kernel.org/msg104946.html
> > >=20
> > > And for reference, here's the panic upon module removal:
> > >=20
> > > musb-hdrc musb-hdrc.0.auto: remove, state 4
> > > usb usb1: USB disconnect, device number 1
> > > musb-hdrc musb-hdrc.0.auto: USB bus 1 deregistered
> > > Unable to handle kernel NULL pointer dereference at virtual address 0=
000008c
> > > pgd =3D de11c000
> > > [0000008c] *pgd=3D9e174831, *pte=3D00000000, *ppte=3D00000000
> > > Internal error: Oops: 17 [#1] ARM
> > > Modules linked in: musb_am335x(-) musb_dsps musb_hdrc usbcore usb_com=
mon
> > > CPU: 0 PID: 623 Comm: modprobe Not tainted 3.15.0-rc4-00001-g24efd13 =
#69
> > > task: de1b7500 ti: de122000 task.ti: de122000
> > > PC is at am335x_shutdown+0x10/0x28
> > > LR is at am335x_shutdown+0xc/0x28
> > > pc : [<c0327798>]    lr : [<c0327794>]    psr: a0000013
> > > sp : de123df8  ip : 00000004  fp : 00028f00
> > > r10: 00000000  r9 : de122000  r8 : c000e6c4
> > > r7 : de0e3c10  r6 : de0e3800  r5 : de624010  r4 : de1ec750
> > > r3 : de0e3810  r2 : 00000000  r1 : 00000001  r0 : 00000000
> > > Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> > > Control: 10c5387d  Table: 9e11c019  DAC: 00000015
> > > Process modprobe (pid: 623, stack limit =3D 0xde122240)
> > > Stack: (0xde123df8 to 0xde124000)
> > > 3de0:                                                       de0e3810 =
bf054488
> > > 3e00: bf05444c de624010 60000013 bf043650 000012fc de624010 de0e3810 =
bf043a20
> > > 3e20: de0e3810 bf04b240 c0635b88 c02ca37c c02ca364 c02c8db0 de1b7500 =
de0e3844
> > > 3e40: de0e3810 c02c8e28 c0635b88 de02824c de0e3810 c02c884c de0e3800 =
de0e3810
> > > 3e60: de0e3818 c02c5b20 bf05417c de0e3800 de0e3800 c0635b88 de0f2410 =
c02ca838
> > > 3e80: bf05417c de0e3800 bf055438 c02ca8cc de0e3c10 bf054194 de0e3c10 =
c02ca37c
> > > 3ea0: c02ca364 c02c8db0 de1b7500 de0e3c44 de0e3c10 c02c8e28 c0635b88 =
de02824c
> > > 3ec0: de0e3c10 c02c884c de0e3c10 de0e3c10 de0e3c18 c02c5b20 de0e3c10 =
de0e3c10
> > > 3ee0: 00000000 bf059000 a0000013 c02c5bc0 00000000 bf05900c de0e3c10 =
c02c5c48
> > > 3f00: de0dd0c0 de1ec970 de0f2410 bf05929c de0f2444 bf05902c de0f2410 =
c02ca37c
> > > 3f20: c02ca364 c02c8db0 bf05929c de0f2410 bf05929c c02c94c8 bf05929c =
00000000
> > > 3f40: 00000800 c02c8ab4 bf0592e0 c007fc40 c00dd820 6273756d 336d615f =
00783533
> > > 3f60: c064a0ac de1b7500 de122000 de1b7500 c000e590 00000001 c000e6c4 =
c0060160
> > > 3f80: 00028e70 00028e70 00028ea4 00000081 60000010 00028e70 00028e70 =
00028ea4
> > > 3fa0: 00000081 c000e500 00028e70 00028e70 00028ea4 00000800 becb59f8 =
00027608
> > > 3fc0: 00028e70 00028e70 00028ea4 00000081 00000001 00000001 00000000 =
00028f00
> > > 3fe0: b6e6b6f0 becb59d4 000160e8 b6e6b6fc 60000010 00028ea4 00000000 =
00000000
> > > [<c0327798>] (am335x_shutdown) from [<bf054488>] (dsps_musb_exit+0x3c=
/0x4c [musb_dsps])
> > > [<bf054488>] (dsps_musb_exit [musb_dsps]) from [<bf043650>] (musb_shu=
tdown+0x80/0x90 [musb_hdrc])
> > > [<bf043650>] (musb_shutdown [musb_hdrc]) from [<bf043a20>] (musb_remo=
ve+0x24/0x68 [musb_hdrc])
> > > [<bf043a20>] (musb_remove [musb_hdrc]) from [<c02ca37c>] (platform_dr=
v_remove+0x18/0x1c)
> > > [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_releas=
e_driver+0x70/0xc8)
> > > [<c02c8db0>] (__device_release_driver) from [<c02c8e28>] (device_rele=
ase_driver+0x20/0x2c)
> > > [<c02c8e28>] (device_release_driver) from [<c02c884c>] (bus_remove_de=
vice+0xdc/0x10c)
> > > [<c02c884c>] (bus_remove_device) from [<c02c5b20>] (device_del+0x104/=
0x198)
> > > [<c02c5b20>] (device_del) from [<c02ca838>] (platform_device_del+0x14=
/0x9c)
> > > [<c02ca838>] (platform_device_del) from [<c02ca8cc>] (platform_device=
_unregister+0xc/0x20)
> > > [<c02ca8cc>] (platform_device_unregister) from [<bf054194>] (dsps_rem=
ove+0x18/0x38 [musb_dsps])
> > > [<bf054194>] (dsps_remove [musb_dsps]) from [<c02ca37c>] (platform_dr=
v_remove+0x18/0x1c)
> > > [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_releas=
e_driver+0x70/0xc8)
> > > [<c02c8db0>] (__device_release_driver) from [<c02c8e28>] (device_rele=
ase_driver+0x20/0x2c)
> > > [<c02c8e28>] (device_release_driver) from [<c02c884c>] (bus_remove_de=
vice+0xdc/0x10c)
> > > [<c02c884c>] (bus_remove_device) from [<c02c5b20>] (device_del+0x104/=
0x198)
> > > [<c02c5b20>] (device_del) from [<c02c5bc0>] (device_unregister+0xc/0x=
20)
> > > [<c02c5bc0>] (device_unregister) from [<bf05900c>] (of_remove_populat=
ed_child+0xc/0x14 [musb_am335x])
> > > [<bf05900c>] (of_remove_populated_child [musb_am335x]) from [<c02c5c4=
8>] (device_for_each_child+0x44/0x70)
> > > [<c02c5c48>] (device_for_each_child) from [<bf05902c>] (am335x_child_=
remove+0x18/0x30 [musb_am335x])
> > > [<bf05902c>] (am335x_child_remove [musb_am335x]) from [<c02ca37c>] (p=
latform_drv_remove+0x18/0x1c)
> > > [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_releas=
e_driver+0x70/0xc8)
> > > [<c02c8db0>] (__device_release_driver) from [<c02c94c8>] (driver_deta=
ch+0xb4/0xb8)
> > > [<c02c94c8>] (driver_detach) from [<c02c8ab4>] (bus_remove_driver+0x4=
c/0xa0)
> > > [<c02c8ab4>] (bus_remove_driver) from [<c007fc40>] (SyS_delete_module=
+0x128/0x1cc)
> > > [<c007fc40>] (SyS_delete_module) from [<c000e500>] (ret_fast_syscall+=
0x0/0x48)
> > >=20
> > > Fixes: 97238b35d5bb ("usb: musb: dsps: use proper child nodes")
> > > Cc: <stable@vger.kernel.org> # v3.12+
> > > Acked-by: George Cherian <george.cherian@ti.com>
> > > Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> > > ---
> > >  drivers/usb/musb/musb_am335x.c | 23 ++++++-----------------
> > >  1 file changed, 6 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/drivers/usb/musb/musb_am335x.c b/drivers/usb/musb/musb_a=
m335x.c
> > > index d235378..1e58ed2 100644
> > > --- a/drivers/usb/musb/musb_am335x.c
> > > +++ b/drivers/usb/musb/musb_am335x.c
> > > @@ -19,21 +19,6 @@ err:
> > >  	return ret;
> > >  }
> > > =20
> > > -static int of_remove_populated_child(struct device *dev, void *d)
> > > -{
> > > -	struct platform_device *pdev =3D to_platform_device(dev);
> > > -
> > > -	of_device_unregister(pdev);
> > > -	return 0;
> > > -}
> > > -
> > > -static int am335x_child_remove(struct platform_device *pdev)
> > > -{
> > > -	device_for_each_child(&pdev->dev, NULL, of_remove_populated_child);
> > > -	pm_runtime_disable(&pdev->dev);
> > > -	return 0;
> > > -}
> > > -
> > >  static const struct of_device_id am335x_child_of_match[] =3D {
> > >  	{ .compatible =3D "ti,am33xx-usb" },
> > >  	{  },
> > > @@ -42,13 +27,17 @@ MODULE_DEVICE_TABLE(of, am335x_child_of_match);
> > > =20
> > >  static struct platform_driver am335x_child_driver =3D {
> > >  	.probe		=3D am335x_child_probe,
> > > -	.remove         =3D am335x_child_remove,
> > >  	.driver         =3D {
> > >  		.name   =3D "am335x-usb-childs",
> > >  		.of_match_table	=3D am335x_child_of_match,
> > >  	},
> > >  };
> > > =20
> > > -module_platform_driver(am335x_child_driver);
> > > +static int __init am335x_child_init(void)
> > > +{
> > > +	return platform_driver_register(&am335x_child_driver);
> > > +}
> > > +module_init(am335x_child_init);
> > > +
> > >  MODULE_DESCRIPTION("AM33xx child devices");
> > >  MODULE_LICENSE("GPL v2");
> > > --=20
> > > 1.9.1
> > >=20
> >=20
> > Felipe,
> >=20
> > Any comments on this?
> >=20
>=20
> Any comments on this? I don't like to remove a feature, but as
> explained above, I don't see any other way to solve this.
>=20
> The driver is currently broken. I tried using of_platform_depopulate()
> but failed.

yeah, I know about the problem and, frankly, there's no other way to fix
this. Just resend with linux-usb in Cc.

--=20
balbi

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqHCEAAoJEIaOsuA1yqRE/nIQAJ56vSNzRTVh+2uIoW7Sut7k
ZEAA/pVFuF0Jr3BdB/6Vs0APqTYfJzZqStLu20A6lq5FOpTH6xEXulE8BCkWRb62
gpwOxweqYZmGRMUzqB6SH6wsdUNfL0hr5IIpAwEO5bAaGx93AkAZDiq3Esi0G1m3
mpNxiCjz5gAdVTKAgd83y5IKPqwouOchr816/WtLWGcoli3S0lpT9fMWKqQzgQGE
6tDBWqWRzrC3/p0Iw1nC6oxBZJMORxbDZuPx3+cJUvHnyNJlwRZOg6azwMCkA+mQ
+5gZWv9yLFVKgD71ddWMldUDRgNIKiEMSRyO2MS2XqswMmEzXDNnPmyVysjwvOgB
eEhn0K+4odbnpz2izL5kKfatK01BdaLHqUDms+EF2Ebd0jLvfoCyrcwStNTFP3VO
ANGFUCNdyp0U3UE/Zdx9qlA1kx/tsK2LJQBeUzKVgniV91hiKbXRR2RZe7xnhIzg
9k9yWOGiY0/386oMzShUImu6+WpLjgu0ipd2wylTgQCXfLDxuCWkogxOhG8E0I97
Mpl2P4c4J7OYosABGj1MsDvtQ+rn67nGOMbbMQJ9EcFAzRVuGoyTLVzgBRSlHlEs
O/Q2rSvB2qqN0QSPS+BxgRW4YvrruhylnCWqKyypzMIiJxHPt4HTvpk7SUprU7+U
SHoNifjXxIq0Y0uVJKqN
=Aw77
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
