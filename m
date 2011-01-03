From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Mon, 3 Jan 2011 17:19:45 +0000
Message-ID: <20110103171945.GA3839@n2100.arm.linux.org.uk>
References: <201005152214.53993.sshtylyov@ru.mvista.com> <4D21F3F2.6090302@mvista.com> <20110103163447.GB2911@n2100.arm.linux.org.uk> <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com> <4D220246.5020303@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56013 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203Ab1ACRT6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 12:19:58 -0500
Content-Disposition: inline
In-Reply-To: <4D220246.5020303@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>

On Mon, Jan 03, 2011 at 08:07:18PM +0300, Sergei Shtylyov wrote:
> Hello.
>
> On 03-01-2011 20:01, Gupta, Ajay Kumar wrote:
>
>>>>> Add support for Texas Instuments Communication Port Programming Interface 4.1
>>>>> (CPPI 4.1) used on OMAP-L1x/DA8xx and AM35x.
>
>>>>> At this moment, only the DMA controller and queue manager are supported.
>>>>> Support for the buffer manager is lacking but these chips don't have it anyway.
>
>>>>> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>>>>> Signed-off-by: Sekhar Nori<nsekhar@ti.com>
>
>>>>     Russell, you have recently discarded this patch from your patch
>>>> system. Can we know the reason?
>
>>> It was recently discussed with TI, and various people raised concerns
>>> about it.  I don't remember the exact details, and I wish they'd raise
>>> them with the patch author directly.  It may have been that it's
>>> inventing its own API rather than using something like the DMA engine
>>> API.
>
>>> Adding linux-omap to try to get a response there.
>
>> Sergei,
>> This issue was discussed recently at TI and proposal was to place it to
>> drivers/dma folder.
>
>    Note that I have neither time nor inclination to do this work (not do 
> I think it's even feasible), so it will have to fall on TI's shoulders...
>
>> Moreover, even Felipe also seems to move other musb
>> DMAs (Inventra, CPPI3.0, TUSB) to drivers/dma.
>
>    Frankly speaking, I doubt that drivers/dma/ will have place for the 
> purely MUSB specific DMA engines such as the named ones (there's no TUSB 
> DMA BTW -- it uses OMAP DMA).

Long term, we need to kill off all these platform private DMA interfaces.
There's a growing amount of IP that's being shared not only between ARM
silicon vendors, but also across architectures, and having to re-implement
drivers because the underlying DMA engine is different is not feasible.

For example, we're seeing ARMs primecells being used with various
different DMA controllers in various different ARM SoCs.  I've heard
rumours of them appearing in MIPS or PPC stuff as well.  We're seeing
PXA peripheral IP appearing in x86 stuff too.

We can't have drivers tied to their SoC DMA engines, and we can't continue
having SoC DMA engines implementing their own unique APIs.  We do need to
get on top of this before it becomes a major problem (if it hasn't
already).

The DMA engine API is still evolving, and should not be taken as concrete
- I've recently been bringing up a number of points with Dan on various
aspects of the API, some of which ultimately will lead to changes to the
async-tx API, and others which hopefully will mean that the DMA slave
API is better documented.
