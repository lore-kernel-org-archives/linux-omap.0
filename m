From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Tue, 9 May 2017 15:10:40 +0300
Message-ID: <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0301345606=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0301345606==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="X2BhMTolOdDpT3Ck6EJ9Lf9DNiTs0roGo"

--X2BhMTolOdDpT3Ck6EJ9Lf9DNiTs0roGo
Content-Type: multipart/mixed; boundary="Dn9JqsADfVfxjca7iFu44gDvkjsFMC8tf";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org
Message-ID: <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>

--Dn9JqsADfVfxjca7iFu44gDvkjsFMC8tf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/05/17 14:32, Laurent Pinchart wrote:
> Hello,
>=20
> This patch series is a second, extended version of the code previously =
posted
> as "[PATCH/RFC 0/7] Remove the omapdrm device from platform code".

As this is a long series, I'd like to pick a bunch of patches from this
series already:

1-5, 7, 19, 21.

I didn't test yet, but I think those should not cause conflicts with the
rest of the series.

I can then push the branch, which contains also the fences and cache
patches, so you can base the rest on that.

Is this ok?

 Tomi


--Dn9JqsADfVfxjca7iFu44gDvkjsFMC8tf--

--X2BhMTolOdDpT3Ck6EJ9Lf9DNiTs0roGo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEbHAAAoJEPo9qoy8lh71WYIP/RuUr6V4+ESpyNrgfwoNPCKS
EZn0Jd/wSDVgGVgOOl7FNyhmiswlH/r/Nq0aJ6UeRURr8IhrxnAeeNbMQGQfL8tb
CZEg9xaEysB6FTlGnxEfa3QTjl5tZ4QNicYgwO38U8prWVOyMxuTw4UfNvRfpGBb
O+9zVA1txewHrfMm2nXTuzI1ss4mPXMIUErlCiwuC20e0GD3tch30HoyjSAZVkx+
QA640a+BH8iyob31aLawofg6utNsdyVfJRV4U4fJzJp3hE18Js1mNUF5GqUBnMg2
GdWbdJV4Tjvo6Voo2EFOr1fbMvlxsMjh1ghJ9kCJGni4HvW16g4IyOoc27ZO4x56
XKywynzqmYonfHielaDjEvFn0KhBfHgMi/8JWGmjXmb4HnUQr4vKX6xzXfFyjjHl
X3AbRM3w8LBeV9fdwhlaCibu692d7TKe2STOm2SKSw7EDVGIn8s60/Wy35icyiWU
MXUgjpRS+ob2L3MY22aa/fBXx4vivDdQgQUuY2dKHVN53912p6vW25NQxb6UYnyO
HzAWd1858qF6Sc838mUeYTpF93/cHHOVZ58U1kOiGNxSMW3x5dGyeeU90RVe+Oel
S9qYxT+1jg394Pey8ns5HHgDiihWtI/DCNe8YN3/7exXu11j2ITCwPSlK7482XOY
aitzIAeNmcdY2yYPBdqH
=gERI
-----END PGP SIGNATURE-----

--X2BhMTolOdDpT3Ck6EJ9Lf9DNiTs0roGo--

--===============0301345606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0301345606==--
