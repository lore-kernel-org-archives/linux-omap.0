From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Panda: USB crash with today's linux-next
Date: Mon, 14 May 2012 15:24:11 +0300
Message-ID: <1336998251.2333.17.camel@deskari>
References: <1336996151.2333.3.camel@deskari>
	 <20120514121527.GF22242@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-/9FoyFg4jzEOekBScVOP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:54024 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755412Ab2ENMYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 May 2012 08:24:17 -0400
Received: by lbbgg6 with SMTP id gg6so4070790lbb.36
        for <linux-omap@vger.kernel.org>; Mon, 14 May 2012 05:24:14 -0700 (PDT)
In-Reply-To: <20120514121527.GF22242@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org


--=-/9FoyFg4jzEOekBScVOP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-05-14 at 15:15 +0300, Felipe Balbi wrote:

> looks like MUSB is probing before transceiver driver... could it be ?
> Can you check transceiver has actually probed ? I guess panda's using
> twl6030-usb.c

Ah. Perhaps it's then about this?

[    0.352905] Skipping twl internal clock init and using bootloader value =
(unknown osc rate)
[    0.354034] twl 1-0048: PIH (irq 39) chaining IRQs 352..372
[    0.356079] VUSB: 3300 mV normal standby
[    0.358123] genirq: Threaded irq requested with handler=3DNULL and !ONES=
HOT for irq 356
[    0.358215] twl6030_usb twl6030_usb: can't get IRQ 356, err -22
[    0.358398] twl6030_usb: probe of twl6030_usb failed with error -22

 Tomi


--=-/9FoyFg4jzEOekBScVOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPsPlrAAoJEPo9qoy8lh715kMQAKXIqId7Lr+AJ24dUUl8lUMq
amSyS3trziI2iII1tD2GED0n8cZVqgoZOaGZHBHL8SayvG4B8CFbF4qQ03+oUAfQ
dyRt8ZM6HJbcnEeVYZJD/PvoAPmAw4YlEk8//TVXrpPBK1PVgp4SFz538wx9L2P6
NMpjeMATL8QVQOfqXvpDU8vtwS0nGIUWB1h0HNKBuPLZMhVRCWf7hh+MaPHLaM3b
Zd2TJvyJUZuRpfVjRyWdxKVi3luEy2oVdf7TPLflkqJbQJLEbLD0zqxkVU1/GmJS
2IJmy/fBY3yCb56bcqXotafjDLa6fcMnF91eNtHdZQ/ZxZpKngoWUyHcwzijIG8O
dwK8VrBdQLLy2bRtD16LfTK36InalH/vCfDGbcQ60xicK+abL7U9OQtMVuMKlnzG
/zRTD69E4lGLwsGuA2GtNN/nkHra69kHuQ0TNuFYhfYk6mgpfUnccACJRAi0W0m3
f9qOzReWQaTrDh7N2YIvFw5Q3EW017CrskUQ9Rg7WbAVaVgJwCWYwo8dKr9kYAIO
FdzivCXP/XH9YpRUnc7sEI4Hl0xeTgRKTqGv0EloT1YLGu8EKEBO0BqRJKq6/CkO
H/I+sq9N24IRSfzgQbtd0aL3Nc29BhrCDWVKMyAr3VhvGe3PkULzzYMipUlq2QqK
W+u7n/1Ex+RbnDxMMt/I
=KXt2
-----END PGP SIGNATURE-----

--=-/9FoyFg4jzEOekBScVOP--

