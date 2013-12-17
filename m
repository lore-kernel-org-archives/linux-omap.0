From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 23/27] OMAPDSS: connector-dvi: Add DT support
Date: Tue, 17 Dec 2013 09:15:58 +0200
Message-ID: <52AFFA2E.5050702@ti.com>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com> <1387205794-32246-24-git-send-email-tomi.valkeinen@ti.com> <20131217070551.GR24559@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lW3wgRHlRMkO10gftT3DQJHiPLJFmWxpc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39720 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991Ab3LQHQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 02:16:09 -0500
In-Reply-To: <20131217070551.GR24559@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>

--lW3wgRHlRMkO10gftT3DQJHiPLJFmWxpc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-17 09:05, Sascha Hauer wrote:
> Hi Tomi,
>=20
> On Mon, Dec 16, 2013 at 04:56:30PM +0200, Tomi Valkeinen wrote:
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  drivers/video/omap2/displays-new/connector-dvi.c | 43 +++++++++++++++=
+++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/drivers/video/omap2/displays-new/connector-dvi.c b/driver=
s/video/omap2/displays-new/connector-dvi.c
>> index b6c50904038e..d1204b1c5182 100644
>> =20
>> +static const struct of_device_id dvic_of_match[] =3D {
>> +	{ .compatible =3D "dvi-connector", },
>=20
> Either the driver is too specific or the binding is too generic, but
> having such a generic name for an omap specific driver seems wrong. Sam=
e
> for panel-dpi, svideo-connector, composite-video-connector and hdmi-con=
nector,

Hmm. Good point. I was thinking that the driver is only used on OMAP,
but of course that's not true, the driver is there for all platforms if
the kernel just happens to be compiled with the driver.

And it's not just about those drivers you mention. The same issue is
there for, say, "ti,tpd12s015". I have an omapdss specific driver for
that, but if some other platform uses the same chip, they'll have a
driver for it also...

Sigh. I wonder how this should be handled... The only solution that
comes to my mind is to have all the compatible strings as "ti,...". But
that's not correct, as they are not TI components, but some are generic
ones and some from another vendor.

And even "ti,..." is not good, as there are other TI SoCs with other
display drivers. So I'd need to prepend the compatible strings with
"omapdss,...", making the hardware components driver specific.

The long term plan is to make the drivers generic (or implement the same
driver for common display framework). But for now I need to have future
proof DT bindings with omapdss specific drivers...

 Tomi



--lW3wgRHlRMkO10gftT3DQJHiPLJFmWxpc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSr/ouAAoJEPo9qoy8lh71SLcP/0OmWBMfSKS4vR/Pl2lZ5oxE
r2eUbTXhXPqhTwO/2BMsTBmgUMiKq+3FbLJaFZQe1RS0YJqg5WpDiM55dbIou3RF
5BxjeOpxBZaarvxf/0+DdX6p7VgYeXLnTrEs8RuWuDbdfw0RhMN1PreZAD0VBV6P
OUXZp8FuCUtb9klerAwM1ZLP3ZnRwQo6XZZ2oxc7dl4Jk1tIXK/mhytoIEdxK6vw
oGHVPMwmqYvq0DrsFiY3vACfuVlqlXtnovZ9jlRfxLtvL6MzhDboB+donfxVMCGv
dPeMdRy5sctVn/4jIvVRmPX/AkN91v4FkC8VlL2iIH5NTQf0mTHkidG0lra+83G9
m7BUBuLdyVWBfk3P5td9iAGTt5VhFdQSBSpruO8AyJn/TJXZ62DRGcp/TRkjTUt3
OnFfB+lmfkSCPs0ryIeK2nkW+1CExDqhOCqMlR17l7siJNKiVKt0kGIfxQNf/5aJ
gH1eWKCCi8ZxENG+6/b4E+jA890WZFIXGw6c0uVhWBz7U3c4dyUxOC51/RyasHjy
2dszmO5R7T05hovK0dYXlKgMFuxtDFZaNMrStnG5eSSufylRwO6lyVr7OKHRHTGA
nIozMjD/M0cOJ6sd7XrEXVZBQdNHjOEUdTOgARhFrsV5nvwyPk872SJhHIFtIhkz
vOKuZeWs5Pq0HmCmQTce
=mu6r
-----END PGP SIGNATURE-----

--lW3wgRHlRMkO10gftT3DQJHiPLJFmWxpc--
