From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: DRA7xx: hwmod: set DSS submodule parent hwmods
Date: Thu, 8 Jan 2015 13:11:05 +0200
Message-ID: <54AE65C9.6080600@ti.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com> <1418985914-9027-3-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1501022250010.27058@utopia.booyaka.com> <54AA68CF.9050904@ti.com> <alpine.DEB.2.02.1501081000180.28771@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="E13U4WSCttbRGrTASSHucpEXBn5Ar8UlP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54266 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452AbbAHLLk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2015 06:11:40 -0500
In-Reply-To: <alpine.DEB.2.02.1501081000180.28771@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--E13U4WSCttbRGrTASSHucpEXBn5Ar8UlP
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/01/15 12:15, Paul Walmsley wrote:

>> For DSS, the bit 0, DSS_DESHDCP_CLKEN is critical. While the bit is
>> rather undocumented, it presumably enables a clock for DSS's HDCP. Now=
,
>> we don't support HDPC in the display driver, but unfortunately the clo=
ck
>> is required for the DSS hardware to initialize.
>=20
> Do you know where this DSS_DESHDCP clock appears in the clock tree?  Is=
 it=20
> downstream of the main DSS functional clock, or does it come from=20
> somewhere else?

Unfortunately not. It is not mentioned in any documentation I can find.
OMAP5 has the exact same HDMI block, but it does not have this bit in
the control module.

There's this commit from Archit (who is no longer in TI) with some data,
but I cannot find any of it in the documentation:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/247993.h=
tml

Maybe OMAP5 has this clock always enabled, i.e. direct L3 clock without
the gate, and the bit was added to DRA7x to give the tiny bit of power
saving it might produce. This sounds quite likely scenario to me.

If so, it would not sound too bad to set the bit at boot time to make
the HW work like OMAP5, so that the SW could be the same. But then
again, I'm purely guessing.

> Sounds like the thing to do in the short term is to drop that patch fro=
m=20
> the fixes series.  Then we can add it back when DSS_DESHDCP_CLKEN is=20
> sorted.  Are you OK with that for the time being?

Yes, I think it's fine to drop it. While resetting the DSS at boot time
would be nice, I think in practice the only diff with this patch (if it
worked) and the current situation are the few hwmod warnings we get at
boot time.

However, I'm working on DRA7 display support for omapdss, and it won't
work if the DSS_DESHDCP_CLKEN is not enabled. So we need some kind of
solution pretty soon.

>> I don't have a good idea how to manage the bit properly. As far as I
>> see, the bit has to be managed via syscon, using remap_update_bits, so=

>> that we get proper locking. With a quick glance, I didn't see anything=

>> for that in the current clock code. And can we presume that syscon is
>> probed before hwmods? I guess not.
>=20
> Based on the description so far, it sounds like there should be a syste=
m=20
> control module driver that registers this clock, along with all of the =

> other clocks in the CTRL_CORE_CONTROL_IO_2 register.  Just shooting fro=
m=20
> the hip here, I guess we'd probably list that DSS_DESHDCP_CLKEN clock a=
s=20
> an optional clock for DSS in the hwmod data, and add some code to indic=
ate=20
> that it should be enabled and disabled with the main_clk.

Hmm, ok. So a syscon driver, that registers this clock (and maybe some
others), and allows access to the non-clock bits via regmap, and handles
locking between the clock and non-clock accesses?

>> For the time being, I think the easiest solution would be to just set
>> the bit and leave it enabled. My understanding (based on commits in TI=
's
>> product kernel) is that leaving the DSS_DESHDCP_CLKEN enabled doesn't
>> really affect much, and any increased power consumption would be too
>> small to measure.
>>
>> If that's the route, the question is still where to enable it. As I
>> said, I have an u-boot which enables it, but I'd rather do the enablin=
g
>> in the kernel. If in the kernel, where there? It has to happen before
>> the hwmod init is ran.
>=20
> Yeah, that's a tricky question to answer.  If DSS_DESHDCP_CLKEN is mode=
led=20
> as a clock, then it could be marked as ENABLE_ON_INIT, but that seems l=
ike=20
> kind of a hack.

True, but the HW here also seems like a kind of hack =3D). Random bits
from various subsystems in the same register... sigh...

 Tomi



--E13U4WSCttbRGrTASSHucpEXBn5Ar8UlP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUrmXJAAoJEPo9qoy8lh71VY4QAKvfFU6vKiy/xBbaAHfJzJ7C
ejTe79j+6TgsTQ9rHIbPguy+tcG2FTPFh8Wc5JE9/VnAmcDJoL7hkXvyg2F41D97
qVhatqlyfUCMqgascb44M0XxbBLZpBXHBQ4wN8yyPKfEyEFDkE90LfaMZS6Kq0JT
178vWI5OsdH/s3TYQVXgx1syQgRBjykmC9TsRwsxYmSqCWmUxNqH2ePc50PDceoU
Cc4kUsfnIgq/OShXWWrdtlJymbbbb5GgbB9DjmPQ8XJp4iGXn7fpTz9cStnuIJjv
Tn7DzitQjbgBMU4h/VWAJksJ1yUxE3aoQgLTrmVyl3M3rWDJ6pZR90hNUREGWGQ7
IBQWBCawD2am3Xx++DKGmw0hIryhpadzJEucrZdBbAgg5mteoDSG01yoC31NMs9f
3+DzclvMD2+LC1MEZPny+t7n6Q9GXvRAcXdrEcsAELDmHWSmH+mJxIJMvMHGFIOB
y2OuripniEEPMCF1Qcd88w0DtLoq/RO2gSXYdpPMYsfg3lWS259D5A08jEXWyld1
q18nZZUUf/Pr2Mpu0DdwMMQcvXo1Kk4tvHbVbMoeXPCUW6Tuxdp4iy36MTjp0bKD
pdOyBdkQOXTtGee7BFpfWIzEV1029cdWEOE1QqQVvfacvpgs6OPtwpQoB2bwIpIj
vjcFkHv/JSYwjjKQoxEj
=d7J3
-----END PGP SIGNATURE-----

--E13U4WSCttbRGrTASSHucpEXBn5Ar8UlP--
