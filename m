From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v10 10/10] mtd: nand: omap: remove selection of BCH
 ecc-scheme via KConfig
Date: Wed, 23 Oct 2013 11:13:53 -0300
Message-ID: <20131023141352.GG2458@localhost>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-11-git-send-email-pekon@ti.com>
 <20131023134450.GE2458@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA2A130@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46325 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751161Ab3JWONq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 10:13:46 -0400
Content-Disposition: inline
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2A130@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "tony@atomide.com" <tony@atomide.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kerne>

Pekon,

On Wed, Oct 23, 2013 at 01:55:58PM +0000, Gupta, Pekon wrote:
> >=20
> > I'm wondering how are you testing this in your SOC_AM33XX board (wh=
ich
> > is not ARCH_OMAP3). You probably have ARCH_OMAP3 always selected?
> >=20
> Yes, omap2plus_defconfig is a super set..
> arch/arm/configs/omap2plus_defconfig automatically enables ARCH_OMAP3=
=2E
>=20

Yes, but I always remove what I won't use to reduce build time.

And  now that you bring this issue. IMHO, the AM33xx family is going
to be more and more widely used, so maybe introducing an am33xx_defconf=
ig
makes sense.

Or is the trend to have the least possible amount of defconfigs?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
