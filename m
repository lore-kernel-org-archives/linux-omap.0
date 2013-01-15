From: Paul Barker <paul@paulbarker.me.uk>
Subject: Re: McBSP functions not exported
Date: Tue, 15 Jan 2013 17:43:54 +0000
Message-ID: <f358e8045003700c83717ce3f7bc1932@localhost>
References: <20130111114846.00005679@unknown> <50F010CF.8020808@ti.com>
 <ebad79c2234bac82958b7a1deea3ae55@localhost> <50F3C648.60101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:33302 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750993Ab3AOTi2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jan 2013 14:38:28 -0500
Received: from mail176.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 26D44FF9D66
	for <linux-omap@vger.kernel.org>; Tue, 15 Jan 2013 18:57:25 +0100 (CET)
In-Reply-To: <50F3C648.60101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

Hi,

On 2013-01-14 08:48, Peter Ujfalusi wrote:
> On 01/11/2013 05:27 PM, Paul Barker wrote:
>>
>> <snip>
>>
>> I've just been having a look at the McSPI interface and SPI code in 
>> the kernel.
>> I can see how to wire this up, use the processor as SPI master and 
>> the ADC as
>> SPI slave, get the clock running, etc. I need the transfers to be 
>> synchronised
>> to the data ready signal from the ADC, or I need them to occur at a 
>> guaranteed
>> frequency. I can't see how to do either of these with the SPI 
>> interface provided
>> by <linux/spi/spi.h>, so looks like I'd have to interface directly 
>> with the
>> McSPI hardware. I'll have a bash around, try to get some advice from 
>> the
>> beagleboard@googlegroups.com list and see what I can come up with as 
>> I think
>> that's a bit off topic for this list.
>
> Naturally you would use the data ready line as interrupt source for 
> your
> driver. When you receive the interrupt you would issue a read via SPI 
> to get
> the result from the chip.
>

I've written a quick driver which issues SPI reads in response to 
hrtimer events
to see if this is possible. I'm getting a rough average latency of 
100us between
calling spi_async() and the clock signal changing. This is no use for 
reading a
single sample at a time at a rate of 625kHz. Even ignoring this 
problem, I
imagine there would be at least a few microseconds of latency between a 
GPIO pin
changing and an interrupt handler being executed by the kernel. My 
transfer
takes 1us and I have a new data word every 1.6us. So I think issuing 
single SPI
read requests each time I get an interrupt isn't going to work for me.

With the hrtimer interval set to 1.6us my board completely locks up 
(probably
has no free time to handle anything else). I don't think Linux was 
designed to
respond to these sorts of requests in real-time. I need to offload this 
to the
DMA system, but I can't see any way to do that (with a 600ns gap 
between
transfers) using the Linux SPI API.

>
> I don't see how it could help custom boards. For audio all boards can 
> just
> happily use the McBSP stack + omap-pcm. It could help with boards 
> where the
> McBSP is not used for audio. But I think those users could use McSPI 
> instead
> of McBSP for their needs.
>
> As a sidenote: The support for SPI like protocols in McBSP only 
> existed on
> OMAP1 where we had a stop clocks possibility. In all latest versions 
> of OMAP
> removed this possibility and McBSP officially only supports I2S, PCM, 
> TDM
> protocols. This was another reason to move the McBSP under sound.

The ADS1672 shouldn't care if the clock stops or not, it has the 
ability to
output its own clock signal and that runs continuously.

My understanding of the McBSP using DMA is that a read would be issued 
as soon
as a frame sync pulse is detected, with no processor involvement, and I 
can get
an interrupt from the DMA controller once every few thousand samples or 
so and
so the OS can just get on with running in the meantime. It looks like 
that is
what I need to happen here.

I'm going to go back to using kernel 3.2 and check that this actually 
works
with the McBSP. If it does, how much hassle is it to export the 
required symbols
in more recent kernels? I'll happily write the patch, I just don't want 
to
introduce too much more maintenance overhead going forward.

Thanks,

Paul Barker
