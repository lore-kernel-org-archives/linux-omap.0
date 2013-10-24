From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v10 10/10] mtd: nand: omap: remove selection of BCH
 ecc-scheme via KConfig
Date: Thu, 24 Oct 2013 21:49:09 +0200
Message-ID: <CAAwP0s0M=KruCVUana+5Nfm-0nkMGTg1OAatKzCrDeHOXuqd6A@mail.gmail.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-11-git-send-email-pekon@ti.com> <20131023134450.GE2458@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA2A130@DBDE04.ent.ti.com> <20131023141352.GG2458@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:62196 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab3JXTta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 15:49:30 -0400
In-Reply-To: <20131023141352.GG2458@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "tony@atomide.com" <tony@atomide.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, linux-omap@vger.ke

Hi Ezequiel

On Wed, Oct 23, 2013 at 4:13 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Pekon,
>
> On Wed, Oct 23, 2013 at 01:55:58PM +0000, Gupta, Pekon wrote:
>> >
>> > I'm wondering how are you testing this in your SOC_AM33XX board (w=
hich
>> > is not ARCH_OMAP3). You probably have ARCH_OMAP3 always selected?
>> >
>> Yes, omap2plus_defconfig is a super set..
>> arch/arm/configs/omap2plus_defconfig automatically enables ARCH_OMAP=
3.
>>
>
> Yes, but I always remove what I won't use to reduce build time.
>
> And  now that you bring this issue. IMHO, the AM33xx family is going
> to be more and more widely used, so maybe introducing an am33xx_defco=
nfig
> makes sense.
>
> Or is the trend to have the least possible amount of defconfigs?

I'm not familiar with AM33xx so I don't know how similar is to OMAP3
but we used to have different defconfigs for each OMAP board before
and consolidated everything in only two defconfigs: omap1_defconfig to
be used for all OMAP1 devices and omap2plus_defconfig to be used for
all OMAP2+ (i.e: OMAP{2,3,4,5}) devices.

Those have all the common kconfig options and board vendors can
customize to fit their needs and have a delta with something like:

$ ./scripts/kconfig/merge_config.sh
arch/arm/configs/omap2plus_defconfig /foo/bar/igep_defconfig

Again I'm not familiar with AM33xx but what I do know is that we
should keep defconfigs to a minimum.

> --
> Ezequiel Garc=C3=ADa, Free Electrons
> Embedded Linux, Kernel and Android Engineering
> http://free-electrons.com
> --

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
