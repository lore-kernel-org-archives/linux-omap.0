From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/23] Nokia N950 display support
Date: Wed, 9 Mar 2016 18:24:10 +0200
Message-ID: <56E04E2A.5070205@ti.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <CACvgo51ys5DQYKLd4qJv6yFj9TKeZM3cfmsY0ECVVvnS+e_-4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0530963621=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CACvgo51ys5DQYKLd4qJv6yFj9TKeZM3cfmsY0ECVVvnS+e_-4g@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Emil Velikov <emil.l.velikov@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0530963621==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GkwLg5xLlPwKPJmp77FL8s46137EP7bi8"

--GkwLg5xLlPwKPJmp77FL8s46137EP7bi8
Content-Type: multipart/mixed; boundary="iX6wakeAF4FKEhIS7TAUPMQgAGTbwoT7J"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Emil Velikov <emil.l.velikov@gmail.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 linux-omap@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Message-ID: <56E04E2A.5070205@ti.com>
Subject: Re: [PATCH 00/23] Nokia N950 display support
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <CACvgo51ys5DQYKLd4qJv6yFj9TKeZM3cfmsY0ECVVvnS+e_-4g@mail.gmail.com>
In-Reply-To: <CACvgo51ys5DQYKLd4qJv6yFj9TKeZM3cfmsY0ECVVvnS+e_-4g@mail.gmail.com>

--iX6wakeAF4FKEhIS7TAUPMQgAGTbwoT7J
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/03/16 18:19, Emil Velikov wrote:
> Hi Sebastian,
>=20
> On 8 March 2016 at 16:39, Sebastian Reichel <sre@kernel.org> wrote:
>=20
>>  arch/arm/boot/dts/omap3-n950-n9.dtsi            |  72 +++++++++
>>  arch/arm/boot/dts/omap3-n950.dts                |  71 +++++++++
> Just a friendly reminder that updating these and one will have to keep
> the driver backwards compatible forever.
>=20
> Tomi, has been in the process of removing all the unneeded cruft,
> although omapdrm it is still using the custom panel, dsi and other
> code as opposed to the ones provided by DRM. As he gets to reusing
> those he might have some fun keeping things compatible.
>=20
> It's up-to Tomi to decide, just thought I point it out.

I haven't looked at this series yet, but all the omap display DT
bindings have been designed to be correct, and while omapdrm will
receive lots of changes, I don't see any need to touch anything in the
DT side.

Of course, if we will be using some existing common driver which
implements bindings in some other way, it'll cause some complexities...

 Tomi


--iX6wakeAF4FKEhIS7TAUPMQgAGTbwoT7J--

--GkwLg5xLlPwKPJmp77FL8s46137EP7bi8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4E4qAAoJEPo9qoy8lh71PKcP/iJFG9N5GHScA87negBBU+yA
36sYMMrkB3hjyUC+NBsVcvPLL4FwOo1z96IyPbXQCXUXLr6E5l1lXUODeG+FWG8Y
pfsAq6dYpaq0Sk00DTyRM9wH19x93ZI+lsotQJ0C18q9Bvs2evbfhyl+XyWkWIkC
lD4B4ZGIfXhihi/Y1ZpYABJ5+cDViqqDkofsyJInyxaArBFDy0NSTZGIjNsfBc7I
7d6Rcwoc3T3J8R35886Uarcof4J6vk+42xefflayOyCC/Q5aouigGN2IcHtTg2Ur
XZpcO6Wf6Dbg36Vjn51p0YznNaJQ3YR3fFtY7M15Vt95l7sayOsBK5BbPHi+uh7v
P5oysdpqrJdwXgNzElFYF5JBuCZQNssEfRU8IcIzMf+ldNMqgXnQnyKV2yayWt82
SPcByje8V4Bakzt4sszZct0QWQwVMUfYVSkd+xvdQmv0Hw30RoY7uqwPUu/QO+1n
xg2fqba+voEdO2ad++VdmUwbXujpp5LfzsJgGZ55RnN029mMMRJVMVQmfb1ESMPY
UqwHEwbhDCaNuETzOVk+YyALMDh1Jp582ELVGk3sZGSD8IXpp9sfDEaK/mGQsKHC
16wrKYpmDEXtlJ5to/6ESkAevY92dM79188aYb4jA/BhKG40tlt1UFGuEh4qhdPc
OM1p2WMUPmh/mt1msa6X
=VDVO
-----END PGP SIGNATURE-----

--GkwLg5xLlPwKPJmp77FL8s46137EP7bi8--

--===============0530963621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0530963621==--
