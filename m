From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: Nokia N900: wl1251 spi3.0: EOW timed out on
Date: Sun, 10 Mar 2019 20:23:12 +0100
Message-ID: <1b2918b4-1765-5aba-4752-1d04bdfea925@wizzup.org>
References: <3819003e-2ab3-0325-de0d-9fa07b51ee9f@wizzup.org>
 <436a9a35-539a-3fe8-2225-36b45c7e5412@wizzup.org>
 <165d492e-435b-40a8-f784-5f2d08803514@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4An5W0rzu4eZ1JGXKN0lH2xxU2O359vYZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <165d492e-435b-40a8-f784-5f2d08803514@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh Raghavendra <vigneshr@ti.com>, "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4An5W0rzu4eZ1JGXKN0lH2xxU2O359vYZ
Content-Type: multipart/mixed; boundary="2ZZSGR0B291btdmnZREGnbu4O8UcrdOY1";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Vignesh Raghavendra <vigneshr@ti.com>,
 "kvalo@codeaurora.org" <kvalo@codeaurora.org>
Cc: linux-omap <linux-omap@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sre@kernel.org>,
 Pavel Machek <pavel@ucw.cz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>
Message-ID: <1b2918b4-1765-5aba-4752-1d04bdfea925@wizzup.org>
Subject: Re: Nokia N900: wl1251 spi3.0: EOW timed out on
References: <3819003e-2ab3-0325-de0d-9fa07b51ee9f@wizzup.org>
 <436a9a35-539a-3fe8-2225-36b45c7e5412@wizzup.org>
 <165d492e-435b-40a8-f784-5f2d08803514@ti.com>
In-Reply-To: <165d492e-435b-40a8-f784-5f2d08803514@ti.com>

--2ZZSGR0B291btdmnZREGnbu4O8UcrdOY1
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/03/2019 05:16, Vignesh Raghavendra wrote:
> Hi.
>=20
> On 10-Mar-19 6:23 AM, Merlijn Wajer wrote:
>>
>> Hi,
>>
>> On 10/03/2019 00:22, Merlijn Wajer wrote:
>>> Hi,
>>>
>>> I just migrated to Linux 5.0  (from 4.15) on my Nokia N900, and I'm
>>> getting a lot of messages like this:
>>>
>>>> wl1251 spi3.0: EOW timed out
>=20
>=20
> Could you try if this patch fixes the issue? This is part of latest mai=
nline tree but not part of 5.0:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dbaf8b9f8d260c55a86405f70a384c29cda888476

This seems to fix the issue. Would it make sense to queue this for an
upcoming fixes release for 5.0?

Cheers,
Merlijn


--2ZZSGR0B291btdmnZREGnbu4O8UcrdOY1--

--4An5W0rzu4eZ1JGXKN0lH2xxU2O359vYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXIVkIAAKCRAGN09rynK8
WnkAAQCQ5LxFtM6fUlPxlz97ruW7Bmn6wgtOaXP15aWuNyBlSwEAw78y5s0Ap8mb
UlcR3FQ9iaPKvji170PUkYQgXOeCLAU=
=48NK
-----END PGP SIGNATURE-----

--4An5W0rzu4eZ1JGXKN0lH2xxU2O359vYZ--
