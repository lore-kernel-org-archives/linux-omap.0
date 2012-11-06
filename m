From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] omap3 nand : use NAND_BUSWIDTH_AUTO
Date: Tue, 6 Nov 2012 10:40:20 -0800
Message-ID: <20121106184019.GI6801@atomide.com>
References: <1352199105-30215-1-git-send-email-matthieu.castet@parrot.com>
 <1352199105-30215-3-git-send-email-matthieu.castet@parrot.com>
 <50990473.2090300@compulab.co.il>
 <50993F16.8070908@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28846 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750855Ab2KFSkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 13:40:25 -0500
Content-Disposition: inline
In-Reply-To: <50993F16.8070908@parrot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dedekind1@gmail.com" <dedekind1@gmail.com>, Afzal Mohammed <afzal@ti.com>

* Matthieu CASTET <matthieu.castet@parrot.com> [121106 08:49]:
> Igor Grinberg a =C3=A9crit :
> > Cc: Tony Lindgren, Afzal Mohammed,
> >=20
> > On 11/06/12 12:51, Matthieu CASTET wrote:
> >> This allow to clean the omap nand driver that were trying in x8 an=
d x16 bits mode.
> >>
> >> This also make work onfi detection on beagleboard :
> >>
> >> Before :
> >> [    1.954803] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (=
Micron NAND 256MiB 1,8V 16-bit), page size: 2048, OOB size: 64
> >>
> >> After :
> >> [    1.914825] ONFI param page 0 valid
> >> [    1.919158] ONFI flash detected
> >> [    1.922515] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (=
Micron MT29F2G16ABD), page size: 2048, OOB size: 64
> >>
> >> platform data devsize is renamed bussize. It now indicate the maxi=
mun size of the nand bus.
> >>
> >> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>
> >=20
> > I think, you should base on one of Tony's branches with that kind o=
f patches.
> > Because, for example the omap_nand_flash_init() function does not e=
xist anymore
> > in Tony's master and may be several more things will need to have a=
djustments.
> > Also, the GPMC related stuff inside the NAND driver
> > should probably be coordinated with Afzal, as he is reworking the w=
hole
> > GPMC related code.
>=20
> Thanks for the info.
>=20
> Where such tree could be found ?

You should be able to use omap-for-v3.8/cleanup-headers-gpmc
branch as a base for your patches [1].

Eventually once when we're done with all the clean up, the MTD
driver should be completely separated from the core omap code
and I'll be out of the way.

Regards,

Tony

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap.git;a=
=3Dshortlog;h=3Drefs/heads/omap-for-v3.8/cleanup-headers-gpmc
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
