From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v10 10/10] mtd: nand: omap: remove selection of BCH
 ecc-scheme via KConfig
Date: Thu, 24 Oct 2013 17:05:57 -0300
Message-ID: <20131024200556.GA2520@localhost>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-11-git-send-email-pekon@ti.com>
 <20131023134450.GE2458@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA2A130@DBDE04.ent.ti.com>
 <20131023141352.GG2458@localhost>
 <CAAwP0s0M=KruCVUana+5Nfm-0nkMGTg1OAatKzCrDeHOXuqd6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52241 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755925Ab3JXUGI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 16:06:08 -0400
Content-Disposition: inline
In-Reply-To: <CAAwP0s0M=KruCVUana+5Nfm-0nkMGTg1OAatKzCrDeHOXuqd6A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "tony@atomide.com" <tony@atomide.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, linux-omap@vger.ke

Javier,

On Thu, Oct 24, 2013 at 09:49:09PM +0200, Javier Martinez Canillas wrot=
e:
> Hi Ezequiel
>=20
> On Wed, Oct 23, 2013 at 4:13 PM, Ezequiel Garcia
> <ezequiel.garcia@free-electrons.com> wrote:
> > Pekon,
> >
> > On Wed, Oct 23, 2013 at 01:55:58PM +0000, Gupta, Pekon wrote:
> >> >
> >> > I'm wondering how are you testing this in your SOC_AM33XX board =
(which
> >> > is not ARCH_OMAP3). You probably have ARCH_OMAP3 always selected=
?
> >> >
> >> Yes, omap2plus_defconfig is a super set..
> >> arch/arm/configs/omap2plus_defconfig automatically enables ARCH_OM=
AP3.
> >>
> >
> > Yes, but I always remove what I won't use to reduce build time.
> >
> > And  now that you bring this issue. IMHO, the AM33xx family is goin=
g
> > to be more and more widely used, so maybe introducing an am33xx_def=
config
> > makes sense.
> >
> > Or is the trend to have the least possible amount of defconfigs?
>=20
> I'm not familiar with AM33xx so I don't know how similar is to OMAP3
> but we used to have different defconfigs for each OMAP board before
> and consolidated everything in only two defconfigs: omap1_defconfig t=
o
> be used for all OMAP1 devices and omap2plus_defconfig to be used for
> all OMAP2+ (i.e: OMAP{2,3,4,5}) devices.
>=20
> Those have all the common kconfig options and board vendors can
> customize to fit their needs and have a delta with something like:
>=20
> $ ./scripts/kconfig/merge_config.sh
> arch/arm/configs/omap2plus_defconfig /foo/bar/igep_defconfig
>=20
> Again I'm not familiar with AM33xx but what I do know is that we
> should keep defconfigs to a minimum.
>=20

=46air enough.

It's just a bit annoying to have a bigger-than-minimal kernel,
and I get tired of stripping the options.

But I can't ask the kernel to hold my favorite picks either:
we have enough churn already ;-)
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
