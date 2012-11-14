From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/6] ARM/dts: omap4-panda: Add pinmux configuration for
 HDMI
Date: Wed, 14 Nov 2012 09:39:19 +0200
Message-ID: <50A34AA7.8060700@ti.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com> <1352121259-5836-2-git-send-email-tomi.valkeinen@ti.com> <50A29B12.9030906@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig349E398F91096F90ADED8D02"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36423 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239Ab2KNHj3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 02:39:29 -0500
In-Reply-To: <50A29B12.9030906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, s-guiriec@ti.com

--------------enig349E398F91096F90ADED8D02
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 2012-11-13 21:10, Ricardo Neri wrote:
> Hi Tomi,
>=20
> On 11/05/2012 07:14 AM, Tomi Valkeinen wrote:
>> From: Ricardo Neri <ricardo.neri@ti.com>
>>
>> Add the pinmux configuration for HDMI and TPD12S015A. Configure the
>> gpios for the TPD12S015A and SDA, SCL and CEC for HDMI.
>=20
> Do you plan to upstream the complete DT-boot support for DSS
> (specifically, HDMI) for 3.8? I am asking so that I can upstream the
> audio part.

No. This series will enable DSS with DT boot on panda and sdp boards,
but it's achieved by a hack, as the DSS configuration still comes from
platform data.

To get full DSS DT support we need to pretty much rewrite the dss panel
device handling and adapt to common panel framework (which isn't ready ye=
t).

 Tomi



--------------enig349E398F91096F90ADED8D02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQo0qrAAoJEPo9qoy8lh71CaMP/jeJDI/ltTkByXLjfBzDXfYM
xg91H5j8djOC+nZxOlEt/ej/IcQ6c0zyX0nfq4naPIa+0mkSfDEmg+m16uni+TKp
j64iSdGvnHqNzs1k4CR84TSvjaHJqLbW+8JCI7p+fj7OUowVJoZ9ipPTg/OvL4Uh
T5KhTJaluewwbj7xvK9NyS0hR4JOSeFPVKeNBZx54psZdOoakJjACUtt8zdcKFCZ
AVW7rQquvfZI4afNoxI0M5btRiAyDq1U+fU/YDzPDQmobvOr935D84EHPbegfiNx
VSL0zUIU/ndAsfGJod89IrwGtJ3utto6rsnACzlFUK1JVYFZRQX9irZal5ti4JUA
vEqysjOcj3IdTSDqpLSzwfjQ2azVLsv3YR93xgUCfhvm7DDRKqx07OuUFpoLY6GD
37jnTTvoIjRJd9QZ4QvThtGH54Qzr+kR/ieMvTOtm//ST7Entjf34XF3cJqJVp2g
jAH/cqx3y1iuvvgHSwC9P8mIc7REmolInWEn/Nk3DbQ6Vbv7+3NorBEoa/sFK90P
wWq+yn6ZrxplJtiigu4IvFdJ/S2RfmwDH3pTYZsLy5X/TTJRkNcpgkuRsga3YAs5
iGt42BLqq5nWqWZDkblOX1PfsBNFhjbmI8owCaXvjvyErhtDisG8qMZ6ZeyV6BAm
xUAhr5S1NNyDT1NjuSkp
=7jX2
-----END PGP SIGNATURE-----

--------------enig349E398F91096F90ADED8D02--
