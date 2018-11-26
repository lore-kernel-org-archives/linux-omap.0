From: Thierry Reding <treding@nvidia.com>
Subject: Re: omap5 fixing palmas IRQ_TYPE_NONE warning leads to gpadc timeouts
Date: Mon, 26 Nov 2018 10:36:26 +0100
Message-ID: <20181126093625.GA10878@ulmo>
References: <CAAfyv35bat+t6awL-VRigAoaUTySwOgZkQMs=W9mEKQ6VDW3FA@mail.gmail.com>
 <20180703084516.GT112168@atomide.com>
 <CAAfyv37F1s8Cg=pfxiN0dA6YEX7KMB-+uifjRoqAdKGWLeYEwA@mail.gmail.com>
 <20181113180656.GE53235@atomide.com>
 <46d271b2-35d3-6353-c530-3292cdac53ab@ti.com>
 <20181119161906.GP53235@atomide.com>
 <20181119171406.GQ53235@atomide.com>
 <725df8e7-4aff-3751-d0b0-809b89e882e5@nvidia.com>
 <20181123164827.GE53235@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181123164827.GE53235@atomide.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Belisko Marek <marek.belisko@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 08:48:27AM -0800, Tony Lindgren wrote:
> * Jon Hunter <jonathanh@nvidia.com> [181120 11:14]:
> > On 19/11/2018 17:14, Tony Lindgren wrote:
> > > Well so commit 7e9d474954f4 ("ARM: tegra: Correct polarity for
> > > Tegra114 PMIC interrupt") states that tegra114 inverts the
> > > polarity of the PMIC interrupt. So adding Jon and Thierry to Cc.
> >=20
> > Yes Tegra can invert the polarity of the PMIC interrupt.
>=20
> So is there some IP on Tegra called "Tegra PMC" that is
> inverting the interrupt? Or is the "Tegra PMC" that commit
> 7e9d474954f4 mentions just the palmas configuration for
> inverting the interrupt?

Yes, there's indeed an IP called PMC (Power-Management Controller) on
Tegra. It has a special input that is usually wired up to the PMIC
interrupt and a bit in the control register that configures the polarity
of that interrupt. If the PMIC generates a low-active interrupt we
usually set that bit to make sure it is properly sampled by the PMC.

The symptoms of this being incorrectly configured is usually an
interrupt storm on the PMIC interrupt, which I think typically results
in the system not booting at all, or taking a very long time to boot
because of that storm.

> The problem I'm having is With omap5 where I can only get the
> PMIC interrupts working with IRQ_TYPE_LEVEL_HIGH if
> PALMAS_POLARITY_CTRL_INT_POLARITY is not set unlike for
> Tegra.

Does somebody have access to the Palmas documentation? That should
pretty clearly state what the default polarity is and what it changes to
if you set the interrupt polarity bit.

=46rom what you're saying it sounds like either the logic is the wrong way
around in the Palmas MFD driver (and we correct it by switching it back
to the correct polarity in the PMC) or that you'd need to find some way
of inverting in on OMAP5.

Thierry

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv7vpcACgkQ3SOs138+
s6GBZBAAvMehEa8A+LGTqIFmDqN1oCIrXPtzxBKNQOXr1R1eR5VS2YCRcZQ0CW4e
UEf+mDgJ+4/i3uEWcidyv6ILuFdy/RQoWvOVOAjeTGQiMkofC8PvetxMo693NXmD
7np9OHR5KUtU87+PkKojUM3SxzJ1ADlm28YMqF3SCqOEMvphXSxoOA3YIPpUttn6
dftMt88yxmXJM58KksnMjZZ2eM/EqBSvlGshJS+uWXQP8isK1KIQgOxx3SRqfIKP
mBhhmhDNq54vqoaEpKcsPjuoqwbBKmAkSj6jahlQ7TGB6bjIMweshZgxWL+Zu4Gd
UPehtHm4yWKqlHYa8kquTgahn3/z8pKr1fpdvvlCrqwXBOxQIOpUMZXqiqWoOipg
urDxeVvM7y0Lic+8QfKOzg0eLysCyDJmkum3rE1ubcvVG6ql1vuWxRr8yr9geTC6
/k3Mb4gU55oWAlB7RUgrvkwOFoAiEwdWnI6aJGtJhiblimW+KV6pvJheAlzQ/BZv
fwaq/vYLf+wkew17Y8oxt6b5RQTGz9Hr6Vpjr5rmaiFHB/6cCR0GWVyQFz83QO2p
SetWlOnIr1QcJ5ieBbuFaY0ip3GagavB+28RDfcRVXF2lMfFQ4q9luf84B4h3Ffi
BjGzfsZpEAlCRoL/o9AN/J441UaEryo2KF7dLDswY1Q1Eh9NEW8=
=sb3s
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
