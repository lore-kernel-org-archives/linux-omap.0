From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP2430 SDP boot broken after Linus' rmk merge
Date: Thu, 25 Jul 2013 09:50:13 +0300
Message-ID: <51F0CAA5.8010108@ti.com>
References: <alpine.DEB.2.02.1307221801110.10891@utopia.booyaka.com> <20130722184325.GA21614@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1307222005370.26048@utopia.booyaka.com> <51EE2AA7.5060503@ti.com> <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com> <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com> <51EFE1DD.8070801@ti.com> <20130724145237.GB21614@n2100.arm.linux.org.uk> <51F0C841.8000900@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="FPUKFalNONAcsJ0bnu6x02Dv2mIlIgSKp"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36812 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab3GYGuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jul 2013 02:50:54 -0400
In-Reply-To: <51F0C841.8000900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <will.deacon@arm.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--FPUKFalNONAcsJ0bnu6x02Dv2mIlIgSKp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/07/13 09:40, Tomi Valkeinen wrote:
> On 24/07/13 17:52, Russell King - ARM Linux wrote:
>=20
>> I also continue to be disappointed by the lack of things working on th=
e
>> 4430 - it's been a number of years now and _still_ the on-board LCDs d=
o
>> not work.  People have tried to blame that on hardware faults and the
>> like, but they're just being idiotic when they say stuff like that.  I=
t
>> can't be hardware faults when the kernel supplied with the board is ab=
le
>> to make them work to the extent that userspace can play back video on =
all
>> three output devices simultaneously, without hiccup or any imperfectio=
n.
>> I don't know whether it's just that the backlight support isn't workin=
g
>> or what - because any information on the 4430 seems to be a tightly
>> controlled secret that only a few select people are permitted to know
>> about.  As far as I'm concerned, much of the hardware is a black box t=
o
>> me.
>=20
> The 4430SDP's backlight hasn't been working in the mainline due to
> missing support from the TWL driver. But we finally did get that in for=

> 3.10 (or maybe 3.9), and booting 3.10 non-DT kernel brings up the
> backlights. However, the BL doesn't work yet with DT boot, so again wit=
h
> 3.11, with no board files, the BL is out... Sigh.

Ah, sorry, I take that back. Backlight seems to be working fine with 3.11=
=2E

 Tomi



--FPUKFalNONAcsJ0bnu6x02Dv2mIlIgSKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8MqlAAoJEPo9qoy8lh71QdIQAKA/WcJB0nHX5YeCtJax0BUf
WF90DlZ1bKNVDL/CjyRviOYyGH+yg17EYyVgKwjM36AP1juMBnOJdEZBh2ubES5O
GA++EO2nj0ihbyF0vrlexBFPwvJ6gfZ6+lSKgZQIk/pRdY3j7s8Iyt+EIeKX1Sig
yVjdr7g4loh02u588cQK9rPFrevdO3EB5hnRWT5IlkAXpf4VW436CsPgdgZlvOBX
nJbXrR4lVP/XjlvawRaJ9vvtZ9kwlgAWqoCTAceRa5Vg81mBrkfJghs2TIqjjH2P
ezW4Da8VrIQR27dkTwcAdR8//G/MaeQNtfGHnYNOIKXWDapqkDVvKu0HErN7SdHA
eXnHuefodbymxJv5/FvD5YBYC0fLt57MZepnsy+3fkeko+XEeyLVag/x/G2NbksI
jtLD3BuqghCJY7fZpTqEpBqbEELoPvNDeP/L1w7nSCn2P+QZC5A5FLU2mk291gp9
nXRxcuunsBgNtdoBiZ3R3BHAF+tvhkPlkC1w09IwL98TdRaJtuQHnJ5N+KAhDhJA
s4BNcTqrMtJfx3SAKNcQ3ARzHMjeqNSFar+kmM0BgyIWY+2zxpjgTCsv4QaS6Xe4
hzSLE8dsHfcJ26DQclhJy25mDryW6IYR0uZObrvLqHvwh7qfJS1zHgzHKhgBCEP5
hSlM5DekkB/j8hLRhGIR
=Rkp7
-----END PGP SIGNATURE-----

--FPUKFalNONAcsJ0bnu6x02Dv2mIlIgSKp--
