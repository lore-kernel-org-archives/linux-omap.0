From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 00/35] omapdrm: Deconstruct DSS features
Date: Tue, 8 Aug 2017 16:04:57 +0300
Message-ID: <b709531e-5b4e-f0e1-1d59-3772a72476e2@ti.com>
References: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
 <657528a3-fe56-b5d3-8980-f847ccad9a80@ti.com> <15180568.K6fEDfxiXA@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1812669971=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <15180568.K6fEDfxiXA@avalon>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============1812669971==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TMNxTEgxxI5eV3rhmhgpvX7RS4wkKKQ8W"

--TMNxTEgxxI5eV3rhmhgpvX7RS4wkKKQ8W
Content-Type: multipart/mixed; boundary="AbQaBSfRnQFfU4LBWs4dmWSjNDR8hBsiv";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org
Message-ID: <b709531e-5b4e-f0e1-1d59-3772a72476e2@ti.com>
Subject: Re: [PATCH v3 00/35] omapdrm: Deconstruct DSS features
References: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
 <657528a3-fe56-b5d3-8980-f847ccad9a80@ti.com> <15180568.K6fEDfxiXA@avalon>
In-Reply-To: <15180568.K6fEDfxiXA@avalon>

--AbQaBSfRnQFfU4LBWs4dmWSjNDR8hBsiv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08/08/17 16:02, Laurent Pinchart wrote:

>> Patch 9 doesn't compile, it's referring to DSI_MODEL_OMAP4 which is no=
t
>> defined.
>=20
> I might have forgotten to compile-test all patches individually after=20
> reordering them, I'm sorry for that. I'm fixing that now. If you can pu=
sh your=20
> -next branch with patches 2-8 I can rebase on top of that, otherwise I'=
ll keep=20
> the v4.13-rc2 base.

Please keep them based on v4.13-rc for now. There are still some patches
in my current branch of which I'm not 100% sure if I should push them
(the OMAP_BO flags patches, ping on them ;), so I might end up rebasing.

 Tomi


--AbQaBSfRnQFfU4LBWs4dmWSjNDR8hBsiv--

--TMNxTEgxxI5eV3rhmhgpvX7RS4wkKKQ8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZibb5AAoJEPo9qoy8lh71ddoP/3escev5RPS0AiMELl7hZEW7
9XnVuEhpDxGD2ybB2RZE9qdydb5AkBpHq6ma/8UhVOW5eOwIKjuLZCzXBpIFUnPE
7EL4I6dJX6phSMzL0CmxCrO6giMVPfIDlkAHIf3b/GNLFuaRgAhv3wQLQgVpdE6J
j9Rw5jq85ee1gCxIXHHBrZi3Jcar7MwpQCoUQyrLtfmdcTSVlFKXrx5rYK9mTn17
nRp3vmsZHZtwBFQI9umhXXMwhbD+T8f2Q7TbgkCFnUn/5pNu1oBO/MkXI5DKn+bg
5mBNl8V+J9ArwqwbCDGDMHb//thfylopgP/+nTRG+9gKXzlaXMIkRKOMnWXdKI9s
Rs7kUnCWIJxrsDUoQKAMELvw4pUTcoU4BbDHiCFiWuU21lwJuk/dzPRfljyjpwK5
xord4Ut+Pzg7KBYjfdihBFeNipxDl1aD3Mf6kGJd+WaOFBIfjVIWnyOH5mT5/MkE
R7pvEvrVECQJPVGFfD1/pShTZOVDeZdDQuifrYEJOqLl/XxY1WCbAm7deP1WSIE2
q6lEXe9KgWJTaiR6ZtOvJBwQQowWafgjGeIH06Uz/cqXXVhXsQRrn8KieflPQ0Fj
EcI7CRAejnfSbTigr1Xw1yM5uzv1l0OItTraS4o7Hdkyk26DVo0mtONUjfh7pcab
RYW7MtyEoaL4x4eqsxTw
=u0mH
-----END PGP SIGNATURE-----

--TMNxTEgxxI5eV3rhmhgpvX7RS4wkKKQ8W--

--===============1812669971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1812669971==--
