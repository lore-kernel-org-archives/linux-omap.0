From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: Spurious ECC errors with mtd_subpagetest (OMAP3, NAND)
Date: Mon, 5 Mar 2012 09:56:30 +0100
Message-ID: <4F547FBE.4030805@parrot.com>
References: <4F50F2AB.10209@flatfrog.com> <CANOLnOM6X=29r7_aMs=z4eiDtw0kvWZ-jSeds_NO0KdZ3E8Ouw@mail.gmail.com> <4F5475A8.3050600@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:49834 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab2CEI4d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 03:56:33 -0500
In-Reply-To: <4F5475A8.3050600@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Orjan Friberg <of@flatfrog.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Orjan Friberg a =E9crit :
> On 03/02/2012 06:17 PM, Grazvydas Ignotas wrote:
>> IIRC NAND in mainline was broken for very long time on OMAP3, I thin=
k
>> it was only fixed in 2.6.39.1.
>=20
> That seems to be the case; the 2.6.39.1 diff contains the OMAP NAND s=
ub=20
> page write fix (applied locally).
>=20
Note that the omap driver is still broken :
http://article.gmane.org/gmane.linux.drivers.mtd/36079/match=3D

We detected this when stressing a board.

Because all of these bugs in omap driver, I wonder how many people real=
ly use
the mainline version.


Also if you use a nand that need 4-bit ECC, you need a better ecc than =
hamming.
You can use the bch code (
http://article.gmane.org/gmane.linux.drivers.mtd/37864/match=3Domap )

Matthieu

PS : why omap driver use in omap_dev_ready GPMC*IRQ_STATUS instead of G=
PMC_STATUS.

PS2 : ecc hamming look strange. Weird isEccFF code. Doesn't seem to han=
dle bit
flip in ecc.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
