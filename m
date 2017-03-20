From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 03/10] Revert "drm: omapdrm: Remove manual update
 display support"
Date: Mon, 20 Mar 2017 18:35:49 +0200
Message-ID: <c380d0df-6631-73c0-549a-f6b6f686be05@ti.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-3-sre@kernel.org>
 <e04edb75-d8bd-5380-f91a-ff425bd91404@ti.com>
 <20170320161404.GL20572@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1434552041=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170320161404.GL20572@atomide.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============1434552041==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u2Pe3S78n6k2fTFat2Px2RDAMiS4ShVRP"

--u2Pe3S78n6k2fTFat2Px2RDAMiS4ShVRP
Content-Type: multipart/mixed; boundary="LdWRn9CQanXjgtCWx4AvdIISvi6LJerMv";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <c380d0df-6631-73c0-549a-f6b6f686be05@ti.com>
Subject: Re: [PATCHv2 03/10] Revert "drm: omapdrm: Remove manual update
 display support"
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
 <20170305004309.28259-3-sre@kernel.org>
 <e04edb75-d8bd-5380-f91a-ff425bd91404@ti.com>
 <20170320161404.GL20572@atomide.com>
In-Reply-To: <20170320161404.GL20572@atomide.com>

--LdWRn9CQanXjgtCWx4AvdIISvi6LJerMv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/03/17 18:14, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [170320 04:10]:
>> On 05/03/17 02:43, Sebastian Reichel wrote:
>>> This reverts commit 5a35876e2830511cb8110667fc426c6a6165a593.
>>>
>>> Revert the removal of manual update display support in
>>> preparation for DSI command mode panels.
>>
>> I think it's much better to just add the manual update support from
>> scratch rather than first reverting this old cleanup commit and then
>> adding more bits and pieces.
>=20
> Do you know if the command mode panels support partial refresh?
>=20
> Just wondering if we want to keep "int x, int y, int w, int h"
> around for omap_connector_flush() or whatever it ends up being?

Partial update? Yes they do. But setting everything up for partial
update on the DSS side is horribly complex, and support for that was
removed from DSS driver long ago.

So I think those parameters can be removed.

 Tomi


--LdWRn9CQanXjgtCWx4AvdIISvi6LJerMv--

--u2Pe3S78n6k2fTFat2Px2RDAMiS4ShVRP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY0ATlAAoJEPo9qoy8lh71NzQQALEGxpIcVAez5mXhVQ9E4k1u
gB21ETudlSkzMmRxOEF+pHSfCPv4ngWgHdJyJLD/s3oriDQgNHovkLGDiGOCYVgf
FOJZhblnq1j2G97DESpA78VtWFcgfIQxuhOblq7mMcSBSaa7ev7oKlUYrKQ812Gy
Zc3ocOxQmxVm2vdvPkyboQmlTgyJ9SsAteYymt+L9ysMojb1Zg5TixaWreyQlyfn
UHzFPUzXTXur5avFr9OnKPtyXHE5XNJGkLnGhqZeXHgFEle8Vm7OCVrpLVewXGB+
MgDN7TSZhTqaKpvWsSmP6OEVwxkQLLM8CCQJptnxGddWhoXmS+wl7E+3rKkLGE2y
x5YLrmBIXaWbd8egUCi/e3qyI7IK/2hT8Dyk5P2acqbgVRdcWd3wMbqMUhtOQJjF
g+nElhTNpROE5NTP0DK0VOqcwfA8SHYpRwQ8mXAmogfEOtKncXj8ymGjPYA1S7II
TnWrPaP1r1tbutl6jsgrgMXDW47b59uAxKgKv7FicwEQUiyLFVTlSXhLf4FhQrpO
KC6DYBPKd0ip3ZB/Hy8F5+5DHNS6HxbmGa1+ylyT8m/iV+56iX4QUDNKolSFdMq4
zXoCpG19oGgpCRZ47aFqQye0vjlXeD0HZi6se77UgDogFcic1tgNZTYcEoSii3Gh
0MoNgntEU2UlBbGsd8FT
=V0lK
-----END PGP SIGNATURE-----

--u2Pe3S78n6k2fTFat2Px2RDAMiS4ShVRP--

--===============1434552041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1434552041==--
