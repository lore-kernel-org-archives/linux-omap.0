From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/8] usb: phy: nop: Add some parameters to platform data
Date: Wed, 13 Mar 2013 16:52:32 +0100
Message-ID: <5140A0C0.2020400@pengutronix.de>
References: <1363087466-32444-1-git-send-email-rogerq@ti.com>
 <1363087466-32444-2-git-send-email-rogerq@ti.com>
 <513F177D.40500@pengutronix.de> <513F37DD.9030301@ti.com>
 <513F38DF.5040404@pengutronix.de> <513F3B7E.8000002@ti.com>
 <513F3EF0.3030609@pengutronix.de> <513F47B4.2060004@ti.com>
 <514098A0.1030809@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6336901608780416815=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <514098A0.1030809-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============6336901608780416815==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2VSQWLJGFVQMMDJBGABCI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VSQWLJGFVQMMDJBGABCI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 03/13/2013 04:17 PM, Peter Ujfalusi wrote:
> On 03/12/2013 04:20 PM, Roger Quadros wrote:
>> Adding Peter to the loop. I faintly remember him mentioning this issue=
 before
>> for beagle. We really need the deferred probe mechanism or we need to =
resort
>> to device registering order.
>=20
> Yes, BeagleBoard is a good example. Long story short: we have external
> dependency and the correct way to handle that is via deferred probe.

Sure.

> As of now we are not ready to kill the legacy support but over time we =
should
> move as much as we can to DT only mode.

I was assuming you're already on DT only :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2VSQWLJGFVQMMDJBGABCI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlFAoMMACgkQjTAFq1RaXHOvSgCfe/FyruXVcXy6bI4rU8nm5y/a
TQIAnRWAEC32Ki0ut/3sQ3O86ZidUWch
=GVDF
-----END PGP SIGNATURE-----

------enig2VSQWLJGFVQMMDJBGABCI--

--===============6336901608780416815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6336901608780416815==--
