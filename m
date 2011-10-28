From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [RFC] Change ECC algorithm from userspace
Date: Fri, 28 Oct 2011 12:40:03 +0200
Message-ID: <4EAA8683.4080202@parrot.com>
References: <70E876B0EA86DD4BAF101844BC814DFE0BF244FAD1@Cloud.RL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:39377 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762Ab1J1KkF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Oct 2011 06:40:05 -0400
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE0BF244FAD1@Cloud.RL.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Povey <Jon.Povey@racelogic.co.uk>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Jon Povey a =E9crit :
> linux-mtd-bounces@lists.infradead.org wrote:
>> I want to be able to use 1-bit ECC for the first partition where I
>> save the loader binary and has to be accessed by the ROM boot but us=
e
>> a 4-bit ECC for my rootfs partition.
>>
>> Does anyone have this same issue?
>=20
> DM355 and DM365 has similar issues as the RBL expects a different OOB=
/ECC
> layout to Linux.
>=20
>> What is the best approach to store data in a NAND device using
>> different ECC techniques?
>=20
> What I have done is write a utility that calculates ECC and writes to
> the mtd device in RAW mode. So to rewrite the bootloader I take care =
of
> the ECC and layout at application level without changing the kernel.
>
Note that the kernel raw mode doesn't write the page in one time : it w=
rite data
and then ecc. This may cause problem with NOP1 nand.

see http://lists.infradead.org/pipermail/linux-mtd/2010-August/031262.h=
tml


Matthieu
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
