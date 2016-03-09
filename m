From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/23] Nokia N950 display support
Date: Wed, 9 Mar 2016 09:10:28 +0200
Message-ID: <56DFCC64.7010405@ti.com>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <20160308183908.GA31741@raspberrypi.musicnaut.iki.fi>
 <20160308204510.GA31069@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1002764228=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160308204510.GA31069@earth>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============1002764228==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kMJ3EUmKvL9aKisljPbJ47Tfg3VjhqDJu"

--kMJ3EUmKvL9aKisljPbJ47Tfg3VjhqDJu
Content-Type: multipart/mixed; boundary="Ko2AG3FsFejW8Lhucq0O2haVVGRGHgLk7"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <56DFCC64.7010405@ti.com>
Subject: Re: [PATCH 00/23] Nokia N950 display support
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
 <20160308183908.GA31741@raspberrypi.musicnaut.iki.fi>
 <20160308204510.GA31069@earth>
In-Reply-To: <20160308204510.GA31069@earth>

--Ko2AG3FsFejW8Lhucq0O2haVVGRGHgLk7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/16 22:45, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Mar 08, 2016 at 08:39:08PM +0200, Aaro Koskinen wrote:
>> On Tue, Mar 08, 2016 at 05:39:32PM +0100, Sebastian Reichel wrote:
>>> This series adds support for the Nokia N950 display.
>>> Since the panel is using DSI command mode, it involves
>>> adding support for manually updated displays to
>>> omapdrm.
>>
>> Works OK, but the picture seems to be upside down?
>=20
> vertical, upside down is the native panel orientation.
>=20
>> Also shouldn't the default orientation be landscape?
>=20
> The N950 vendor kernel contains some code adding DSI
> rotation support with half-frame update mechnism to
> avoid tearing. It's quite complex and as far as I
> understand it also error-prone. Tomi knows more about
> that.

It needs support in both the panel driver and the dispc driver, and is
quite intrusive. Or, at least it was with omapfb, I can't say if it
could somehow be implemented more cleanly with omapdrm. It's definitely
not something I will be working on.

> I have a simpler patch without the half-frame update
> stuff, which works fine for me. I didn't notice any
> tearing, but I haven't done any really fast image

You will see diagonal tearing with that rotation. But maybe that's not
an issue. I think it's the best option available if landscape mode is
required.

> updating. Also omapdrm has rotation support using
> the DSS hardware, which also seems to work ok. I'm
> still checking out what method is most suitable for
> mainline.

Hmm there's only so called DMA rotation, which shouldn't work. It's only
meant for really small displays, when the framebuffer is in SRAM. So I'm
a bit baffled as to what rotation you are using and why is it working =3D=
).

There is also VRFB rotation on omap3, but that's not supported by omapdrm=
=2E

> But yeah, we probably want to change the default
> rotation. Especially since touchscreen should have
> the same default rotation as the screen. (TS is
> horizontal, correct orientation for keyboard usage)

I don't know much about touchscreens, but I'm guessing that it's easier
to rotate the coordinates from touch than achieve good panel rotation on
N950.

 Tomi


--Ko2AG3FsFejW8Lhucq0O2haVVGRGHgLk7--

--kMJ3EUmKvL9aKisljPbJ47Tfg3VjhqDJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW38xlAAoJEPo9qoy8lh71EWUP/0zDMo4UqOSxoPGWgcQvc7sX
nJsfGv92C1Ttk3Tpc53mJiwV0yyh2XiC2CKACrDF1jFKXgARraDt3o7zp9w052Mh
S3Cv+oJNBWryf25xF9umDoR6L4oJpsWJwoQQfILJ9WiX9IiASQyV/VECNWijTbOj
8If/CQFiBMc/XEIcgHcMjCCuHtur7YGy9De0JoETmgxheLF9t4GuI4cX2SbCHzqA
uHU17jXjta7wm/Z36f/kU/gqKy+I7TT4rR5PIcD7GZpYGPDWWAFjr5UTHpajJPNI
FYJQKfqgwX4icJU48gFgUowtNE6ZpM3mThx0OT7YROWz9iCZwgyFFMfZFqhm3cmu
AiE75Z9Efp5SCzOSMnwjF/uHrc8RqApEhAjMNuevwy2A8AxrQUOJiPOl0rEGS6Yt
0m38EDTtsY68yGrl1o/EDUvcjoGPAcLtLMKbQW3G7W/9V2qq+stVOlJ7mOIHAn+k
1BEq9Yj7OnGXFtLhxPyFZPI8yjYYRNqJ/bECazG0zoAp13ApSNY5uwTVlW2tGDV/
ehF4ti7T8yOSSdINV3EjALesX37FJJKJu4o12IH9pXwXWYJV/osSP+PtYrA2bhbs
AiNvO21Nev/H8yTMwzent/NtH0IneAZE1x4l8Y+9xM+ROdiO6ai8IQy4tTE1dMl1
cVD0pBGgUjU8kCB1oE0h
=qHy1
-----END PGP SIGNATURE-----

--kMJ3EUmKvL9aKisljPbJ47Tfg3VjhqDJu--

--===============1002764228==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1002764228==--
