From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC] am33xx: create child nodes for the two musb controllers
Date: Thu, 27 Jun 2013 16:22:18 +0300
Message-ID: <20130627132218.GG2372@arwen.pp.htv.fi>
References: <20130626153325.GA24075@linutronix.de>
 <51CC20CF.2080103@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020Ab3F0NWa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jun 2013 09:22:30 -0400
Content-Disposition: inline
In-Reply-To: <51CC20CF.2080103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 01:23:59PM +0200, Benoit Cousson wrote:
> Hi Sebastian,
>=20
> On 06/26/2013 05:33 PM, Sebastian Andrzej Siewior wrote:
> > I've been thinkig about creating two child nodes for the independent mu=
sb
> > controllers on the am33. I've been thinking about the following:
> >=20
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.d=
tsi
> > index 8e1248f..6aa9506 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -326,21 +326,78 @@
> >  			status =3D "disabled";
> >  		};
> > =20
> >  		usb@47400000 {
> >  			compatible =3D "ti,musb-am33xx";
> > -			reg =3D <0x47400000 0x1000	/* usbss */
> > -			       0x47401000 0x800		/* musb instance 0 */
> > -			       0x47401800 0x800>;	/* musb instance 1 */
> > -			interrupts =3D <17		/* usbss */
> > -				      18		/* musb instance 0 */
> > -				      19>;		/* musb instance 1 */
> > -			multipoint =3D <1>;
> > -			num-eps =3D <16>;
> > -			ram-bits =3D <12>;
> > -			port0-mode =3D <3>;
> > -			port1-mode =3D <3>;
> > -			power =3D <250>;
> > +			reg =3D <0x47400000 0x1000>;	/* usbss */
> > +			interrupts =3D <17>;	=09

trailing whitespaces here

> BTW, why do have so many DMA compared to the previous version?
> /* usbss */
> >  			ti,hwmods =3D "usb_otg_hs";
> > +
> > +			usb0@0x47401000 {
> > +				reg =3D <0x47401000 0x800>;	/* musb instance 0 */
> > +				interrupts =3D <18>;		/* musb instance 0 */
> > +				multipoint =3D <1>;
> > +				num-eps =3D <16>;
> > +				ram-bits =3D <12>;
> > +				port-mode =3D <3>;
> > +				power =3D <250>;
> > +
> > +				phys =3D <&nopphy0>;
> > +				dmas =3D <&cppi41dma 0
> > +					&cppi41dma 1
> > +					&cppi41dma 2
> > +					&cppi41dma 3
> > +					&cppi41dma 4
> > +					&cppi41dma 32
> > +					&cppi41dma 34
> > +					&cppi41dma 36
> > +					&cppi41dma 38
> > +					&cppi41dma 40>;
> > +				dma-names =3D "rx1", "rx2", "rx3", "rx4", "rx5",
> > +					    "tx1", "tx2", "tx3", "tx4", "tx5";
> > +			};
> > +
> > +			usb0@0x47401800 {
> > +				reg =3D <0x47401800 0x800>;	/* musb instance 1 */
> > +				interrupts =3D <19>;		/* musb instance 1 */
> > +				multipoint =3D <1>;
> > +				num-eps =3D <16>;
> > +				ram-bits =3D <12>;
> > +				port-mode =3D <3>;
> > +				power =3D <250>;
> > +
> > +				phys =3D <&nopphy1>;
> > +				dmas =3D <&cppi41dma 0
> > +					&cppi41dma 1
> > +					&cppi41dma 2
> > +					&cppi41dma 3
> > +					&cppi41dma 4
> > +					&cppi41dma 62
> > +					&cppi41dma 64
> > +					&cppi41dma 66
> > +					&cppi41dma 68
> > +					&cppi41dma 70>;
> > +				dma-names =3D "rx1", "rx2", "rx3", "rx4", "rx5",
> > +					    "tx1", "tx2", "tx3", "tx4", "tx5";
> > +			};
> > +		};
> >=20
> > Please keep in mind that his is not a proper patch it should point out
> > what I have in mind.
> > This would easy the for instance the dma channel assignment. Also, it w=
ill
> > move back to the port-mode property instead of portX-mode one which it =
has
> > now. This is kind of confusing since it is not a root hub or anything l=
ike
> > that it is a complete musb controller. Plus for the phys property could
> > easily take the one avaible and would not require which instance it
> > really it is.
>=20
> I don't know the HW in detail, but that looks indeed much better and
> seems to reflect the partitioning with multiple instances accurately.
>=20
> If Felipe is OK with that partitioning, I'll take it.

it's alright with me

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRzDyKAAoJEIaOsuA1yqREjn4QAIc+AOfkLz8983nnG7c3OY0I
npX6anA3j11aQI2qlNari9Pyizy30AdfdTp1tIUtpmi5YlkinOfnG1PKjms0QBy4
g4SXYFOzIuNy1t8LbXKDAv/AAhRHy20Jy5TALkLUYnquwjBpD4vrtDhmCctF+mic
ied4w6sAOKD4dxg9PzAbIeaOnQTu/9iCa/ZxT164q9HR1YvYhRJbPD2cZNqRU3E1
mzi4rNzh0h837O3vIbHcohPHIQD81Q6zrQWqCi+Qxd08yrVxX5qgnZbFmTG+OKzl
cP7Cf39T4MWygUOV7c8pUkE8+bg/Pc6gCDH+D1a0V63WkAz4qy97gv2NN6nKkjAr
TIk2H5OKB24R2Z3bAsHB2X0NgQ4wt88UVHn+TOcXool2IK7oxAUD1n+pziwHfq1e
1EOHTB48S30FUCapAN/Q0kKH68RsXuzYA4gcm6Q761NgE7qluAl31ChkVEgl2ssx
s3AzJUsvgO2gNd96phwyVb5tH89nVr+opmq70JhuwYOwdJiD+zMUr+pN3OC9rCYi
bneBdDUfqsB+aVYnHskKVF8SDz9bPBxKNeCTWohpL4WfYW+iWMJrU67fpLjIF5kt
AAOioctDhL3gJyjABHa2E/MrCUb8vpYaAWLSg08I5DiDHXkLK+aDRmgG03DwYDjA
DIqzB4u9qL+BxaSSK/cz
=HmEw
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
