From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v8 6/6] mtd: nand: omap: updated devm_xx for all resource
 allocation and free calls
Date: Fri, 11 Oct 2013 12:27:29 -0700
Message-ID: <CAN8TOE9S63a1YdtzS+urTGBoMqrhq83cXXEeGinvQi9=dyUX1Q@mail.gmail.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
	<1381498603-15715-7-git-send-email-pekon@ti.com>
	<20131011181515.GJ23337@ld-irv-0074.broadcom.com>
	<20131011182840.GW29913@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:56585 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab3JKT1a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 15:27:30 -0400
In-Reply-To: <20131011182840.GW29913@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pekon Gupta <pekon@ti.com>, Mark Rutland <mark.rutland@arm.com>, robherring2@gmail.com, "olof@lixom.net" <olof@lixom.net>, Artem Bityutskiy <dedekind1@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, bcousson@baylibre.com, Avinash Philip <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Oct 11, 2013 at 11:28 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Brian Norris <computersforpeace@gmail.com> [131011 11:23]:
>> Hi Pekon,
>>
>> On Fri, Oct 11, 2013 at 07:06:43PM +0530, Pekon Gupta wrote:
>> > "Managed Device Resource" or devm_xx calls takes care of automatic freeing
>> > of the resource in case of:
>> > - failure during driver probe
>> > - failure during resource allocation
>> > - detaching or unloading of driver module (rmmod)
>> > Reference: Documentation/driver-model/devres.txt
>> >
>> > Though OMAP NAND driver handles freeing of resource allocation in most of
>> > the cases, but using devm_xx provides more clean and effortless approach
>> > to handle all such cases.
>>
>> Judging by your patch, I think you missed the point of the devm_*
>> managed functions. They are useful because you don't need to do any of
>> the cleanup (kfree(), iounmap(), etc.) yourself. I'll note the changes
>> that are necessary below, but seeing as this is an add-on to your patch
>> series, I may merge the rest of series without this, and if so, you can
>> just resubmit this patch separately.
>
> FYI, the .dts changes should be queued separately by Benoit to avoid
> pointless merge conflicts. The arch/arm/mach-omap2/gpmc.c changes I
> need to look, hopefully I can ack those for you today so you can take
> the code related changes into the MTD tree.

Why are you replying to this patch, instead of the DTS?

Also, I don't think all of this code is ready. There are several
comments from weeks ago that Pekon hasn't addressed. It's possible the
DT binding changes can go in, but not some of the later patches, yet.

Brian
