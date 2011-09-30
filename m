From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/5 v12] arm: omap: usb: register hwmods of usbhs
Date: Fri, 30 Sep 2011 12:32:32 +0300
Message-ID: <20110930093231.GD3458@legolas.emea.dhcp.ti.com>
References: <1317361318-28295-1-git-send-email-keshava_mgowda@ti.com>
 <alpine.DEB.2.00.1109300113200.32653@utopia.booyaka.com>
 <20110930073449.GA13825@legolas.emea.dhcp.ti.com>
 <CAP05o4L1iR++BhYmYYEc-uV6pGfjBeSPPcFqhRizdBeV7Ko26g@mail.gmail.com>
 <20110930091957.GC3458@legolas.emea.dhcp.ti.com>
 <CAP05o4+Ww=R-hOVMbW5St2ZvwrK5cmPtM5_5Gj2pV8W1tdiQ-Q@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP05o4+Ww=R-hOVMbW5St2ZvwrK5cmPtM5_5Gj2pV8W1tdiQ-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: balbi@ti.com, Paul Walmsley <paul@pwsan.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 30, 2011 at 02:56:40PM +0530, Munegowda, Keshava wrote:
> >> >> Usually there's something wrong with omap_devices that contain
> >> >> multiple hwmods. =A0Is there some reason why there isn't a separate=
 driver
> >> >> for the TLL? =A0Judging by a brief look at drivers/mfd/omap_usb_hos=
t.c, the
> >> >> TLL handling looks logically distinct?
> >> >
> >> > Yes, I have the same feeling. To my understanding, USB Host Subsyste=
m on
> >> > OMAP is composed of the Transceiver-less link (TLL) and USB Host (UH=
H).
> >> > Aparently, they could be handled by separate drivers.
> >> >
> >> > --
> >> > balbi
> >>
> >> yes, it can be as two separate drivers for uhh and tll; =A0But i don't
> >> think driver can be used effectively.
> >> Now ehci and ohci gets the clocks , config reg and port settings
> >> through usb host which is sufficient.
> >> If you make them as two different drivers; then ehci and ohci has to
> >> interact with both the drivers separately.
> >> which will be an unnecessary complications. I feel not divided this
> >> driver into two
> >
> > Come again, EHCI/OHCI need clocks from UHH and TLL ?? If that's the
> > case, then there's really no easy way to handle this as a device can
> > have only one parent.
>=20
> yes,  if you are using ehci phy mode ( port modes of UHH_HOSTCONFIG regis=
ter)
> then uhh functional ( omap3: interface clocks too) is sufficient;
> if you are using ehci in tll mode , then you need tll functional clock to=
o.

But those clocks are fed into UHH and TLL respectively, not EHCI/OHCI,
right ? IOW, EHCI/OHCI only need those clocks to be stable in order for
it to work.

I'm trying to think of a way to decouple that but nothing comes to mind
right now... Ideally, calling pm_runtime_get_sync() on EHCI/OHCI would
make all clocks enabled and the only way I see for that to happen is to
make TLL parent of UHH which is parent of EHCI/OHCI, but I'm not sure
that makes a lot of sense.

Paul, do you have any tip which we could use ? What we need is to be
able to call pm_runtime_get_sync() or ehci-omap.c and that should enable
UHH clocks and if (port->mode =3D=3D TLL) enable TLL clocks.

We still want to split UHH and TLL into separate drivers.

--=20
balbi

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOhYyvAAoJEAv8Txj19kN1YrMH/AzjIn4YhHsCiT52UyLm5JoA
Qtk/wc4rPQ3kdsK+kCe3PcyVsDTXWloINmQvxUx4df4VRwoCVmdMD6VOFoC+eXsu
HJd/yBSHXXr/zwLOE+S0xmzCU96xSyVG8agQOSwrlzf/JpGBg3MkuJa2npJKqSRe
oMvhzuAEaO0ExMP5fcvadwAfTd6CfxLbqkkRzM0FrGUSoiEihKHcPOJe08UxPHu5
/vNYweLJfFpe5//4BRk/C2bMIm+cPmPT+X3+D3K7RHjjWr2r3NXHSOrFEWfu1fqk
9+AJm9Zc2+tHwO9PdDCrVb+T9zrByCN0d4WBOj1Fa7oGpC5XtNUKwDSHP2XuadI=
=Z543
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
