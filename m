From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 11/15] mfd: menelaus: Start to use irqdomain
Date: Tue, 10 Dec 2013 10:34:30 -0600
Message-ID: <20131210163430.GG22750@saruman.home>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-11-git-send-email-balbi@ti.com>
 <20131210092050.GT12675@lee--X1>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0074697113478000972=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131210092050.GT12675@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============0074697113478000972==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Content-Disposition: inline

--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2013 at 09:20:50AM +0000, Lee Jones wrote:
> > Introduce an irq_chip and irq_domain for menelaus driver. Following
> > patches will convert uses to traditional request_threaded_irq().
> >=20
> > While at that, some better error handling had to be added, so we could
> > free irq descs we allocated.
> >=20
> > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/mfd/menelaus.c | 127 +++++++++++++++++++++++++++++++++++++++++=
+++++---
>=20
> <snip>
>=20
> > +	irq_domain_add_legacy(node, MENELAUS_NR_IRQS, irq_base, 0,
> > +			&irq_domain_simple_ops, m);
>=20
> When will this driver become DT compliant?

when OMAP2 becomes DT-compliant. It still boots with legacy board-file +
platform_data.

> > +	m->irq_base =3D irq_base;
> > +
> > +	for (i =3D irq_base; i < irq_base + MENELAUS_NR_IRQS; i++) {
> > +		irq_set_chip_data(i, m);
> > +		irq_set_chip_and_handler(i, &menelaus_irq_chip,
> > +				handle_simple_irq);
> > +		irq_set_nested_thread(i, 1);
> > +		set_irq_flags(i, IRQF_VALID);
>=20
> This assumes that this h/w only exists on ARM platforms. Is that true?

it was made *only* for Nokia to use on their ARM-only internet tablets.

--=20
balbi

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSp0KWAAoJEIaOsuA1yqRELeMP/3vnmiN4TrDab5alk8KN5CfW
d6WcI6vFBahkeePlZssHfu5687RqBy3U0ucwCJxFOCOY+ooWivZO6paGr/m8zh1t
oxj3aM0TvbIZKN875UiVinDl8RrvqhWvycdpbBZNVUIm310HsFY7pYav5pUN57Ve
GqD6yNw+++kuHonl3DAy/d4oRREzm6zkEKPxXm/1IbmNTkg/vuuudsWIrO6mjIG/
hdcmFdzAh9w02A1RzHyMrdqAEWGNGCy9hxnXAzUmyMm4crxKIncEeUHA41Jl0RWl
T20TFZOHj96ffLikEAXXej73BgH+DDk5Qgq0u1aWEoDdtsQ/TwK7P3wtWjddnEO2
gzZeiw7Fu2DdUvyzDhbQy8mbiqoCdsBxFIaTxj3bBtX4XEE3ZD79G5oj2yFLc6Yu
uHprF8H5hdGptRuE5a29V2B+lbPikMU4O4T27kCN4ZxbJ+3du81qasdvmcIRuSIQ
+tShmQ2PUtyU5WaZHxdZhFrhjy07rspjuHIeHqtd0/8UWLFRQuHSkYNOJjXqnSqC
857mfDCrGjx9zS7RzhwvkVx8aR3KqKDqjCrWii3S+vgMUAnsxaYBJ+d/F7tXhCvK
uGB4AkDyFVqd6mh62k7fhmavVFdX50O5OtcMR4oArXn/DdX6OwKGNluMkWBs+eey
Y2cs0MW/Dz951jsQkm9l
=vtgS
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--


--===============0074697113478000972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0074697113478000972==--
