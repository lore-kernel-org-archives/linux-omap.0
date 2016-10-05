From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2] OMAPDSS: Kconfig: Add HDMI for OMAP4 and OMAP5
 dependencies
Date: Wed, 5 Oct 2016 09:06:15 +0300
Message-ID: <ea03842c-d648-1dca-e7cb-5d672bb8bed3@ti.com>
References: <1475633279-32424-1-git-send-email-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1092633375=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1475633279-32424-1-git-send-email-aford173@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============1092633375==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r66CmpDfuJbhXVTPBBF4N95FpONCfPAxK"

--r66CmpDfuJbhXVTPBBF4N95FpONCfPAxK
Content-Type: multipart/mixed; boundary="735Hjfb363C4sM8uGn6bcRQ38SKFsHNTw";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org
Cc: airlied@linux.ie, airlied@gmail.com, robdclark@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Message-ID: <ea03842c-d648-1dca-e7cb-5d672bb8bed3@ti.com>
Subject: Re: [PATCH V2] OMAPDSS: Kconfig: Add HDMI for OMAP4 and OMAP5
 dependencies
References: <1475633279-32424-1-git-send-email-aford173@gmail.com>
In-Reply-To: <1475633279-32424-1-git-send-email-aford173@gmail.com>

--735Hjfb363C4sM8uGn6bcRQ38SKFsHNTw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/10/16 05:07, Adam Ford wrote:
> Make "HDMI for OMAP4" and "HDMI for OMAP5" depend on ARCH_OMAP4
> and SOC_OMAP5/DRA7XX respectively.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> Changes in v2: Add dependancy for DRA7XX or OMAP5

You don't say it, but I presume this is just to make those kconfig
options disappear automatically if you don't have the specific ARCH_*
enabled?

I don't like these, as they will just clutter the Kconfig file. Here you
only added a few dependencies, but there are a lot more. VENC is only
there for some SoC versions, SDI is there only for some, same for
RFBI... And with every new SoC type we'd need to update all these.

Just disable the HDMI from the Kconfig if you don't want it included.

 Tomi


--735Hjfb363C4sM8uGn6bcRQ38SKFsHNTw--

--r66CmpDfuJbhXVTPBBF4N95FpONCfPAxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX9JhYAAoJEPo9qoy8lh71orcP/jEjnAeEpUzf5B4m7nsR2Y4s
0N+Mu0Qxskqtwukb9yg93N2g15zS8LQC21OZ67L2NPn2wRD5EslVl34qoFbr4cQB
OGxU8yvABitqX2+l9IWG+jaM1W9etHKLxQFNzjzIZWwh9vsf9TkDqyXcuM5HCILP
bnHDebAJRxxoVGCORqC+x9CtVDm8iFguLefnxxgKGEwjhgDhGqXCsMAAlTNCumWy
0jUG6qqvU314+QT353uD5Zn5wcGWxZnxZOJMtxHOOGiyhgnl54saCLa2OKA/O6Fs
V1sO4lVQclzkI+cabzB1RrC0m7DeAYVKcYE+KpphFGQCkYi6HrhhWiac1WZkpjDN
gP/Nh2i5O4TOjcZLQo2CqLSP1BvPdMP2/zmlh7g/GZqOyqnUWMrHKwxXP6JLK3t0
QpyR6N1kgtHg0ixi97roi1ezyijG9VoONtZN+OsGN5YIZxqDFz34nq1Sq05a6p5t
U85b+g6HnpE8uAw2wtsGjNK1x9ZFur0MJ5/zGFdHI4sI2QSGdFdcIxkMERaw30K6
pxW9mcQUwjg9tuVIuiVO7V40XYjyDdyNVBy9TC0FIauL51L89hkNncSs8ZYJoZ0W
8QukJCbQ8I4TODqrTvqD9l61R1cB3b3gIdS5TqbdSu3+1Aeoi4z5iEsNNq5yv6FS
eI4Y49acTe/KZHYYdl8j
=E6L/
-----END PGP SIGNATURE-----

--r66CmpDfuJbhXVTPBBF4N95FpONCfPAxK--

--===============1092633375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1092633375==--
