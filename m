From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [RFC] Change ECC algorithm from userspace
Date: Fri, 28 Oct 2011 12:30:51 +0200
Message-ID: <4EAA845B.1020009@parrot.com>
References: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:52752 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772Ab1J1Ka4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Oct 2011 06:30:56 -0400
In-Reply-To: <CAAwP0s059H3BGhYbYLux2gR6ZNb+sFDue676OM2Evz5cA2q6DA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi,

Javier Martinez Canillas a =C3=A9crit :
> Hello,
>=20
> I want to be able to use 1-bit ECC for the first partition where I
> save the loader binary and has to be accessed by the ROM boot but use
> a 4-bit ECC for my rootfs partition.
>=20
> Does anyone have this same issue?
We use raw programming and compute the ecc in software.


>=20
> What is the best approach to store data in a NAND device using
> different ECC techniques?
>=20
> I've think of two approaches:
>=20
> 1- Adding an ioctl to mtdchar (something like ECCSETBITS) to change
> the ECC technique used.
But this won't work if there is concurrent acess to mtd. One program ma=
y want 1
bit ecc other want 4 bits ecc.

> 2- Use a platform data field to notify the omap2 nand driver that the
> ROM boot only supports 1-bit ECC. So it can use a 1-bit ECC to write
> and read the first 4 sectors but a 4-bit ECC for the rest.
This may be better.

Matthieu

PS : note that some OMAP ROM support a better protection than Hamming (=
but the
details are not public AFAIK)

=46rom OMAP34xx Multimedia Device, Silicon Revision 3.1.x, public versi=
on :

Pages can contain errors caused by memory alteration. To correct these =
errors,
the ROM code uses ECC,
based on Hamming codes for SLC NAND and BCH (Bose, Ray-Chaudhuri, Hocqu=
enghem)
code for
multilevel cell (MLC) devices. The computed ECC is compared to ECC stor=
ed in the
spare area of the
corresponding page. If there are uncorrectable errors, the ROM code ret=
urns with
=46AIL.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
