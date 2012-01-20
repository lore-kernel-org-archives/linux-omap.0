From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 12:33:39 +0200
Message-ID: <1327055619.1921.57.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-5G9oEp1MNrBNatn65pZK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38875 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736Ab2ATKdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 05:33:44 -0500
Received: by mail-lpp01m010-f43.google.com with SMTP id o2so413598lag.16
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 02:33:42 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>


--=-5G9oEp1MNrBNatn65pZK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm testing v3.3-rc1 on OMAP3 overo, and I'm having problems probably
related to PM.

First, when I boot up, the console (via USB serial) is very laggy, it
often takes many seconds until the key pressed appears so it's more or
less unusable.

Second, I compile DSS as modules, and don't load them. Looking at
debugfs/pm_debug/time, I can see that both RET and ON for dss_pwrdm are
increasing. What is making DSS powerdomain switch back and forth?

Third, when I load the DSS modules, I see only ON state increasing for
dss_pwrdm, as it should be. However, I'm getting constant stream of sync
losts from DSS, and the display doesn't basically work at all.

I can see MPU pwrdm going into RET a lot, and if I do "while true; do
echo foo; done", which I presume basically prevents RET for MPU, the
display becomes stable.

This sounds a bit like the problem reported by Joe (DSS2/PM on 3.2
broken?), although this is happening all the time. In this case, as in
Joe's, the DSS fck is well below 96MHz, which is the limit on OMAP3 for
DSS fclk on OPP2. And I'm not aware of any other constraints for DSS
(well, memory throughput, but that should cause fifo underflows).

Is there a way to lock the OPP to the full power OPP?

Is there a way to see the OPP being used?

 Tomi


--=-5G9oEp1MNrBNatn65pZK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGUMDAAoJEPo9qoy8lh71d08QAJfSN65W8m3x3n1WbWEuSCzu
pRU5CCToOdvzYDF7n7q05xCV/3p196LnSPrYpp/jrELH5reSDkxQuN2BMBnMID6G
UVxgdp8j5rKrtvL0eelmV3c/WackKebfaI34u4XBfrrCbyL0TDnxtYyVFUs20I2m
Reb+/wuwi0gEsZ+IxFegXeJzPPyhbp24G1/u81ESt9St2tGBb/u6NVkSKB+wQIY2
wdAQd9wPAbKIZ66fmmGB3BhcFy/+pSyH7/zM36L3VvVykJhBG5C1yRf4XiYoLK53
ExWaASkdCF0Eobrp9JAs15WB5haEsXmwo4YVJJFo0uOXg7JS+oIkjzY1pgidrmmc
BWT8M8WQvwUHnMdzJKRL9HuxJrLbqkfzKV6CT1LZ2zgM/KmDdsPCkuRxGsBTPK1b
fAc+Bmxy6g3XsG/zP+iRWvtgIMZnqh0I7zy75vOqmfhjT5oNbeu3pcqJgIBmq34H
nF1Dkv9EkJfZEiM3AYMPwJSiaG1VjqVCZF1g/0ma7GSxKCEic8YFcwsMV7ooRqRW
4eni5pZ4ZzEt+Jzb+bJsZDHyNpeifj2eCkmUcBgZ5UD8Bby8vUAX+RuZ+5nfT5Rl
0VhSGzuXD0w5oVVKeveXX2GCUEqgI1ClgMmzhm7+lNAeKIWhv2hlAVLl7z6y1fMf
QWZYZLXQ34W5R15Lesnn
=JOJC
-----END PGP SIGNATURE-----

--=-5G9oEp1MNrBNatn65pZK--

