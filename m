From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v2 0/5] Assorted OMAP2 NAND clean-ups
Date: Tue, 29 Oct 2013 14:12:10 -0300
Message-ID: <20131029171209.GA20207@localhost>
References: <1382696277-9063-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA2AE2A@DBDE04.ent.ti.com>
 <20131025114836.GD2489@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39943 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751243Ab3J2RMO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Oct 2013 13:12:14 -0400
Content-Disposition: inline
In-Reply-To: <20131025114836.GD2489@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "marek.belisko@gmail.com" <marek.belisko@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hey Pekon,

On Fri, Oct 25, 2013 at 08:48:36AM -0300, Ezequiel Garcia wrote:
> Pekon,
>=20
> On Fri, Oct 25, 2013 at 11:15:57AM +0000, Gupta, Pekon wrote:
> > Hi,
> >=20
> > > -----Original Message-----
> > > From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> > [...]
> >=20
> > > Pekon, Brian: Do you think this solution might work for 8-bit and=
 16-bit
> > > devices?
> > >=20
> > I think NAND_BUSWIDTH_AUTO (without GPMC changes) would fail in
> > following scenarios..
> >=20
> > Case-1: configuring gpmc,device-width=3D1 from DT when using x16 de=
vice.
>=20
> ... which is wrong. That's why we have a DT property to configure tha=
t.
> The GPMC *must* be properly configured.
>=20
> > As your NAND driver is using NAND_BUSWIDTH_AUTO, it should
> > ignore this DT config, and based on ONFI params it should work as x=
16
> >=20
>=20
> Hm.. I don't think so. The auto-stuff is just for the NAND driver, no=
t
> for the memory controller. I don't know much about hardware, but in m=
y mind
> I imagine them as different controllers.
>=20
> > Case-2: configuring gpmc,device-width=3D2 from DT when using x8 dev=
ice.
>=20
> ... which is also wrong.
>=20
> Once again, you're mis-configuring the GPMC. We cannot expect the NAN=
D
> driver to work properly if the GPMC is not properly initialized, don'=
t
> you think?
>=20
> > Actually having NAND_BUSWIDTH_AUTO would require change in GPMC
> > driver also.. please refer my comments in..=20
> > http://lists.infradead.org/pipermail/linux-mtd/2013-October/049284.=
html
> >=20
>=20
> Well, I think the approach should be different and much simpler: GPMC
> *must* be properly configured and then NAND can do ONFI detection
> starting in 8-bit and then switching to 16-bit if needed.
>=20
> This is what this patch is doing: it _fixes_ the NAND driver ONFI det=
ection,
> _provided_ the GPMC is well-prepared.
>=20
> You seem to think that GPMC + NAND should be able to automagically de=
tect
> the device and work, but I don't think that's even physically possibl=
e, for
> the reasons you have just exposed.
>=20

Sorry to insist: any comments about this?

If you have access to the AM335xEVM (which has an 8-bit NAND, as far as=
 I know)
and also to the Beaglebone 16-bit NAND cape, then you can test this pat=
chset
with all the different combinations: 8-bit vs. 16-bit and array-based v=
s.
ONFI-based detection.

If it works, then problem solved. If it doesn't, I'm sure we can find a
solution. The driver is currently buggy, so we need to address this soo=
ner
or later.

In addition, the outcome of our discussion will probably be helpful for=
 other
drivers/controllers, since this ONFI issue is likely to be common.

If you can do the testing, that would be great: keep in mind that the
GPMC must be correctly configured at all times. You can use my recent
GPMC patchset for that (which also need some testing).

Thanks in advance,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
