From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: N900: Remove mmc1 "safety feature"? (was: Re: mmc0 on Nokia N900
 on Linux 5.4.18)
Date: Wed, 12 Feb 2020 14:02:53 +0100
Message-ID: <8d0ecfcd-f9a7-9563-8a39-9793cfbeb893@wizzup.org>
References: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
 <20200208190448.GA12984@amd>
 <270f27c9-afd6-171d-7dce-fe1d71dd8f9a@wizzup.org>
 <1eac0db3-17ce-8ebd-4997-8b1c282126e4@wizzup.org>
 <20200208220621.GA18161@amd>
 <d2d6d6ac-c964-ac48-1616-6f1826219385@wizzup.org>
 <20200210192714.GC14939@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PdQqh9EYD6JFCTHmHDJgejyoUTdPq8lQF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:35656 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726728AbgBLNBr (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 12 Feb 2020 08:01:47 -0500
In-Reply-To: <20200210192714.GC14939@darkstar.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Pavel Machek <pavel@ucw.cz>, linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Arthur D." <spinal.by@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PdQqh9EYD6JFCTHmHDJgejyoUTdPq8lQF
Content-Type: multipart/mixed; boundary="tj7PTIHMz0kSw1F5mQnlKG4GkV5IkLXXM"

--tj7PTIHMz0kSw1F5mQnlKG4GkV5IkLXXM
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/02/2020 20:27, Aaro Koskinen wrote:

>>
>> So how does this currently happen, the unmounting? Does the mmc1 card
>> just disappear from /dev/ without any safe unmount? I don't understand=

>> how the current setup can work from a userspace point of view.
>>
>> Userspace could react on kernel events that tell it the cover is open,=

>> but I assume the kernel doesn't just decide to nuke the node from /dev=
/,
>> so in that case the current DTS setup still doesn't make sense, right?=

>>
>> What am I missing? Could you describe how this would work in a 'real
>> life' scenario?
>=20
> I don't think it can work with the current mainline kernel.
>=20
> I recall the original Nokia kernel used the GPIO for "cover switch"
> instead of card detect, and it was visible in sysfs, and this allowed
> userspace to react on cover removal.. In the mainline kernel we have
> this for older Nokia devices (770, N8x0), but not for N900. Still it
> wouldn't help much for "safe unmount" as the unmount can take quite a
> while, and user may remove the card too early.

Shall I send in a patch removing this check from the device tree, then?

Cheers,
Merlijn


--tj7PTIHMz0kSw1F5mQnlKG4GkV5IkLXXM--

--PdQqh9EYD6JFCTHmHDJgejyoUTdPq8lQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXkP3fgAKCRAGN09rynK8
WqgfAP0bN1WmVycWlDJT9UdXWe/IX6I5vKQaR/tD2RgHxnNIpwD/Xc7EIEfp63Hn
OsH47u7x4D1ILg7DFgElQMDWxFM9xw8=
=mxtC
-----END PGP SIGNATURE-----

--PdQqh9EYD6JFCTHmHDJgejyoUTdPq8lQF--
