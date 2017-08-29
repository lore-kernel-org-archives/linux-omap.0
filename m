From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
Date: Tue, 29 Aug 2017 14:10:41 +0200
Message-ID: <20170829121041.dweciryplio5i4jr@earth>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-15-tony@atomide.com>
 <20170829090034.ytepjfv2jkkd2b3z@earth>
 <201708291135.v7TBZCHH020827@dflxv15.itg.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nly25ubm6cbfj44w"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201708291135.v7TBZCHH020827-mYkuYio3Bc71T2qfsofKZtBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--nly25ubm6cbfj44w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 29, 2017 at 02:35:09PM +0300, Tomi Valkeinen wrote:
> =EF=BB=BFThis message contains a digitally signed email which can be read=
 by opening the attachment.
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/=
Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

> Date: Tue, 29 Aug 2017 14:35:09 +0300
> From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Tony Lindgren
>  <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> CC: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Beno=C3=AEt Cousson <bcousson-rdvid1DuHRDQFizaE/u3fw@public.gmane.org=
m>,
>  devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
>  omap4
>=20
> On 29/08/17 12:00, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Mon, Aug 28, 2017 at 02:19:15PM -0700, Tony Lindgren wrote:
> >> On omap4 we're missing the PowerVR SGX GPU node with it's related
> >> "ti,hwmods" property that the SoC interconnect code needs.
> >>
> >> Note that this will only show up as a bug with "doesn't have
> >> mpu register target base" boot errors when the legacy platform
> >> data is removed.
> >>
> >> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> >> ---
> >=20
> > I think OMAP3 & OMAP5 should also be documented and getting a
> > node in this series?
>=20
> Do we even want to add SGX to the .dts? We don't have proper drivers for
> SGX. If we ever do, who knows what kind of DT data they need. I know the
> DT data for SGX in TI's kernel tree has changed at least once.

I don't think reg or interrupts will be removed, so the properties
added by Tony look pretty safe?. I guess if we ever have a driver
it would need some more properties and would bail out. Having no
DT data is does not load at all, the result is the same. OTOH having
the node means the kernel can properly send the module to idle.

I think this patchset should Cc Rob and Mark.=20

-- Sebastian

--nly25ubm6cbfj44w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlWb4ACgkQ2O7X88g7
+po/qQ/8Du4eBCEmoahu5RI42B6l9uJTmd00ED1C7UcFTeGs7uwGBe+k63DtVu2u
811fA9Qr50By1Y18zcFhqpIXF/gnMCj0jwIJx9SPGiuawIarslcV/yLvPZfXmRXS
GTw9MU06nlffcQ44y2T2OZis5Kp8jF4HvnRl8GIHI0wTyYBN4QHLSa7dJobYpaOZ
UW8ohfMdYjkOBszTA/WfOtZObWqoMB0FrocwCrRYYfi8PrB+fAV7Q2MaUhjnDCv1
xOkLPer6z+lDvcvys0C/eIGbkEXRXEb1VCz3Ud5uKhLijqcGcl5tkmsekh3SwrpS
XE5zd6phzMEQmGNZjlPzb8R8kRb9I6oPqshBQg1faT7XjXD61+wqDYN7vaKf7qzJ
5WiZL6l+r4EmhFs282JcMGWHBpeQU4b6/K945cArKdD1UY0+YeRu+HdZWIbENa2l
T00xoie0vblRVtj5f9UiAEFl/e2eK7ncDVNu36+jWNp1fZuXGzGUnziCurKU1v2w
ZN3Bv4Gw6fqUkSvLXAvKgt+GTsMokFCqXBm1nxGJugzL2Llvlu/Gw6X0A+wrcmgW
A4I47HU2pNnRkc6BoclkxaPUoBm9w77p0JF1/d1q6u1YAo+7bSnTKQb6Ow5q7mpm
8W9SW6JIaOEYmgIAfdJy+kw7eoNcdaPXj8yWQJ8fmPLHmcUdY80=
=I1Dx
-----END PGP SIGNATURE-----

--nly25ubm6cbfj44w--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
