From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Tue, 9 May 2017 17:05:50 +0200
Message-ID: <20170509150550.bi4bzadesmma6ntp@earth>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1281286959=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============1281286959==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="urc7j5satectib2h"
Content-Disposition: inline


--urc7j5satectib2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 09, 2017 at 03:10:40PM +0300, Tomi Valkeinen wrote:
> On 08/05/17 14:32, Laurent Pinchart wrote:
> > Hello,
> >=20
> > This patch series is a second, extended version of the code previously =
posted
> > as "[PATCH/RFC 0/7] Remove the omapdrm device from platform code".
>=20
> As this is a long series, I'd like to pick a bunch of patches from this
> series already:
>=20
> 1-5, 7, 19, 21.

I can't reply directly, since I was not subscribed to dri-devel when
this was sent, but I also noticed, the incorrect pattern in patch 1:

foo =3D devm_ioremap_resource(...)
if (!foo)
    return -ENOMEM;

The same pattern is in patch 2, so you may want a PATCHv2 of that
one first. Also I have a few more notes:

patch 10:
I think dsi pin muxing should be done by providing pinmux
info via DT.

patch 11:
There is a typo in the comment "can be told apart" =3D> "can't be told
apart".

patch 21:
As far as I can see dss.h contains an empty #if
defined(CONFIG_OMAP2_DSS_DEBUGFS) after the patch.

> I didn't test yet, but I think those should not cause conflicts with the
> rest of the series.
>=20
> I can then push the branch, which contains also the fences and cache
> patches, so you can base the rest on that.
>=20
> Is this ok?

-- Sebastian

--urc7j5satectib2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkR2swACgkQ2O7X88g7
+pqiHg/+KixkxdpG3v3neFUMtqR9Hd7vUiKOfHqf+Lw5Ksj53cnTzxnfUWbJkW9J
LzvJYpEvHuov2H9SeukTm8d3TCr9hdnfobBXwYWbNcbWLPsXvWgewq9Cb77HhZDq
91Kro8u2nQXEkvpThZYCXSOAfUWCR+H4p31jtvQWNysVpqwpI6jKANVoxUbANpjE
LpksfFlQ3uh96mepZSkoM6ZHc0nf0Ej3/WBr9q+j+cmEIR1RdesMw4DMbGUhXxu8
UCqK04vCKh+BNnktDou7Y3vcLVsKy8viSb9c5uCB6CWVY5NUTxfWSDeeLzXv8hUY
LrUwabrlxZvbJl5qH8BuekV2ivbuuiOc7wW4oXeNPJAj629Qu7DQPSuUFzfvZGlL
JAFShIttDTyKbm5+W7vp2BXPR+p6rtZdQrVZFxOtfLJhfaUVUaoFmFGOO+dd5s0d
TbdxVQbKX9ubFNfLUTvmNSITNWCyZ2DUGGB0rgg/Gvt7HlkfEP+7rzI7g5nAOK7b
uPEM3bYFHk7s4/RprXxicg6F9B9cuFTX1gWMvhLrSbhaMxGkqohGeXGdLuOrOwsV
Is8bEExS8i6mh4Qt/igJIiJX1VTrWR8zhQQpQUS2AiEFFosEvqs43zHPetiHXkk8
s2sdf6j23W28laYphHpSDBZNxBTlwbxyWECXBa0zPnvNBkYnSXE=
=Pm5t
-----END PGP SIGNATURE-----

--urc7j5satectib2h--

--===============1281286959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1281286959==--
