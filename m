From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/21] ARM: OMAP: overo: use new display drivers
Date: Tue, 30 Jul 2013 09:39:32 +0300
Message-ID: <51F75FA4.1050406@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com> <1374822504-28949-7-git-send-email-tomi.valkeinen@ti.com> <51F75B6A.6090900@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aw3JI2j5uAssKQtrt6be8trCtKl2aDCCc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57505 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab3G3Gj5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Jul 2013 02:39:57 -0400
In-Reply-To: <51F75B6A.6090900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--aw3JI2j5uAssKQtrt6be8trCtKl2aDCCc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/07/13 09:21, Archit Taneja wrote:
> Hi,
>=20
> On Friday 26 July 2013 12:38 PM, Tomi Valkeinen wrote:
>> Use the new display drivers for OMAP3 Overo board.
>>
>> The new OMAP display drivers were merged for 3.11, and we can now chan=
ge
>> the board files to use the new ones and phase out the old ones.
>>
>> Note that the LCD add-on boards for lcd43 and lcd35 use the same GPIOs=

>> for the panels. This means that both panel devices cannot be probed at=

>> the same time.
>>
>> DT will handle this correctly, i.e. the DT data will contain the panel=

>> device only for the add-on board that is attached. However, for the
>> board file we need a hackish solution: We parse the kernel boot comman=
d
>> line, and see whether lcd43 or lcd35 is set as a default display, and
>> add the given one. Or, if neither is given, default to lcd43.
>>
>=20
> <snip>
>=20
>>   static struct omap_dss_board_info overo_dss_data =3D {
>> -    .num_devices    =3D ARRAY_SIZE(overo_dss_devices),
>> -    .devices    =3D overo_dss_devices,
>> -    .default_device    =3D &overo_dvi_device,
>> +    .default_display_name =3D "lcd43",
>>   };
>=20
> The default display previously was the dvi device, if both lcd43 and
> lcd35 are on add-on boards, then we should probably stick to dvi itself=
,
> right? The hack won't work if dvi is the default device though.

DVI is also on an add-on board, but it doesn't conflict with lcd43 or lcd=
35.

The hack works fine even if DVI is the default device. In that case, it
doesn't matter if lcd43 or lcd35 is added, because the user doesn't use
them (as long as only one of them is added, because otherwise there'll
be an error during probe).

If DVI is the default device, we could actually skip adding both lcd43
and lcd35. I just wanted to minimize the code in this hack, so I didn't
do that.

 Tomi



--aw3JI2j5uAssKQtrt6be8trCtKl2aDCCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR91+kAAoJEPo9qoy8lh71Pc8QAJtFRd8D50NVyiiOAk6kkj39
Yci/uK1g9pgjGPsba889snhmtWP5Xe8DkSp/q/giOibtHi1QjHe11X/slUlAPnqZ
suFLyDOXi0LpX9DS4nppbYYpUbVwn/YzVE61pmQpoYJMHZjMSYNjFBkO+CWawSn3
kkhf9ekuRfPvLcPM2bbgbFbf3pajJ6LCcq+RAM2TLpV8pgi/NeQ01XhipgR2r4dJ
oudO7T/QF7rkrMHDzNBKde6ZiNUVDPRU/y7sOxmg91kc8g/11vH7lL2AUUcp0pBK
eH3LVEqNwUQ3s80rhNVcmMGgs8xRXn9BiRMK/A8IoT3ysJ0Ng7oTHr7goMva7LLI
BlZMJ3bbn9Xy+2fkrI/1/gmdBD9JHn6uXOi0lCgpaPd0AD7pAA882YAv1PmNbSR1
lAtAo+yojMubGnfyjY/J3FoL66Y+sBJM2BZBdM+SVcqW1E982su3Km7LDCo0exf4
Ww9VKNzNxEEKZ+jEYxOw9UzzP6j+Rl+wNwC8qsrz2pfqvfEHvd+p9NwVVseLTJF/
LGOPUtS6VCjQsb+VjPS/oOyd0FZoyCKsJlsTCJfmFuPploCwZbRypbBT46ss6fUK
pDI2IbGWkgZOLM20JXwliqmVG5vgu9DxDqR7XQbVYFX3nknoeEjfGhfi6j8d0+xt
F8VYLeKDMqQFNdQCcfJk
=Kpsx
-----END PGP SIGNATURE-----

--aw3JI2j5uAssKQtrt6be8trCtKl2aDCCc--
