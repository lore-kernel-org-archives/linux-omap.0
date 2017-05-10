From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
Date: Wed, 10 May 2017 09:48:02 +0300
Message-ID: <4cbcc8a9-ea2e-f442-1e91-138e18ed9620@ti.com>
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com> <1872968.7fdiNycxOH@avalon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0163308086=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1872968.7fdiNycxOH@avalon>
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0163308086==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DCsnrm4cUkEpGOU5UdxVcwiHd3IUbr38V"

--DCsnrm4cUkEpGOU5UdxVcwiHd3IUbr38V
Content-Type: multipart/mixed; boundary="jEUMxfeLMUkk6kOSXkFq78O34X7ChSCKd";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org
Message-ID: <4cbcc8a9-ea2e-f442-1e91-138e18ed9620@ti.com>
Subject: Re: [PATCH v2 00/29] Remove the omapdrm and omapdss devices from
 platform code
References: <20170508113303.27521-1-laurent.pinchart@ideasonboard.com>
 <f7d62ed5-f903-4356-8460-c7b0cf151cf3@ti.com> <1872968.7fdiNycxOH@avalon>
In-Reply-To: <1872968.7fdiNycxOH@avalon>

--jEUMxfeLMUkk6kOSXkFq78O34X7ChSCKd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/05/17 01:18, Laurent Pinchart wrote:
> Hi Tomi,
>=20
> On Tuesday 09 May 2017 15:10:40 Tomi Valkeinen wrote:
>> On 08/05/17 14:32, Laurent Pinchart wrote:
>>> Hello,
>>>
>>> This patch series is a second, extended version of the code previousl=
y
>>> posted as "[PATCH/RFC 0/7] Remove the omapdrm device from platform co=
de".
>> As this is a long series, I'd like to pick a bunch of patches from thi=
s
>> series already:
>>
>> 1-5, 7, 19, 21.
>>
>> I didn't test yet, but I think those should not cause conflicts with t=
he
>> rest of the series.
>>
>> I can then push the branch, which contains also the fences and cache
>> patches, so you can base the rest on that.
>>
>> Is this ok?
>=20
> Patch 21 will conflict, the other ones shouldn't. For your convenience =
I've=20
> picked all the Reviewed-by tags, fixed a typo in patch 01/28 that broke=
=20
> compilation, rebased the patches with 1-5, 7 and 19 moved to the beginn=
ing of=20
> the series, tested the result and pushed it to
>=20
> 	git://linuxtv.org/pinchartl/media.git omapdrm/platform
>=20
> You can just pick the 7 first patches from there.

Thanks, I picked those. A few minor conflicts with my branch, but I
fixed them.

 Tomi


--jEUMxfeLMUkk6kOSXkFq78O34X7ChSCKd--

--DCsnrm4cUkEpGOU5UdxVcwiHd3IUbr38V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEreiAAoJEPo9qoy8lh71vIQP/3vYr8i63ZoTnXfelUFs17w+
3zpWuwJBh1rRjQHo8A7AS44NCS+Skl9bDqwwq9i5kUl9SiL5bHmWS6bUDMbBDMVO
lM+3o5YBBGsCA44Uy6rPlmU5LikCp8K48cBRj0kFd4d/q+iUfi7tTYiXgVemWbdx
+qHLUIan6TekRTZJlwUTUBcvLZMnwjhFpe/88XCRkzUesVPvtpXuQeBb+ZxCBIEN
tSTGNrhnhIzqgDRVDjjNlEPIy/loHJ4Q1y726pj121/Pa1SY3JVxxeABSiTNkp1O
mxzl2EVto48iOf9yKmkHxytQYm0GD4AdNcTp8R+lHV7d4BogupFP1Sc+giAA9ytS
uan5yyUT5bmFKbis0jCfhKRYr6HXEv0aMK+AdWaZX+/CIWr+hBPVKCbPvh4PBXcN
JZnEZuo2sSxHq90teWd+ps6+GiBw65eayI2Rn1rcerx7Dbc+OxsCLwwfRkGlSYh6
DmI4bzQvN8fmwaQDYXb1sEG2zYv/ZRqxAvalOAwqL9ByxCEpt+vIiqrolabMyVqj
EQpkEmEodgKfDxdH6aUj/0aGS5Sn35TyZzibOWrBAXfk1KoHqgW69Kwsm6kHmlFK
Z0fdYO4J5mrMr7/F7s2X4JfSqKChicz+fm7tDKxazHzhv6nzqOjBtVlp56p1ZvHh
R6jEXCqic6QfQhROgnO+
=rud5
-----END PGP SIGNATURE-----

--DCsnrm4cUkEpGOU5UdxVcwiHd3IUbr38V--

--===============0163308086==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0163308086==--
