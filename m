From: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 07/10] usb: dwc3: gadget: Fix suspend/resume during dual-role mode
Date: Mon, 11 Apr 2016 16:26:59 +0300
Message-ID: <87oa9gmg2k.fsf@intel.com>
References: <1460374506-9779-1-git-send-email-rogerq@ti.com> <1460374506-9779-8-git-send-email-rogerq@ti.com> <878u0knxkp.fsf@intel.com> <570BA2AA.8030308@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570BA2AA.8030308-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
> On 11/04/16 15:23, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>> Gadget controller might not be always active during suspend/
>>> resume when we are operating in dual-role/otg mode.
>>> Check if we're active and only if we are then perform
>>> necessary actions during suspend/resume.
>>=20
>> I don't get this. If we're operating in OTG, we should have a gadget
>> driver loaded, no ?
>>=20
> At boot gadget driver is not automatically loaded. We're still in OTG mode
> but OTG state machine hasn't started.
> System suspend/resume can still happen.
>
> User might also load/unload the gadget driver prior to system suspend.

good point, this should go in the -rc too.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXC6YkAAoJEIaOsuA1yqRE+ukP/ArouNlwFO12BoBrjvPMbx9r
OoZV7vJDJIiH/QchMPKUI8zCBWc10fxKtDBDUreZwyguB1hyVr5cYYIS1Y0VMMjZ
QOkc2tgu6Bu+2mbKqs9PtA123L/BIOteC9lU+kT3VEIboBQ8iCrW/BW/A6z6PENP
Cm93WWoVR3RFpADXBDJ3LDeHZbVUUyapvGtqkieF2VydcVRG8iv0aP+bi8vJX3v5
nSgE9C7tDL3/ShSc4VxT9jtCahvczqMWRX6Yr/wcEN3f2065jzOhZ/5E46DEHfkn
JoAcApE7oGSYGSTF+j87VQw3n4dLuEkCP1IPrsnd0PhdRhrgUKDZJ2zPDNwkwdSL
ScTvWKNUL10MRjQDJVQS426nKUj/3cmihDgcLSV+N3iMy/xEqrJ0UeSkPnZbRjff
iCcB351dkGu0P9ByCkHq/ndmkm92jw42lI9vQbikxWCBKyUh+fWLaFNjwAdpD0E5
LsbypDEy0v094n7BrbA1CYykFqxyIoYS2VLtKWPV1vqWg92SZQFXaZKJf3LN8QcW
N+eGl83czO+xxCUB17B2iWyueTWpLnQRga1JWu2EKAk8cktSnR1NDEd8wld5XQrB
hYGlMAUF0G/jhr9/FjLkSIqbOWSWPpD4vZORLW8hwFEPObHQ5UfIIBupDtjYm99+
9RUJMpBnMXFPaDwf+TYK
=jVLi
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
