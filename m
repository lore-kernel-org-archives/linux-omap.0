From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 00/35] omapdrm: Deconstruct DSS features
Date: Tue, 8 Aug 2017 15:56:10 +0300
Message-ID: <657528a3-fe56-b5d3-8980-f847ccad9a80@ti.com>
References: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0882860951=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0882860951==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MwgV9FQnN0c9xlpRpPPdDBqXOvM4wjS6c"

--MwgV9FQnN0c9xlpRpPPdDBqXOvM4wjS6c
Content-Type: multipart/mixed; boundary="j1cpSSQ88tb5svrWJDCE83oTKavJXMABS";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Message-ID: <657528a3-fe56-b5d3-8980-f847ccad9a80@ti.com>
Subject: Re: [PATCH v3 00/35] omapdrm: Deconstruct DSS features
References: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20170804224419.30758-1-laurent.pinchart@ideasonboard.com>

--j1cpSSQ88tb5svrWJDCE83oTKavJXMABS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

On 05/08/17 01:43, Laurent Pinchart wrote:
> Hello,
>=20
> This patch series is a third version of the code previously posted as
> "[PATCH v2 00/29] Remove the omapdrm and omapdss devices from platform =
code".
>=20
> The omapdss/omapdrm initialization code is quite a mess. The physical d=
evices
> are instantiated from DT, but two virtual devices named omapdrm and oma=
pdss
> are instanciated from platform code to pass various pieces of platform =
data to
> the drivers.
>=20
> The omapdrm and omapdss platform devices are currently used to pass dat=
a and
> function pointers from board code to the drivers for the purpose of
>=20
> - identifying the OMAP SoC revision
> - controlling the DSI pads
> - configuring bus throughput
>=20
> It turns out that all these can be handled in the omapdrm and omapdss d=
rivers
> without the need for platform data.
>=20
> - The SoC revision is used to identify the version of various DSS IP co=
res,
> which can instead be done through compatible string matching (with the =
help of
> soc_device_match() in two cases where ES version is needed).
>=20
> - The DSI pads control can be performed by the driver directly without =
calling
> board code, accessing the related registers through syscon.
>=20
> - Bus throughput control is implemented in mach-omap2 as a no-op, so we=
 can
> just drop the code.
>=20
> This patch series starts with a new patch that fixes soc_device_match()=
 usage
> on OMAP2+. It turned out that OMAP2+ registers SoC device attributes at=
 late
> init time, making soc_device_match() impossible to use for drivers at p=
robe
> time, which is unfortunately the location where the feature is most nee=
ded.
>=20
> The next five patches (02/35 to 06/35) are small and simple unneeded or=
 unused
> code removal. The next two patches (07/35 and 08/35) are cleanups that =
make
> sense by themselves and will be needed by later refactoring.

I've picked patches 2-8 (inclusive). I think those can be applied
already, even if the rest of the series would need more work.

Patch 9 doesn't compile, it's referring to DSI_MODEL_OMAP4 which is not
defined.

 Tomi


--j1cpSSQ88tb5svrWJDCE83oTKavJXMABS--

--MwgV9FQnN0c9xlpRpPPdDBqXOvM4wjS6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZibTqAAoJEPo9qoy8lh71vysP/jEZEp+n2qGxNCZguO6F437m
pL03wzd7MuYVLBCttdckc69pVolMzwyi+yQy0lmr3UVFH5etL+/KnK1jsdmjyTpb
kTdWw9MlZAjVsFHfbA1Z+yM0bMUjVIC+Dp9OrUraSEn/43TBL+v74VaN+vzE6Trr
G7tBFcdlrtHR9ym2x/9btgvC3ut0FW3m9UTxivMj6nCxbEUybl5bN6bivSyImy+J
v4XJnagR8rUbRU+9rd8pXQnowKyjmfxef8DH5EVHD9eGTSo8XITKakSnQ4gzRwzP
xZRte7Kze4tU4jb0C3gO13wOQjqqUFwRtoXda2j3ay6ojjWqP53WJjEvJdMz2D/q
6mPNuFCz+b/70RIq27outD6XpChOdEEHorlhk2uv8hdjA5GshxmEh5Y5lDlJLTDi
OksN7ltG3bZcttz2MiFREMfatuDO3kHiZazZRro+bAaObCzojGphepr1CYe/L3En
qLwOWw46OdF/OjKxHQqNH3SvEs1iBxp4SwuluBlR/+2H6fOmc4ZLbqKs7Zvf+1PW
bI2AsNtLDAPuUqta0ywGtxzoXlH3sgeC2A2tNrgjrlk6s3A3Uq4s+KHnCD6rK5uz
PAVVwpWGmgJ4KkLaXzkcLkt9anru1NuOB79Zkim9rU5KU5jLPWTsDZxf5qng10OF
dL/jXeKSX5koxWGduvee
=YBPj
-----END PGP SIGNATURE-----

--MwgV9FQnN0c9xlpRpPPdDBqXOvM4wjS6c--

--===============0882860951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0882860951==--
