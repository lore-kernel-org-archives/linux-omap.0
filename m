From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v8 08/13] arm/dts: am33xx: Add dt data for usbss
Date: Fri, 31 Aug 2012 12:54:43 +0300
Message-ID: <20120831095441.GC8270@arwen.pp.htv.fi>
References: <1346323825-24385-1-git-send-email-ravibabu@ti.com>
 <1346323825-24385-9-git-send-email-ravibabu@ti.com>
 <503F50FC.5040200@mvista.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <503F50FC.5040200-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 30, 2012 at 03:39:40PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 30-08-2012 14:50, Ravi Babu wrote:
>=20
> >From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>=20
> >Added device tree data for usbss on am33xx. There are two musb controlle=
rs
> >on am33xx platform so have port0_mode and port1_mode additional data.
>=20
> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
> >Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> >---
> >  arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
>=20
> >diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dt=
si
> >index 59509c4..778b95e 100644
> >--- a/arch/arm/boot/dts/am33xx.dtsi
> >+++ b/arch/arm/boot/dts/am33xx.dtsi
> >@@ -154,5 +154,16 @@
> >  			#size-cells =3D <0>;
> >  			ti,hwmods =3D "i2c3";
> >  		};
> >+
> >+		usb_otg_hs: usb_otg_hs {
> >+			compatible =3D "ti,musb-am33xx";
> >+			ti,hwmods =3D "usb_otg_hs";
> >+			multipoint =3D <1>;
> >+			num_eps =3D <16>;
> >+			ram_bits =3D <12>;
> >+			port0_mode =3D <3>;
> >+			port1_mode =3D <3>;
>=20
>    Hyphen is preferred traditionally to underscore in the device tree fil=
es...

Are we having a v2 of this patch ??

--=20
balbi

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQQInhAAoJEIaOsuA1yqREo9IQAKWRD8Vj2x99wRs9L7qa4gur
vP89SMOjIcUCByjXGdPsWlcr36vN/DusE8Dmderci/B/t7F8OMR08/KLlQm4aX+J
i0EPwncxMOsfPxDpbkhgglKQCRROzOk71MWg1RzpP4gdFys9xlXIjRaQZ10IJiRv
Ze39yzDXvJi+CuxjNG/1fWK3r/0pFk6GmVsC6zjvYdMWMStqA6X791hza1kGQIkO
vcPu3M9LDCTOYkFoaZeUPHoubWCRX7PhYEFlAqzHkZf6cKvcyskC53WzCuSZgLWN
+kXriQVMw5vz1hU8NfA+nYqvwh7jNSDFz/HqpO8iwR9Fuu9CW5xtLicwa65j4JAL
+TSh+dd+FCxVx+Sr/edsEZrF54A9Mo4JJA+hQi8Zv14gRTOTtJPLdAi6qKpbBOn6
FHl23ELjwkB90KTE1C/781dS59XPmRMe7i3UtNXX1s3hZtIX42+Q4mx16dihHZVZ
7y/CUPTfkQrMcSZ5US4x/FC1Mn9JWm9RDViF76YDpVPogImp+XSo3ZL+9ieMCnY2
mWNEbUA6/axHUhEUJxM/nseNREpDR463GuM97BkI1D4BW8q9yvQj7fCXDFdCvqVt
g6jHOtotBbsTscvNS7PVZQIllaytikINGvEk2t56aWr74MgKJxtnrs5pFJ0u3Z1T
WHAkA/DIyZAkzJyEdm58
=wUN+
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
