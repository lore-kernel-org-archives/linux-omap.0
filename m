From: Alexander Kochetkov <al.kochet@gmail.com>
Subject: Re: [PATCH] i2c: omap: fix i207 errata handling
Date: Fri, 21 Nov 2014 03:29:40 +0300
Message-ID: <089B5BDA-682D-46B6-869F-A6ADDFE691C3@gmail.com>
References: <1416529011-21803-1-git-send-email-al.kochet@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416529011-21803-1-git-send-email-al.kochet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kochetkov <al.kochet@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

21 =CE=CF=D1=C2. 2014 =C7., =D7 3:16, Alexander Kochetkov <al.kochet@gm=
ail.com> =CE=C1=D0=C9=D3=C1=CC(=C1):

> commit 6d9939f651419a63e091105663821f9c7d3fec37 (i2c: omap: split out=
 [XR]DR
> and [XR]RDY) changed the way how errata i207 (I2C: RDR Flag May Be In=
correctly
> Set) get handled.

It's is seen if open 6d9939f651419a63e09^ and 6d9939f651419a63e09 side =
by side:

6d9939f651419a63e09^:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/i2c/busses/i2c-omap.c?id=3D540a4790f7da0d3ca5ad9d726f198a5eb4db05=
ec#n800

6d9939f651419a63e09:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/dr=
ivers/i2c/busses/i2c-omap.c?id=3D6d9939f651419a63e091105663821f9c7d3fec=
37#n800

Errata "2C: RDR Flag May Be Incorrectly Set"
http://www.ti.com/lit/er/sprz319f/sprz319f.pdf

21 =CE=CF=D1=C2. 2014 =C7., =D7 3:16, Alexander Kochetkov <al.kochet@gm=
ail.com> =CE=C1=D0=C9=D3=C1=CC(=C1):

> Found by code review. Real impact haven't seen.
> Tested on Beagleboard XM C.

Does anybody know the "certain rare conditions" when RDR errata appears=
?
I tested without luck (Beagleboard XM C).
