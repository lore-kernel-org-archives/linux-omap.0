From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC] am33xx: create child nodes for the two musb controllers
Date: Thu, 27 Jun 2013 09:51:50 +0300
Message-ID: <20130627065150.GK15455@arwen.pp.htv.fi>
References: <20130626153325.GA24075@linutronix.de>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130626153325.GA24075-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 26, 2013 at 05:33:26PM +0200, Sebastian Andrzej Siewior wrote:
> I've been thinkig about creating two child nodes for the independent musb
> controllers on the am33. I've been thinking about the following:
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 8e1248f..6aa9506 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -326,21 +326,78 @@
>  			status =3D "disabled";
>  		};
> =20
>  		usb@47400000 {
>  			compatible =3D "ti,musb-am33xx";
> -			reg =3D <0x47400000 0x1000	/* usbss */
> -			       0x47401000 0x800		/* musb instance 0 */
> -			       0x47401800 0x800>;	/* musb instance 1 */
> -			interrupts =3D <17		/* usbss */
> -				      18		/* musb instance 0 */
> -				      19>;		/* musb instance 1 */
> -			multipoint =3D <1>;
> -			num-eps =3D <16>;
> -			ram-bits =3D <12>;
> -			port0-mode =3D <3>;
> -			port1-mode =3D <3>;
> -			power =3D <250>;
> +			reg =3D <0x47400000 0x1000>;	/* usbss */
> +			interrupts =3D <17>;		/* usbss */
>  			ti,hwmods =3D "usb_otg_hs";
> +
> +			usb0@0x47401000 {
> +				reg =3D <0x47401000 0x800>;	/* musb instance 0 */
> +				interrupts =3D <18>;		/* musb instance 0 */
> +				multipoint =3D <1>;
> +				num-eps =3D <16>;
> +				ram-bits =3D <12>;
> +				port-mode =3D <3>;
> +				power =3D <250>;
> +
> +				phys =3D <&nopphy0>;
> +				dmas =3D <&cppi41dma 0
> +					&cppi41dma 1
> +					&cppi41dma 2
> +					&cppi41dma 3
> +					&cppi41dma 4
> +					&cppi41dma 32
> +					&cppi41dma 34
> +					&cppi41dma 36
> +					&cppi41dma 38
> +					&cppi41dma 40>;
> +				dma-names =3D "rx1", "rx2", "rx3", "rx4", "rx5",
> +					    "tx1", "tx2", "tx3", "tx4", "tx5";
> +			};
> +
> +			usb0@0x47401800 {
> +				reg =3D <0x47401800 0x800>;	/* musb instance 1 */
> +				interrupts =3D <19>;		/* musb instance 1 */
> +				multipoint =3D <1>;
> +				num-eps =3D <16>;
> +				ram-bits =3D <12>;
> +				port-mode =3D <3>;
> +				power =3D <250>;
> +
> +				phys =3D <&nopphy1>;
> +				dmas =3D <&cppi41dma 0
> +					&cppi41dma 1
> +					&cppi41dma 2
> +					&cppi41dma 3
> +					&cppi41dma 4
> +					&cppi41dma 62
> +					&cppi41dma 64
> +					&cppi41dma 66
> +					&cppi41dma 68
> +					&cppi41dma 70>;
> +				dma-names =3D "rx1", "rx2", "rx3", "rx4", "rx5",
> +					    "tx1", "tx2", "tx3", "tx4", "tx5";
> +			};
> +		};
>=20
> Please keep in mind that his is not a proper patch it should point out
> what I have in mind.
> This would easy the for instance the dma channel assignment. Also, it will
> move back to the port-mode property instead of portX-mode one which it has
> now. This is kind of confusing since it is not a root hub or anything like
> that it is a complete musb controller. Plus for the phys property could
> easily take the one avaible and would not require which instance it
> really it is.

the patch is alright, but what about the giant amoutn of function
pointers we have ? Are you planning to use of_dev_auxdata ??

--=20
balbi

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRy+EGAAoJEIaOsuA1yqREBnsP/jbW5RANIvkraULneAlIqo9Y
QEaC4pasbiYiAbThwn6UnvlaRt//j3PQJCkwaRs+yMgqjD7oRNvxvP03h7C4MjYx
PPmkaHSGNp2hNKXh10CliEJovvRdYDVwvhcb5atpil2iP6LFQYXIts23ey5qFmfC
Aqzu1kVeA+R0WB20XBW804QlUQny+EL7FO0m14ipVZ/tKe0rKK7mudAH2ez5bAzl
uoPSeyfuBzzK0/NDoThbJEImXpq+hYEcTmgvzWOgFyfkmFqKJTRUKT8AhXGj3+KW
sTWrHybnGePYenlEqMDmUOCUp/UlBN939Pp1MDxLjBya85ZjEGuxB0QhdTOr5ImP
89ZYWL2RTCUI9tii6xe7XsXf1WFSL8Tr5AO/M2CxbK/vqMZJvyu4aup+TAreiZhu
S7QMoO+Pwn12kGu/P+o5YEXvegJ6OK9mBAZf8zBD/V+DPeU+HXKQZXxEg09yZF1Z
8QLA4S5J273NxhQZBiyeMiFZl0Rb+KcDhqiaQ02nl8AE8wYCDQ3ivvdtOPctCg86
bjSYnEh9rdQIA2Zkahy16AkRP93ElM2lImmQiYiBT6UxDeH++dWfuANkP4oOO8uc
cbplSJ2XOVbJR8zKJkotyJRntMOi6/yS2wfiOHkkc4OGLrtKaXe5YCGPmlTVZjB4
8m/ojZETaGjhCBg8e0qN
=p4W5
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
