From: Paul Barker <paul@paulbarker.me.uk>
Subject: Re: McBSP functions not exported
Date: Fri, 11 Jan 2013 16:27:02 +0000
Message-ID: <ebad79c2234bac82958b7a1deea3ae55@localhost>
References: <20130111114846.00005679@unknown> <50F010CF.8020808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:60638 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754949Ab3AKQdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jan 2013 11:33:37 -0500
Received: from mail176.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id B25B5FFBA00
	for <linux-omap@vger.kernel.org>; Fri, 11 Jan 2013 17:40:23 +0100 (CET)
In-Reply-To: <50F010CF.8020808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On 2013-01-11 13:17, Peter Ujfalusi wrote:
> Hi,
>
> On 01/11/2013 12:48 PM, Paul Barker wrote:
>> Hi,
>>
>> I'm currently working on a driver to talk to an analog-to-digital
>> converter (specifically a Texas Instruments ADS1672) connected to 
>> the
>> McBSP port on a Beagleboard-xM. I'm currently building my driver 
>> module
>> against a 3.2 series kernel with Beagleboard patches and config from
>> https://github.com/beagleboard/kernel (branch beagleboard-3.2). I'd
>> like to keep up-to-date with the more recent kernels but my module
>> won't compile with them.
>>
>> When the OMAP McBSP driver stack was merged into a single driver
>> (commit 45656b4 by Peter Ujfalusi, looks like it went into linux 
>> 3.3)
>> all the EXPORT_SYMBOL macros were removed so I can no longer call 
>> the
>> functions I was using from my external module. Alternatively I could
>> just be missing something really obvious, let me know if I am!
>
> Since 3.3 there were even more changes in the McBSP driver stack. We 
> (I) did
> removed lot's of code and it is more focused on it's main
> functionality (ASoC).
> What functions you were using from the McBSP driver(s)?

I'm just using the request, free, start, stop and config functions, 
then
using DMA to copy data.

>> I'm just wondering what the best way forward is from here and I'm 
>> sure
>> I can't be the only person who was using the McBSP driver code in 
>> the
>> kernel to interface with external hardware. The two options I can 
>> think
>> of are either that I move my driver into the kernel source tree 
>> itself
>> or the McBSP driver functions are exported again so that they can be
>> used by external modules. It's easier to maintain an external module
>> than a series of patches against the kernel, unless a driver for an
>> analog-to-digital converter connected to the McBSP port is something
>> that would actually have a chance of being merged into the mainline
>> kernel. I could look at making this driver more generic once I have 
>> the
>> current hardware/driver combination working, so that it should work
>> with most analog-to-digital converters - I haven't found such a 
>> driver
>> in my previous googling.
>
> I have taken a brief look at ADS1672 datasheet. At first glance I 
> would think
> that if you connect the ADC to SPI port of OMAP3 you should be able 
> to read
> the data out as well. On BeagleBoard-xM you should have access to
> McSPI3 (CS0,
> CS1) and McSPI4 (CS0).

I've just been having a look at the McSPI interface and SPI code in the 
kernel.
I can see how to wire this up, use the processor as SPI master and the 
ADC as
SPI slave, get the clock running, etc. I need the transfers to be 
synchronised
to the data ready signal from the ADC, or I need them to occur at a 
guaranteed
frequency. I can't see how to do either of these with the SPI interface 
provided
by <linux/spi/spi.h>, so looks like I'd have to interface directly with 
the
McSPI hardware. I'll have a bash around, try to get some advice from 
the
beagleboard@googlegroups.com list and see what I can come up with as I 
think
that's a bit off topic for this list.

>> If you have any advice on this or a pointer to a better place to ask
>> this question please let me know.
>
> Can you try to see if you can use McSPI for your application?
>
> As background: we did not had any other uses of McBSP when I have 
> decided to
> merge the code and move it out from arch/arm/plat-omap/ This was 
> needed to be
> done in any ways. The decision back then was that since we don't have 
> users
> for McBSP other than audio, it is going to be moved under 
> sound/soc/omap/

This makes sense. The only other benefit I can see from exporting the 
McBSP
functions again is that audio drivers for custom boards based on OMAP 
processors
could then be written as external modules. That's not really what I'm 
doing here
though.

Cheers,

Paul Barker
