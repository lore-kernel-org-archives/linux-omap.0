From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 00/10] Nokia N950 basic display support
Date: Tue, 21 Mar 2017 11:38:53 +0200
Message-ID: <601e6d5f-59f7-dcc4-1efd-6c9a52bfd298@ti.com>
References: <20170304235021.27055-1-sre@kernel.org>
 <d34e7a44-2ab9-52de-c888-21d19399ab11@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1058232252=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <d34e7a44-2ab9-52de-c888-21d19399ab11@ti.com>
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

--===============1058232252==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CLWEnG6Md6ccmuHALC1MBEGOJvLNwjhXk"

--CLWEnG6Md6ccmuHALC1MBEGOJvLNwjhXk
Content-Type: multipart/mixed; boundary="6BlMJN7j0FmoFNg58NFHvFTimp4FMlidN";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-ID: <601e6d5f-59f7-dcc4-1efd-6c9a52bfd298@ti.com>
Subject: Re: [PATCHv2 00/10] Nokia N950 basic display support
References: <20170304235021.27055-1-sre@kernel.org>
 <d34e7a44-2ab9-52de-c888-21d19399ab11@ti.com>
In-Reply-To: <d34e7a44-2ab9-52de-c888-21d19399ab11@ti.com>

--6BlMJN7j0FmoFNg58NFHvFTimp4FMlidN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20/03/17 13:29, Tomi Valkeinen wrote:
> Hi,
>=20
> On 05/03/17 01:50, Sebastian Reichel wrote:
>> Hi,
>>
>> Some of you may remember, that I sent a series for the N950 display
>> some time ago. N950 has command mode DSI panel, so the main part of
>> the patchset takes care of adding manual display update support in
>> omapdrm.
>>
>> The N950 also requires display rotation (the panel is mounted vertical=
ly
>> and bottom-up) and offset. The required bits will be sent separately.
>>
>> The patchset is based on 2d62e0768d3c, which is the current commit
>> torvald's master branch points to. I tested the patches on N950
>> with kernel console (fbcon), Tomi's kmstest and Xorg from Debian sid.
>>
>> Rough changelog, most of that work was done by Tony (thanks!)
>>
>>  * lots of patches dropped for now
>>  * rebased to current omapdrm interface
>>  * added OMAP4 support
>>  * misc. cleanup
>=20
> I haven't been able to go through this series with time, but looking at=

> the patches, there were multiple places where I felt quite uneasy with
> the changes. It didn't help that many of the patches did not have
> descriptions.
>=20
> So as an RFC series, it's quite nice and shows that the manual update
> can be gotten to work. But I'm not ready to apply this until the patche=
s
> touching the omapdrm enable, disable and commit sequences are split up
> into smaller patches with proper descriptions.

I made a quick test on my OMAP4 SDP (it has similar panel to N950), and
I did get a picture on the LCD, and kmstest --flip works. It's tearing,
though, and the fps is ~80, so apparently TE signal is not used for
synchronization here. I think nobody is calling the enable_te().

 Tomi


--6BlMJN7j0FmoFNg58NFHvFTimp4FMlidN--

--CLWEnG6Md6ccmuHALC1MBEGOJvLNwjhXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY0PSuAAoJEPo9qoy8lh71D/cQAJOesKnDzlAAuIs9vsAFvG5R
B/T/T0+bNLf7Gq3ZB6UyFzQkKrajYQAKX4LkImZKuqaw4UsAK4+SAnR8EtTjWlvp
KOh9md0YZ2lmb8Y2y7oV2G4pcdKXFn6SelNvvDOUSC8vd5kzKDvJRYSnjyUFAbVC
3DhLWwKDhL0UVebz3AG8Sj4UOGFJFQ1xzxI23LYGA2ZIC3py4FmwGHvbm3Dv2BV9
M302nSZlZ049oVja7cc4a7wLj2le4YG0ORugwht+2KFTirW/j/Tfd6/AQe4LKEdc
+qdZAq9URf1QMPrmh5xA8FlEiTQ3bSjovnyZZxTFDlUx7S0MBZHqZfukgbvV5BT0
UTqof3TUyTk4poRE0eHJXtxf9OvD2j61fC69f2lMpTFIZ01/mxG2sAtqMSMwt96w
nZqMkDvn0Y0A2cvtT5RGmgT6xAy5YOylUAl17P64zHzT2ZNvJ8/OgYR+zdnjvtLu
tbV7iI3u+7rT3rEUbT/yXUuhgS3E2P2Cy7PKkY8IQm004hh3SyoWzKtQ3qgrJEX1
7zfb2DWOq7M8UtYC/jstEaCWfH84YzEPGGao9Tor6uPszGItza1xeg95fYq4WcQ9
tVIA9XDbAcphcDGdKzV0XiL5oTOHcjpU81X4BwVlHVqkaWuCxZaCDgtITTodX9ib
tHiC67vwsuSVEzGeFxGW
=Lswr
-----END PGP SIGNATURE-----

--CLWEnG6Md6ccmuHALC1MBEGOJvLNwjhXk--

--===============1058232252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1058232252==--
