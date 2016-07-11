From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v8 3/9] pwm: pwm-tiehrpwm: Update dt binding document to
 use generic node name
Date: Mon, 11 Jul 2016 11:55:52 +0200
Message-ID: <20160711095552.GH5823@ulmo.ba.sec>
References: <1462291015-1919-1-git-send-email-fcooper@ti.com>
 <1462291015-1919-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462291015-1919-4-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: robh+dt@kernel.org, tony@atomide.com, linux@arm.linux.org.uk, paul@pwsan.com, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2016 at 10:56:49AM -0500, Franklin S Cooper Jr wrote:
> Now that the node name has been changed from ehrpwm to pwm the document
> should show this proper usage. Change the unit address in the example
> from 0 to the proper physical address value that should be used. Also
> insure that the unit address matches to the reg property.
>=20
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

I applied this long ago, but never replied: Applied, thanks.

Thierry

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXg20mAAoJEN0jrNd/PrOhIeUP/jn+tXVGKN5TntUnYN35a8/r
thpQZEdWLeKfro6QrXt2PVubKf7DUllHX0p3fLF5K7by13ATq+Ewm2VvLlA0mQEP
EisBUOBbx/yN05avwMk6iuOzxXMBFwVeCJa9tjpIkOiBCQiIMywqq9ptdshpzp5p
Ianv0aq49cwpUXpZNrvTq5Vm0G3AKkg6WFr553kmbUkmJ9cjA6sWZp6JVW2IVnLa
IZgCpZxAwSJgGfiP6cefWWALpMpdsA7xeqCVH+yIe5xVr3St9JUd4j24qcTac8ig
zBPOJ1Vn6pMLfT2J8XhZBpr8hJ7xL8otNakH0AIErDX0KAURgKzjwjw+m1pxuctH
iHEgRtufRWUxmCPeJCcchEBCQvBmwJa4+hXUFVTVA+ab1VGnDcPb7MPB4NzFPaAj
nPtA4AViRewjzjC6/uU61MT8z5p2wES34s2d23AMmrHq6aSRi9frM47vzLaWpUEc
1G5dQn+Kpa0Ck5SEroeF4d6oh0iQZq/glUrDt8k8U4gLJrTbTMr2CsplkXM5VsGg
prElhJyEARWOPKrWgsKA0crIeMd5gdKDNHQoG2aKTWwpf5mLg4TN10oIpgo1imwn
MH+AyUop9jpSJ4glrpJbsqrBNr+kpkNUM0JmmXjMxAFGFoNlB9gMuegcYJTRjLxn
wpKXs9O1Px8dylvmqcp1
=FH2T
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--
