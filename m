From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v8 6/6] mtd: nand: omap: updated devm_xx for all resource
 allocation and free calls
Date: Fri, 11 Oct 2013 15:14:43 -0700
Message-ID: <CAN8TOE-0e+7211_c-Ao6RwP22ttKLSfVS54RQjHBiQxFtwS6PQ@mail.gmail.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
	<1381498603-15715-7-git-send-email-pekon@ti.com>
	<20131011181515.GJ23337@ld-irv-0074.broadcom.com>
	<20131011182840.GW29913@atomide.com>
	<CAN8TOE9S63a1YdtzS+urTGBoMqrhq83cXXEeGinvQi9=dyUX1Q@mail.gmail.com>
	<20131011214653.GA29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50801 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab3JKWOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 18:14:44 -0400
In-Reply-To: <20131011214653.GA29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pekon Gupta <pekon@ti.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robherring2@gmail.com>, "olof@lixom.net" <olof@lixom.net>, Artem Bityutskiy <dedekind1@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Benoit Cousson <bcousson@baylibre.com>, Avinash Philip <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Oct 11, 2013 at 2:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Brian Norris <computersforpeace@gmail.com> [131011 12:35]:
>> On Fri, Oct 11, 2013 at 11:28 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > FYI, the .dts changes should be queued separately by Benoit to avoid
>> > pointless merge conflicts. The arch/arm/mach-omap2/gpmc.c changes I
>> > need to look, hopefully I can ack those for you today so you can take
>> > the code related changes into the MTD tree.
>>
>> Why are you replying to this patch, instead of the DTS?
>
> Because you said you might merrge some parts of the series and I've
> seen many merge cycles of pointless merge conflicts with driver
> maintainers merging .dts files along with the driver changes? :)

Sure, thanks for pointing this out. I may have fallen into that myself.

> Pekon, can please post the .dts changes entirely separately from
> the driver changes in the future?
>
>> Also, I don't think all of this code is ready. There are several
>> comments from weeks ago that Pekon hasn't addressed. It's possible the
>> DT binding changes can go in, but not some of the later patches, yet.
>
> Yes that's up to you. I have not looked at the MTD parts and I
> appreciate the fact that you are reviewing that stuff. I've acked
> the arch/arm/*omap* parts so hopefully I'm out of the loop now.

Yes, I think so. The MTD stuff is the only remaining weak point I see.

Brian
