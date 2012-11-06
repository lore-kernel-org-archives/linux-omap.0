From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] usb: musb: dsps: dt binding - add resources, example
Date: Tue, 6 Nov 2012 18:44:45 +0200
Message-ID: <20121106164445.GE3993@arwen.pp.htv.fi>
References: <1352210166-7253-1-git-send-email-afzal@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352210166-7253-1-git-send-email-afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Santhapuri Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2012 at 07:26:06PM +0530, Afzal Mohammed wrote:
> OMAP2+ family of devices are now obtaining resources via DT, earlier
> it was obtained from hwmod. Update binding document accrodingly, while
> at it add example.
>=20
> Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>

this looks fine to me:

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Benoit, do you take Documentation patches too ?

> ---
>=20
> v2: node name changed to "usb"
>=20
>  .../devicetree/bindings/usb/am33xx-usb.txt          | 21 +++++++++++++++=
++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Docum=
entation/devicetree/bindings/usb/am33xx-usb.txt
> index a922505..ea840f7 100644
> --- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
> @@ -1,5 +1,7 @@
>  AM33XX MUSB GLUE
>   - compatible : Should be "ti,musb-am33xx"
> + - reg : offset and length of register sets, first usbss, then for musb =
instances
> + - interrupts : usbss, musb instance interrupts in order
>   - ti,hwmods : must be "usb_otg_hs"
>   - multipoint : Should be "1" indicating the musb controller supports
>     multipoint. This is a MUSB configuration-specific setting.
> @@ -12,3 +14,22 @@ AM33XX MUSB GLUE
>     represents PERIPHERAL.
>   - power : Should be "250". This signifies the controller can supply upto
>     500mA when operating in host mode.
> +
> +Example:
> +
> +usb@47400000  {
> +	compatible =3D "ti,musb-am33xx";
> +	reg =3D <0x47400000 0x1000	/* usbss */
> +	       0x47401000 0x800		/* musb instance 0 */
> +	       0x47401800 0x800>;	/* musb instance 1 */
> +	interrupts =3D <17		/* usbss */
> +		      18		/* musb instance 0 */
> +		      19>;		/* musb instance 1 */
> +	multipoint =3D <1>;
> +	num-eps =3D <16>;
> +	ram-bits =3D <12>;
> +	port0-mode =3D <3>;
> +	port1-mode =3D <3>;
> +	power =3D <250>;
> +	ti,hwmods =3D "usb_otg_hs";
> +};
> --=20
> 1.7.12
>=20

--=20
balbi

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmT59AAoJEIaOsuA1yqREVkEP/R4FP39QR4XBy80kqIGrdGOC
xCRBgBWuYG0WMlX0mHMf2kmKODucs/wVTUuBMmmxq6DUyI6zZHTDyRIhwM0n7A0c
vOkkXqgfCxLr8E49S8UoYSoWHcTQbd8e+TNOhudHoln7d+AtJ/GxvkZnaaW/BGM2
jG7wMbphBh28lOYCqrf32S8ntG99xzq/T75YrSJUJnuDTlt+f17sbuYmPYSTx2pL
6+yD5G0eo02N4YVyXXCGeie0QwbQpAANbcJWlrRed/hlj8laqmF0WwMl0Zrh1kTu
2uHUfuwKWzlpuI0mnwiCxEP24OuQvDXliHoyg90CMWTUIKJzPlIAcxIDJclxlvhN
Ze9zRL7unjjJRQq3OR0IC4AtaiBrjhWgrBhuxfFCwbTGFjGO2f8MZueb2eP0NLaL
5qAscsGCvRctAVuFGdxWy2oLIJoaDQKr5ztlh9oVJdt0jbdFACUR1nZt1b3cICZ3
ft8yhKbJ0Ry+RklhGf7JYZO7sp5QF2Lv7KstZm1LCX78+jlJcXkCAwOGIGLnXMF5
CgSDYlapsgexjt+dkSlDorVgC8+9clclDQIle29AeRV5N9c+MCBe7NIG75wA8KWs
AoI4P1yec/JOFDVOWh/0K4I9mZVvfp6NFNRNWSyQOB2Z5K7EoXmCCK6i0uqSRsGN
SQr4HjRHTL5ZQ3RKd/lr
=wPeN
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
