From: Thierry Reding <treding@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Mon, 26 Nov 2018 11:14:35 +0100
Message-ID: <20181126101434.GB10878@ulmo>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119171406.GQ53235@atomide.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 19, 2018 at 09:14:06AM -0800, Tony Lindgren wrote:
> Hi,
>=20
> * Tony Lindgren <tony@atomide.com> [181119 16:19]:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [181119 10:16]:
> > > On 2018-11-13 20:06, Tony Lindgren wrote:
> > > > Looks like the IRQ_TYPE_NONE issue still is there for omap5 and
> > > > should be fixed with IRQ_TYPE_HIGH.
> > > >=20
> > > > No idea about why palmas interrupts would stop working though,
> > > > Peter, do you have any ideas on this one?
> > >=20
> > > No, I don't.
> > > The INT polarity can be changed in Palmas.
> > > based on the pdata->irq_flags (queried via irqd_get_trigger_type())
> > > the code  configures it:
> > >=20
> > > if (pdata->irq_flags & IRQ_TYPE_LEVEL_HIGH)
> > > 	reg =3D PALMAS_POLARITY_CTRL_INT_POLARITY;
> > > else
> > > 	reg =3D 0;
> > >=20
> > > and we pass the same irq_flags to the regmap_add_irq_chip()
> > > IRQ_TYPE_LEVEL_HIGH =3D=3D IRQF_TRIGGER_HIGH =3D=3D 0x00000004
> > >=20
> > > A change in DT should be enough, no need to patch palmas.c, imho.
> >=20
> > But it's not. I'm now wondering if wakeupgen is inverting the
> > polarity for this interrupt?
> >=20
> > GIC docs say this about SPI interrupts:
> >=20
> > "SPI is triggered on a rising edge or is active-HIGH level-sensitive."
> >=20
> > So when setting IRQ_TYPE_LEVEL_HIGH in dts, we still must not
> > invert the polarity in palmas while tegra needs to. So either
> > tegra114 hardware is inverting the polarity, or omap5 wakeupgen
> > is.
> >=20
> > Does the palmas trm say which way PALMAS_POLARITY_CTRL
> > triggers if PALMAS_POLARITY_CTRL_INT_POLARITY is set?
> >=20
> > Also note that dra7 is using a gpio for palmas interrupt.
>=20
> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> Tegra114 PMIC interrupt") states that tegra114 inverts the
> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
>=20
> So it seems that commit df545d1cd01a ("mfd: palmas: Provide
> irq flags through DT/platform data") wrongly sets the
> PALMAS_POLARITY_CTRL_INT_POLARITY on IRQ_TYPE_LEVEL_HIGH
> while it should set it on IRQ_TYPE_LEVEL_LOW.

Oops, sorry, you seem to have come to pretty much the same conclusion as
I did. I think what we need to do is find a copy of the TRM and see what
exactly the right behaviour is. Or we need to find someone that can take
measurements of the PMIC interrupt pin.

I was unable to find a working link to a copy of the Palmas TRM. Laxman,
do you know of an internal location where we may have a copy?

> I think the fix needs to set the polarity using
> of_machine_is_compatible() and probably also add a new
> compatible to palmas.c for "ti,palmas-tegra114" to properly
> deal with the inverted interrupt. Or add a property for
> "interrupt-inverted". In any case, it seems that the
> of_machine_is_compatible() is also needed too to avoid
> breaking use with dtb files.
>=20
> Jon & Thierry, can you guys please check and confirm this?

I'm not sure we need to go to those lengths. As far as I'm concerned, if
it turns out that we've inverted the logic for Tegra114, that's a bug in
the DTS and we should fix it along with the driver to remove the double
negation. I don't think this would be causing any problems with existing
DTBs since, as far as I can tell, the TPS65913 is only used on Dalmore
(which was never publicly available) or Roth and TN7, neither of which I
think anyone ever ran upstream Linux on other than maybe Alex who added
the support. In all of the above cases, there is no problem updating the
DTB since it's all loaded either from eMMC or from an Android boot image
as far as I understand.

But again, I think we need to make sure to get this right, so we need to
find an authoritative source that tells us what exactly the polarity is,
so that we avoid revisiting this a few years down the road.

Thierry

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv7x4gACgkQ3SOs138+
s6ErVw/+OViR6nYK4bhf9UCAgzn49Xq2HR/YzuiykaCRqblr6nd+UJPMEasgrLmW
GMqC8uJBENWr3UO1AFdvPnSHJ5R7cXnEZcpsvMKLrnexkpiIy1TbD99Zc/tSAXZt
N7UMFZsU/ciOjShpXjDUUWqqIQZHbPEhQf4GwKcxvDEujj3A91m0f3KPnSNrbopb
S5/5F+smwO0lob2BhI+B0oj6IgXgGjEN2VqNC75bHrKR1Q6Pc9JrEOW1nw1u4AgI
aAYpL/ymDLYlnEwLL4X2OlftOkq1NOsM2/kVMXlC/fVJfLgARGNcsClaV5WobjHT
OaXrsaQ5EGfvhnyaMAcgrtMoNoLfAw2wzP+JArnmal9VFjyCGllSPLMDafyDvn1y
44bI7KttwnTmXZwz9arJK4ZjX2Gg3bppOMmb0TqvVVa5VGFiKsRJ717SGbitlhkT
CQf2HHhvb1GnbWAxMqjrW3djDPdQQi/sajARPSjvzAdDw8UXhpArPDVykZbvX0eb
2ff4Qsf12IQt743mEWC/j7Zq4pJKMo8fL7w1N51pJ7ScHlnFNPKkWK/wl0Lnq/DD
HgWgZ46T5Iz/6X9+G490yo3wpyvFJzfK3vJJda/2zcEF1KjxnTfWcbq8K/jL67zN
9N8rKWAHsPJV+gRQcJfUW3bL7G+Hu141xTvN7/2iTPsTMt1Y8Dw=
=hkwM
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
