From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 00/10] Nokia N950 basic display support
Date: Tue, 21 Mar 2017 11:54:11 +0200
Message-ID: <352d4f10-c4b6-4a94-1687-c10e8ae286da@ti.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <d34e7a44-2ab9-52de-c888-21d19399ab11@ti.com>
 <601e6d5f-59f7-dcc4-1efd-6c9a52bfd298@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1882596940=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <601e6d5f-59f7-dcc4-1efd-6c9a52bfd298@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

--===============1882596940==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TURXVaBJ9Uh64c4am9g72XBuri53k2xtb"

--TURXVaBJ9Uh64c4am9g72XBuri53k2xtb
Content-Type: multipart/mixed; boundary="SRGxqD3IsXuwOJhwI8qISHK1WeTgtpjO9";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <352d4f10-c4b6-4a94-1687-c10e8ae286da@ti.com>
Subject: Re: [PATCHv2 00/10] Nokia N950 basic display support
References: <20170304235021.27055-1-sre@kernel.org>
 <d34e7a44-2ab9-52de-c888-21d19399ab11@ti.com>
 <601e6d5f-59f7-dcc4-1efd-6c9a52bfd298@ti.com>
In-Reply-To: <601e6d5f-59f7-dcc4-1efd-6c9a52bfd298@ti.com>

--SRGxqD3IsXuwOJhwI8qISHK1WeTgtpjO9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21/03/17 11:38, Tomi Valkeinen wrote:
> On 20/03/17 13:29, Tomi Valkeinen wrote:
>> Hi,
>>
>> On 05/03/17 01:50, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> Some of you may remember, that I sent a series for the N950 display
>>> some time ago. N950 has command mode DSI panel, so the main part of
>>> the patchset takes care of adding manual display update support in
>>> omapdrm.
>>>
>>> The N950 also requires display rotation (the panel is mounted vertica=
lly
>>> and bottom-up) and offset. The required bits will be sent separately.=

>>>
>>> The patchset is based on 2d62e0768d3c, which is the current commit
>>> torvald's master branch points to. I tested the patches on N950
>>> with kernel console (fbcon), Tomi's kmstest and Xorg from Debian sid.=

>>>
>>> Rough changelog, most of that work was done by Tony (thanks!)
>>>
>>>  * lots of patches dropped for now
>>>  * rebased to current omapdrm interface
>>>  * added OMAP4 support
>>>  * misc. cleanup
>>
>> I haven't been able to go through this series with time, but looking a=
t
>> the patches, there were multiple places where I felt quite uneasy with=

>> the changes. It didn't help that many of the patches did not have
>> descriptions.
>>
>> So as an RFC series, it's quite nice and shows that the manual update
>> can be gotten to work. But I'm not ready to apply this until the patch=
es
>> touching the omapdrm enable, disable and commit sequences are split up=

>> into smaller patches with proper descriptions.
>=20
> I made a quick test on my OMAP4 SDP (it has similar panel to N950), and=

> I did get a picture on the LCD, and kmstest --flip works. It's tearing,=

> though, and the fps is ~80, so apparently TE signal is not used for
> synchronization here. I think nobody is calling the enable_te().

Oh, and I also see these.

[   42.550170] omapdrm omapdrm.0: lcd: timeout waiting for disable
[   42.690216] omapdrm omapdrm.0: lcd2: timeout waiting for disable

[  104.280212] omapdrm omapdrm.0: lcd: timeout waiting for enable

 Tomi


--SRGxqD3IsXuwOJhwI8qISHK1WeTgtpjO9--

--TURXVaBJ9Uh64c4am9g72XBuri53k2xtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY0PhDAAoJEPo9qoy8lh71Mc4P/17P8df/Ntyay5rJevDEGOV1
FDrv4VzbA447tkDY+Y2EdPKhOZOmWVwm2ySLsZ53K5FpvePQzY/DOCDtoRIYWIuM
zSredGSWrV+PUJ7cMLE5P/i204yDVBFIHXW3Lhh4Ng5QOEXEv9FFZYXIuOJtmnMP
2Yf6ILRf6K4qpZfnnjOkvoX/wRTSYiP+Hnjmcl5JmpdIOKFcIdl/8WLrBkz3GdnN
4fvasj3vLbm3m7AXXPBffLYfC9Rtqr88P6NxrdMapnN5gylit5IrHq35vrQpDFCQ
7N3RjiZYJFvSg00tiddg7WteICtEMHl0H9K9Nzl0ASOh2j8EqAHyrK/OLfj3lYm+
5wuNfTaNfuPdF6JRhmSyGwGFNTYWpI+tp9DikKrNlmMaSl8Qb+osY2fru3Yd1VnX
8sfhvhNDjBRF8xBCd73KJ5T2hJHNqnx4N8Eruq9pr9RjkKcKFzlqFqiMPWIAD+VR
T4GdFgj6ECAragV1h3qBoSLyRjjmL1H940Whq0ZkjliFbNykOE7VVLU7XqSnQ86S
AWuy2e98GfkB7LcZxP3+0uAdq8oep7KHTPXmWPOkEVHVPXlu4oROhN5FpV43n6Pu
2UXuRlbooFiD3q71HCAcZL+scLggAZgdVaiE0rzRUI3kxeZWyYQpdtaQy4pvkdFQ
g88dqz04EftqZzQR4j9E
=P5EF
-----END PGP SIGNATURE-----

--TURXVaBJ9Uh64c4am9g72XBuri53k2xtb--

--===============1882596940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1882596940==--
