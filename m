From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 0/5] Assorted OMAP2 NAND clean-ups
Date: Fri, 25 Oct 2013 08:48:37 -0300
Message-ID: <20131025114836.GD2489@localhost>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA2AE2A@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54689 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753142Ab3JYLsn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 07:48:43 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2AE2A@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pekon,

On Fri, Oct 25, 2013 at 11:15:57AM +0000, Gupta, Pekon wrote:
> Hi,
>=20
> > -----Original Message-----
> > From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> [...]
>=20
> > Pekon, Brian: Do you think this solution might work for 8-bit and 1=
6-bit
> > devices?
> >=20
> I think NAND_BUSWIDTH_AUTO (without GPMC changes) would fail in
> following scenarios..
>=20
> Case-1: configuring gpmc,device-width=3D1 from DT when using x16 devi=
ce.

=2E.. which is wrong. That's why we have a DT property to configure tha=
t.
The GPMC *must* be properly configured.

> As your NAND driver is using NAND_BUSWIDTH_AUTO, it should
> ignore this DT config, and based on ONFI params it should work as x16
>=20

Hm.. I don't think so. The auto-stuff is just for the NAND driver, not
for the memory controller. I don't know much about hardware, but in my =
mind
I imagine them as different controllers.

> Case-2: configuring gpmc,device-width=3D2 from DT when using x8 devic=
e.

=2E.. which is also wrong.

Once again, you're mis-configuring the GPMC. We cannot expect the NAND
driver to work properly if the GPMC is not properly initialized, don't
you think?

> Actually having NAND_BUSWIDTH_AUTO would require change in GPMC
> driver also.. please refer my comments in..=20
> http://lists.infradead.org/pipermail/linux-mtd/2013-October/049284.ht=
ml
>=20

Well, I think the approach should be different and much simpler: GPMC
*must* be properly configured and then NAND can do ONFI detection
starting in 8-bit and then switching to 16-bit if needed.

This is what this patch is doing: it _fixes_ the NAND driver ONFI detec=
tion,
_provided_ the GPMC is well-prepared.

You seem to think that GPMC + NAND should be able to automagically dete=
ct
the device and work, but I don't think that's even physically possible,=
 for
the reasons you have just exposed.

I think this fix is simple enough.

BTW: The GPMC code ignores the DT value in 'gpmc,device-width' and uses
'nand-bus-width' instead, but that's a different bug and a different fi=
x :)
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
