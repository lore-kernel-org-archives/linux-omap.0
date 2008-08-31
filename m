From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 22/33] add omap nand drivers
Date: Mon, 1 Sep 2008 00:28:45 +0300
Message-ID: <20080831212842.GF9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-22-git-send-email-me@felipebalbi.com> <1220116593-862-23-git-send-email-me@felipebalbi.com> <200808311408.18492.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:32860 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758301AbYHaV3I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:29:08 -0400
Content-Disposition: inline
In-Reply-To: <200808311408.18492.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sun, Aug 31, 2008 at 02:08:18PM -0700, David Brownell wrote:
> Hmm, this seems like three distinct drivers to me.
> Which should mean three separate patches ... going
> go the MTD list!
>=20
>=20
> On Saturday 30 August 2008, Felipe Balbi wrote:
> >=20
> > +config MTD_NAND_OMAP2
> > +=A0=A0=A0=A0=A0=A0=A0tristate "NAND Flash device on OMAP2 and OMAP=
3"
> > +=A0=A0=A0=A0=A0=A0=A0depends on ARM && MTD_NAND && (ARCH_OMAP2 || =
ARCH_OMAP3)
> > +=A0=A0=A0=A0=A0=A0=A0help
> > + =A0 =A0 =A0 =A0 =A0Support for NAND flash on Texas Instruments OM=
AP2 and OMAP3 platforms.
>=20
> I've got a small patch for this one which I'll post.

Great, I can meld it on the final version of the driver. Thanks

> > +config MTD_NAND_OMAP
> > +=A0=A0=A0=A0=A0=A0=A0tristate "NAND Flash device on OMAP H3/H2/P2 =
boards"
> > +=A0=A0=A0=A0=A0=A0=A0depends on ARM && ARCH_OMAP1 && MTD_NAND && (=
MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_PERSEUS2)
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0 =A0Support for NAND flash on Texas Instrumen=
ts H3/H2/P2 platforms.
> > +
> > +config MTD_NAND_OMAP_HW
> > +=A0=A0=A0=A0=A0=A0=A0bool "OMAP HW NAND Flash controller support"
> > + =A0 =A0 =A0 =A0depends on ARM && ARCH_OMAP16XX && MTD_NAND
> > +
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0 =A0Driver for TI OMAP16xx hardware NAND flas=
h controller.
>=20
> This one raises the question:  why are there *TWO* drivers for
> the same hardware?  Which one is the failed experiment?

It's even worse. If you look at the Makefile itself, there are three:

obj-$(CONFIG_MTD_NAND_OMAP) 		+=3D omap-nand-flash.o
obj-$(CONFIG_MTD_NAND_OMAP2) 		+=3D omap2.o
obj-$(CONFIG_MTD_NAND_OMAP_HW)		+=3D omap-hw.o

Looks like this series was good for finding some weird stuff on
linux-omap ;-)

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
