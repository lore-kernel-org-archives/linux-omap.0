From: Thierry Reding <treding@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Mon, 26 Nov 2018 11:25:42 +0100
Message-ID: <20181126102541.GC10878@ulmo>
References: <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
 <20181126093625.GA10878@ulmo>
 <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d3f17ac6-c13b-5b5f-a482-b565b130f1ba@ti.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Jon Hunter <jonathanh@nvidia.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 11:49:54AM +0200, Peter Ujfalusi wrote:
> Thierry,
>=20
> On 11/26/18 11:36 AM, Thierry Reding wrote:
> > On Fri, Nov 23, 2018 at 08:48:27AM -0800, Tony Lindgren wrote:
> >> * Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
> >>> On 19/11/2018 17:14, Tony Lindgren wrote:
> >>>> Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> >>>> Tegra114 PMIC interrupt") states that tegra114 inverts the
> >>>> polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
> >>>
> >>> Yes Tegra can invert the polarity of the PMIC interrupt.
> >>
> >> So is there some IP on Tegra called "Tegra PMC" that is
> >> inverting the interrupt? Or is the "Tegra PMC" that commit
> >> 7e9d474954f4 mentions just the palmas configuration for
> >> inverting the interrupt?
> >=20
> > Yes, there's indeed an IP called PMC (Power-Management Controller) on
> > Tegra. It has a special input that is usually wired up to the PMIC
> > interrupt and a bit in the control register that configures the polarity
> > of that interrupt. If the PMIC generates a low-active interrupt we
> > usually set that bit to make sure it is properly sampled by the PMC.
> >=20
> > The symptoms of this being incorrectly configured is usually an
> > interrupt storm on the PMIC interrupt, which I think typically results
> > in the system not booting at all, or taking a very long time to boot
> > because of that storm.
> >=20
> >> The problem I'm having is With omap5 where I can only get the
> >> PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
> >> PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
> >> Tegra.
> >=20
> > Does somebody have access to the Palmas documentation? That should
> > pretty clearly state what the default polarity is and what it changes to
> > if you set the interrupt polarity bit.
>=20
> The register map documentation I have states the following:
> bit7 INT_POLARITY Select the polarity of the INT output line
> 0: Interrupt line (INT) is low when interrupt is pending (default) RW
> 1: Interrupt line (INT) is high when interrupt is pending
>=20
> By default the Palmas irq is active low.

That would confirm that the driver code is correct. My understanding is
that the PMC on Tegra expects a low-active IRQ from the PMIC, so we need
to invert the interrupt again in the PMC.

> > From what you're saying it sounds like either the logic is the wrong way
> > around in the Palmas MFD driver (and we correct it by switching it back
> > to the correct polarity in the PMC) or that you'd need to find some way
> > of inverting in on OMAP5.

=46rom the above it sounds like there would need to be some mechanism in
OMAP5 to invert the PMIC interrupt, similarly to how it is done in the
PMC on Tegra.

Thierry

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv7yiIACgkQ3SOs138+
s6Gzug/+JNM3GWVVAq4tUhcK81m2KTuysWyjWF4VVKDgpi6U9esstKZaTTTZde8N
dOmkgjZeKGlzOHyuqrM4ax2GD8BMN4v/eXgXifQ8ybTDYs3UU2V7elcJ7Mqm49oJ
fIVDmOedsR0p5oemtMIhs9Grt6bVPoqtKMa2AbzKBawp2kmJ4kmTnCcbDs1ZLoWd
dO1yHVY2npdOIIycsfL4NqtVm/b/EFEsnDMVjnau7FsZbbVCNG3gxUM0fZ9yb8+G
H9UeQOA2NqcX3u0PhCVnpWZxtrgtWRU/WUpnEIg+JM+M4kZMP0Ac1zF0I2moA8bY
AmFzDceqPWUINjTGgXw7eUNAFrnZAGw1oP5ebxFE+jcu1b6OhGmqN+SpdG4cmNBx
p19KGI8bwkA+mBNxP4bMKn8KHRq5zJMI/pYRR2b9/PAXx3JOZKIW8FZ3uBVuKSzX
ggOAFRZ+AH7vGtFednADnktNduOxYWJZfCcElGF/WkSBHn26HkUN9l99klreCfMD
mEw8wzRl2pZJ0qTAEqSHnYHwQzF3S2FTvQqOmtJwKyB3kifOLY2yFYyd0TJkGYHd
EemjDsxw/0e6FS9lWDava3dfMOvet/pHUUkGoN+dHfAmdWghEXv8hlSwbCSng/Rs
igmmOuLdkJG8Qu/qTQHdSh4Nx0W+zivwoelbheJvqxAgu4FleVM=
=uTXL
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
