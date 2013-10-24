From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v10 04/10] mtd: nand: omap: fix device scan:
 NAND_CMD_READID, NAND_CMD_RESET, CMD_CMD_PARAM use only x8 bus
Date: Thu, 24 Oct 2013 10:07:04 -0300
Message-ID: <20131024130703.GA9958@localhost>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-5-git-send-email-pekon@ti.com>
 <20131022201624.GL23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA29DB8@DBDE04.ent.ti.com>
 <5267690C.9080005@gmail.com>
 <20131023125516.GA2458@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA2A0CB@DBDE04.ent.ti.com>
 <20131023132457.GD2458@localhost>
 <20131023144652.GI2458@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA2A783@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50533 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754375Ab3JXNHP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 09:07:15 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2A783@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "tony@atomide.com" <tony@atomide.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "olof@lixom.net" <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, dwmw2@i

Pekon,

On Thu, Oct 24, 2013 at 12:59:26PM +0000, Gupta, Pekon wrote:
> Hi Ezequiel,
>=20
> > From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> > I won't be able to make too much progress without some help or with=
out
> > squeezing my brains out :P
> >=20
> > Care to push some git branch on some random repo with DT support fo=
r
> > the NAND cape in the Beaglebone?
> >=20
> Apologies for delay, I was testing and preparing a newer version of p=
atch-set..
>=20
> Please find the beagle-bone DTS attached. However, consider this as R=
=46C
> only, as I'm waiting for current series which has some DT-binding upd=
ates
> to get accepted first.
>=20
> Commit log in the patch would also guide you for some board tweaks
> for enabling NAND cape on beagle-bone (LT/white)..
> (I have recently sent v11 of the patch series incorporating last few
>  comments from Brian about nand_scan_ident().)
>=20

Thanks! I'll give this a try.

Anyway, for future reference, it's really easier for testers and
reviewers to just push the code in some public git repo (github? gitori=
ous?).

This way I don't have to apply the patches from my mailbox,
but just checkout a branch...
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
