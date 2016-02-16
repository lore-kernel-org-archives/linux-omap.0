From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/3] devicetree/bindings: add reset-gpios and
 vcc-supply for panel-dpi
Date: Tue, 16 Feb 2016 15:06:33 +0200
Message-ID: <56C31ED9.7070405@ti.com>
References: <1450610002-10531-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1450610002-10531-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20151229205458.GA31241@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OoO5RHFw32qrgCIbrW4iaMWw92d7TRTLb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151229205458.GA31241@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--OoO5RHFw32qrgCIbrW4iaMWw92d7TRTLb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/12/15 22:54, Rob Herring wrote:
> On Sun, Dec 20, 2015 at 12:13:20PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> Some displays have a reset input and/or need a regulator to function
>> properly. Allow to specify them for panel-dpi devices.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/display/panel/panel-dpi.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi=
=2Etxt b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>> index 216c894d4f99..b52ac52757df 100644
>> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.txt
>> @@ -7,6 +7,8 @@ Required properties:
>>  Optional properties:
>>  - label: a symbolic name for the panel
>>  - enable-gpios: panel enable gpio
>> +- reset-gpios: GPIO to control the RESET pin
>=20
> The problem with this in a generic binding is what if the panel has=20
> ordering requirements like enable gpio has to be inactive when reset=20
> is deasserted?
>=20
>> +- vcc-supply: phandle of regulator that will be used to enable power =
to the display
>=20
> What if there are 2 supplies?

Yes, I think it's an impossible task to create a really generic driver
wrt. gpios and supplies. There may be a bunch of them, and a particular
sequence to enable/disable needed, and even particular delays required
in between.

So I think the best we can do is to support (hopefully) most of the
panels by defining one sequence panel-dpi uses. If a particular panel
falls outside that, a separate driver is needed.

 Tomi


--OoO5RHFw32qrgCIbrW4iaMWw92d7TRTLb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwx7ZAAoJEPo9qoy8lh71p/kP/2h+X1M1ph11MrlYMJepjbG2
m2G940at+2EqSOzXm+NgJUCLOb+GYipPpAY8gx0IP17nEFzD8JJkjZ8YH6oT12NF
AyxVGge2270CdRjqBrRCzSk4FEI0rE/GEgSKqFF+KDRevTvGpvYgGLacjeHAWKT9
nleeGjiO3dD0CD2nI+jy5mneasz28dgzYMG7d2FgRl6MOmGfpPPu/M0GmXpN+xg6
LBOSmJ3QTxwwHgrdcj3DmLvCu0frDykl0xH9HDYNeeP2nUglSJkzZksfKqxKVY2K
GCGEWFQGIkmN/dWLb0vRIy+ZpkDiYRGappn58qEobK3fMvXwZvvVLsVJe2oWhp6+
ClvoFIbCA84MmeZC8qfwkJoz4ZRu5Nh5cnvtVPpQlk402VJddt9DU5K1ps212gcc
FhWVfm8Z6qupnvhm+GelASWdngZowl3ZLWfhjWkCj30uPz1Mk/i3e9PNCytCr4WE
BdMefbhUSe4cGBWb60FIHMmKDP26DeOhRrpB4qpmPvhUG25cxKtWo8hwRgui8lDK
1OgR005E1/ETfTCZT+8IoHEGk75XuLKYbZcE9W4f89pV5VXftpjFVRf6Ki0FrgnF
0nAL9gT1lDbyCmIHjuEultLaMqjf74VeVAuStcjPYp8iLVCJygmiTU4qE5PCyyLb
v/9s8/mVYpRXSv/JgMwQ
=BP+Y
-----END PGP SIGNATURE-----

--OoO5RHFw32qrgCIbrW4iaMWw92d7TRTLb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
