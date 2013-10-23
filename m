From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v10 04/10] mtd: nand: omap: fix device scan:
 NAND_CMD_READID, NAND_CMD_RESET, CMD_CMD_PARAM use only x8 bus
Date: Wed, 23 Oct 2013 09:55:17 -0300
Message-ID: <20131023125516.GA2458@localhost>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-5-git-send-email-pekon@ti.com>
 <20131022201624.GL23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA29DB8@DBDE04.ent.ti.com>
 <5267690C.9080005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:45917 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753396Ab3JWMy6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 08:54:58 -0400
Content-Disposition: inline
In-Reply-To: <5267690C.9080005@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "tony@atomide.com" <tony@atomide.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "olof@lixom.net" <olof@lixom.net>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, dwmw2@infradead.org

Brian,

On Tue, Oct 22, 2013 at 11:13:32PM -0700, Brian Norris wrote:
> On 10/22/2013 10:07 PM, Gupta, Pekon wrote:
> >> From: Brian Norris [mailto:computersforpeace@gmail.com]
> >> On Sat, Oct 19, 2013 at 02:14:08PM +0530, Pekon Gupta wrote:
> > [...]
> >=20
> >>>
> >>> Thus this patch run nand_scan_ident() with driver configured as x=
8 device.
> >>
> >> So are you saying that the driver currently doesn't work if you st=
arted
> >> in x16 buswidth? Are you having problems with a particular setup? =
What
> >> sort of devices are you testing?
> >>
> > No, I'm saying that you cannot read ONFI params in x16 mode.
> > And, that is what was pointed out in following commit log also ..
> > (Reference to 3.3.2. Target Initialization: given above)
> > So, if I run nand_scan_ident() in x16 mode, my ONFI detection would=
=20
> > fail for sure ..
>=20
> But you cannot just run nand_scan_ident() with !(chip->options &
> NAND_BUSWIDTH_16) when your devices is x16. You need to solve the ONF=
I
> detection problem while correctly specifying NAND_BUSWIDTH_16.
>=20
> Since you didn't answer the other 2 questions there: are you testing =
any
> x16 devices?
>=20

I'm jumping on this thread without having read all the discussion, sorr=
y
about that.

=46WIW, I have a Beaglebone with a 16-bit bus NAND attached to it.

Coincidentally, yesterday I was doing some tests as I'm ramping up the
NAND and I found that weird double nand_scan_ident() call.
The whole thing looks buggy to me, so I'm happy to help, review, test
and patches to take care of this.

I'm using some TI SDK with some ancient v3.2.x (with no git history!),
but from this discussion it seems the issue is still present in
mainline.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
