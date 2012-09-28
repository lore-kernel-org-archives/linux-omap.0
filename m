From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP: DMA: Move plat/dma hearder to platform_data/dma-omap
Date: Fri, 28 Sep 2012 14:35:19 -0500
Message-ID: <5065FBF7.2030704@ti.com>
References: <1348839609-10456-1-git-send-email-lokeshvutla@ti.com> <1348839609-10456-3-git-send-email-lokeshvutla@ti.com> <20120928145459.GZ4840@atomide.com> <CAMQu2gw9DJSZ4QVvo83atTpnsXyegneuQ2rJKBc+5ioiwEaqaQ@mail.gmail.com> <20120928150538.GB4840@atomide.com> <20120928155443.GA15246@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60847 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030587Ab2I1Tf1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Sep 2012 15:35:27 -0400
In-Reply-To: <20120928155443.GA15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 09/28/2012 10:54 AM, Russell King - ARM Linux wrote:
> On Fri, Sep 28, 2012 at 08:05:38AM -0700, Tony Lindgren wrote:
>> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120928 08:02]:
>>> On Fri, Sep 28, 2012 at 8:25 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>>
>>>> * Lokesh Vutla <lokeshvutla@ti.com> [120928 06:41]:
>>>>> Move plat/dma.h header to platform_data/dma-omap.h as
>>>>> part of the single zImage work.
>>>>
>>>> Hmm there's no platform data in this header, just
>>>> exported things for drivers to use. So it should not
>>>> be placed into platform_data.
>>>>
>>>> Maybe it should be #include <asm/mach/dma-omap.h> for now?
>>>>
>>> I wasn't sure either when the file was placed under platform-data.
>>> I agree for now we can keep it mach layer but than means OMAP1 and
>>> OMAP2+ DMA header and source code needs to be split. That
>>> is not so straight forward.
>>
>> No need for that, the path I'm suggesting is located under
>> arch/arm/include/asm/mach, it's not same as include <mach/dma-omap.h>.
>>  
>>> With DMA engine conversion hopefully, we might get rid of the
>>> header eventually, but for now not sure whether we should
>>> go ahead and follow the splitting part.
>>>
>>> Thoughts ?
>>
>> No need for splitting anything :)
>>
>> The other possible location would be just include <linux/dma-omap.h>,
>> but as we all know that will be going away, <asm/mach/dma-omap.h>
>> is probably better.
> 
> No, not asm/mach/anything, please.  Let's try to get headers into the
> right place second time around.
> 
> This header appears to contain:
> 
> 1. definitions for DMA signals, used by drivers.
> 
>    This can be eliminated by using DT, platform data, or IORESOURCE_DMA
>    (that's in preference order) which then means that these definitions
>    can live in a header file in arch/arm/mach-omap*/ if at all.
> 
> 2. data definitions and structures used by drivers using the legacy OMAP
>    DMA API.
> 
> So, it doesn't contain platform data (as said above).  It's not an
> API definition between core ARM code and ARM platform code, so that
> rules out arch/arm/include/asm/mach.  Obviously arch/arm/include/asm
> is out of the question too.
> 
> I don't think we have a clear cut place for this to live - and lets
> be clear that this file will eventually be going away _anyway_ when
> OMAP is converted 100% to DMA engine.
> 
> So, where to put the file?  At the moment, I don't know, it doesn't
> seem to have an obvious home other than where it currently is, which
> then gets in the way of the single kernel work.

I am having the same problem with the OMAP dmtimer platform driver that
the legacy DMA driver has. It is slightly worse as currently it is pure
custom platform driver. Obviously long-term it would be best to create a
generic timer driver in drivers/timer/ that other devices and
architectures could use but we are a long way from that.

I know that this is ugly and has probably already been shot-down, but as
a short-term fix, has creating arch/arm/plat-omap/include/plat-omap been
NAK'ed for such problematic drivers?

Cheers
Jon
