From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/4] MFD: Palmas: Check if irq is valid
Date: Wed, 19 Jun 2013 17:42:54 +0100
Message-ID: <20130619164254.GA1403@sirena.org.uk>
References: <1371621470-22279-1-git-send-email-j-keerthy@ti.com>
 <1371621470-22279-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1720750621138147118=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371621470-22279-2-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
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
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--===============1720750621138147118==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f1Ot4QhJn5dlG2/n"
Content-Disposition: inline


--f1Ot4QhJn5dlG2/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2013 at 11:27:47AM +0530, Keerthy wrote:
> From: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
>=20
> Check if irq value obtained is valid. If it is not valid
> then skip the irq request step and go ahead with the probe.
>=20
> Signed-off-by: J Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

Reviewed-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

--f1Ot4QhJn5dlG2/n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRwd+LAAoJELSic+t+oim9Po0P/ApRELd4efvrDfhsfTBaE1/K
HXDV4j01sG+AQ6jPYnsODw5gJkGGEh9Z6/oKUPK4+VBHwg/aOalCwTMAgJ4JQ95D
ixOZCql8s+Rxf7XbB7a4/HLvJjtflUySnxTGVozS/newrbD991n0RcyjwL+97yEp
xWCgn6D+bYOXLnpVN2Pb4TnwgqHLVJ4QMYD525o4j1RqkRSL1nLSb/JWAQWtsQZp
P7R1WRgkn0eEVf7XHPP/GECCuUMypCtw688TDH/rs4rBIixGJ/wiHlPtxSN0e9yt
+e09y5lo25Xf3v5pW796XDzyWS28kcCUqV+ipDWle81xVd3FooIhnouEKO3l8QbQ
JDVq1NCGFbWOUfoXnixSYQjrEA+/modH6RTGUUjJLMhi+ooXCN6pRD3DXPSIb9Xr
WHQZsEUkuPbdKm8xvTpSb4ICVlGtgXgmTLD/TKyl2CJgD2lPc7afwj8UVdjcltYx
yjw2YNJAFm6aJn5/KyB89CAoZSm9v4fxao4jFpD12O2SSU045omuFnJZ1DqgTXBg
jMIyeAa+X+jQSV53mqdL508idcXJwELjoNQeVGaAkXJ9iAc38D5eL2Ef4zjre33T
uSH9unmilfYAEvj3nPWZ3hBwzGTc/dJyWamM8C41hmo18aauyv05yQ3xmBqIzDme
uwVzUmodTsqD5jEaiVqm
=8YBj
-----END PGP SIGNATURE-----

--f1Ot4QhJn5dlG2/n--

--===============1720750621138147118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1720750621138147118==--
