From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Fri, 20 Dec 2013 15:43:30 +0200
Message-ID: <52B44982.4020501@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk> <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com> <20131219175644.GE32243@n2100.arm.linux.org.uk> <20131219182252.GP27438@atomide.com> <20131220112700.GF32243@n2100.arm.linux.org.uk> <20131220114837.GH32243@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="lAFC4fG5COs3MtX9wV5QcaplmI6bAuEMR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52322 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030186Ab3LTNo0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 08:44:26 -0500
In-Reply-To: <20131220114837.GH32243@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--lAFC4fG5COs3MtX9wV5QcaplmI6bAuEMR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-20 13:48, Russell King - ARM Linux wrote:
> On Fri, Dec 20, 2013 at 11:27:01AM +0000, Russell King - ARM Linux wrot=
e:
>> Maybe, but that's the problem - finding out what is missing.  This is =
the
>> endless problem where things keep changing - it's very difficult to ke=
ep
>> a "working configuration" working because the config symbols keep chan=
ging.
>>
>> Also, bear in mind that there's many different variants of the LDP har=
dware
>> with stuff connected up in different ways (I'm aware that the keypad i=
s
>> just randomly allocated).  I wouldn't be surprised if this also applie=
d
>> to how the backlight on the LCD was done.

I need to cook up a patch for the gpio active-low problem. I tried to
figure out how to do it with the old GPIO API, but as far as I
understand, I have to do it manually in the driver (as it was done in
the old driver).

> Or maybe this is getting buggered by the idiotic deferred probing...  I=
t
> seems that the GPIOs for controlling the LCD and backlight aren't even
> getting claimed if the DSS modules are built in:
>=20
> # cat /sys/kernel/debug/gpio
> ...
> GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
> # echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/unbind
> # echo panel-dpi.0 > /sys/bus/platform/drivers/panel-dpi/bind
> # cat /sys/kernel/debug/gpio
> ...
> GPIOs 238-255, platform/twl4030_gpio, twl4030, can sleep:
>  gpio-245 (panel enable        ) out lo
>  gpio-253 (panel backlight     ) out lo

This looks odd... Presuming the panel device was probed successfully, it
should always get the gpios or return an error. Only if gpio_is_valid()
returns false for the gpio, it skips it and continues. But in this case,
the gpio number comes from the platform data, so it should always be vali=
d.

And if it wasn't probed successfully, then there shouldn't be a fb0.

 Tomi



--lAFC4fG5COs3MtX9wV5QcaplmI6bAuEMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJStEmCAAoJEPo9qoy8lh71W0wQAIAM0Zngr1IW/Y75p3w26tgV
xSuD+J+Q2JdLBQgvBc/0awkqlzRoSfqMXKJjOC8zHoxflVquo5XYSrb3/jf4Vchw
TOYoNuinBnVC+UExlHrT5BEW8OsNd7MO475+V5LynIF5AzK5CeZZwqd9yx2e35Qh
VgcClcugMmbb1CPd1PQ/RUCjCMypkkUoWv+i/i3QmXbk8yOth7Kk7dVhyakwaCxs
HsIRIBNsqAmDEKnvXVpmwvo46rpmh0dFUmwgO9IanaVU6EKM5jUsgOWwCv10rdy2
hsMkUrrsB/6Lc0tHs+8tnFSmoNMGtz03f9uOFRrpRvRYGsSNNxR1hX6G9yTKXmn+
FeVs3s5ColuuPXDgXmdF3NHR0tVt/Redz4NQ7h9Qe3HrF2nbnWSmfQ7/pZWkw2XY
1nFl+mmQDU7ekUdcz2xG3u85RFNLIjX9UANqU4Q9EZleuFei14gL3Knhe6QoMwIZ
0VQZPMbYvmZlbF5IeayP9tPvx9FpeCJ2TSmH7wICmrNiJW6UZAAU7ydRRBn/KD05
wrZweQeG/K1JwqZLtwfshWc4DhLv3pOFtoSWy2AZYzruS5dsuvxQBjQnyLhg4Be3
zzE/P5Hx3MNq52LR2LMah1okuOuK+CwIOBbRAS72BXcnZJyd/vM4QElRmjWVUL4f
a8M8b/3jlDTeUvkVHmTs
=29rt
-----END PGP SIGNATURE-----

--lAFC4fG5COs3MtX9wV5QcaplmI6bAuEMR--
