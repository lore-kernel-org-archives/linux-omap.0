From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Mon, 12 May 2014 14:36:02 +0300
Message-ID: <5370B222.7050702@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-2-git-send-email-tony@atomide.com> <536C860E.1000501@ti.com> <20140509143703.GA17814@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="7mhkTaHVSGkqaKBvUtLsjwxEJqh7QfE0i"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51034 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaELLg2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 07:36:28 -0400
In-Reply-To: <20140509143703.GA17814@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--7mhkTaHVSGkqaKBvUtLsjwxEJqh7QfE0i
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/14 17:37, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 00:39]:
>> On 30/04/14 02:52, Tony Lindgren wrote:
>>> Otherwise we can get often errors like the following and the
>>> display won't come on:
>>>
>>> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
>>> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
>>> the output with video overlays disabled
>>>
>>> There are some earlier references to this issue:
>>>
>>> http://www.spinics.net/lists/linux-omap/msg59511.html
>>> http://www.spinics.net/lists/linux-omap/msg59724.html
>>
>> Those don't sound like the same issue, but it's hard to say. What kind=

>> of clock rates do you get? Cat you paste debugfs/omapdss/clk, with and=

>> without this patch?
>=20
> Without this patch:
> # cat /sys/kernel/debug/omapdss/clk=20
> [   24.833831] DSS: dss_runtime_get
> [   24.837554] DSS: dss_runtime_put
> [   24.840972] DISPC: dispc_runtime_get
> [   24.844757] DISPC: dispc_runtime_put
> - DSS -
> DSS_FCK (DSS1_ALWON_FCLK) =3D 57600000
> - DISPC -
> dispc fclk source =3D DSS_FCK (DSS1_ALWON_FCLK)
> fck             57600000       =20
> - LCD -
> LCD clk source =3D DSS_FCK (DSS1_ALWON_FCLK)
> lck             57600000        lck div 1
> pck             19200000        pck div 3
>=20
>=20
> With this patch:
> # cat /sys/kernel/debug/omapdss/clk=20
> [   34.580688] DSS: dss_runtime_get
> [   34.584197] DSS: dss_runtime_put
> [   34.587768] DISPC: dispc_runtime_get
> [   34.591552] DISPC: dispc_runtime_put
> - DSS -
> DSS_FCK (DSS1_ALWON_FCLK) =3D 108000000
> - DISPC -
> dispc fclk source =3D DSS_FCK (DSS1_ALWON_FCLK)
> fck             108000000      =20
> - LCD -
> LCD clk source =3D DSS_FCK (DSS1_ALWON_FCLK)
> lck             108000000       lck div 1
> pck             18000000        pck div 6
> =20
>> What resolution do you have? If it's a very high resolution (say, DVI
>> output to a monitor), it could just be an issue of
>> not-enough-memory-bandwidth.
>=20
> This is just the 3730-evm with the Sharp VGA panel mentioned in
> this series.

Hmm, well, those both look fine. The fck is well below the maximum,
which is somewhere around 170MHz-180MHz. The lck/pck ratio is higher
with this patch, but that should affect the GFX overlay.

So you're just booting, and there are no applications that use the
framebuffer? And there is no rotation or such configured?

 Tomi



--7mhkTaHVSGkqaKBvUtLsjwxEJqh7QfE0i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcLIiAAoJEPo9qoy8lh71al0QAK6MSeVv6KaLxKJDjAOyAQK+
0kCLluWyrNpnaCOP1mru/OcojSlYeVsdsx8dRXcplIuhfJuS1vdF/F0CRIbP6FhD
wnbGy2XuZthH3RkYF28dzcSid4Ov5Gra4wfA3Vkm8R+moYqiKfxvKivbm557JHIp
Vi04/aFC6h2pXz05kbt+UDYwP+B+J5WvvEAh0LDZc2SiN1j9Ab5GG+62kVW+dsOO
COjKM6q5uTKrnF9zMC3j45clf4UIpvc4+6F9m3jbljvSu+x/d2SqNsdiUFcxrE/2
lXRMkjDcyL/rr65Xum9sN8hUG5CbDf287d2t3uzxGU/GVOXSU+avegPLxDhqLWyf
wjL9022Ilef6EIs1zaGP7KyvdPnTcvwkNwqgyB6VVkin+LElimwb1Y1KH4qlxXRH
/SdY1oxbM/HfzYo0q+HRDHGN3x5umf2eKNWW/c9HmrTCtDq94PiyeIJvU1cvqZ17
+2wP3yOkzpIax9wRJCLgowsbW6E4mbxe9ZA965CYIi2UVBm5UTZY+Ni62wDNR++y
ULuLCwYpZzVEFc3onY5R1XQXrGoxUNxQIcsrysZAsyMKvKmnfWusSnmm6rO7Ruth
FjedykbIPd+EcUXRNCdzuNoJBV/HWdN/iU55YE8w6/pVr3RlOq+bLcNO9gPgEigq
BD7T45pX4u2vZAz7CVTZ
=UBWI
-----END PGP SIGNATURE-----

--7mhkTaHVSGkqaKBvUtLsjwxEJqh7QfE0i--
