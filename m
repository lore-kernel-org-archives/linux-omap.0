From: Philip Balister <philip@balister.org>
Subject: Re: DMA example
Date: Wed, 24 Feb 2010 18:24:13 -0800
Message-ID: <4B85DF4D.9020007@balister.org>
References: <4B857F2F.7000201@balister.org> <20100224203555.GT28173@atomide.com> <4B85A8AD.5060206@balister.org> <20100224225231.GA28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:22876 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758760Ab0BYCYS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Feb 2010 21:24:18 -0500
In-Reply-To: <20100224225231.GA28173@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 02/24/2010 02:52 PM, Tony Lindgren wrote:
> * Philip Balister<philip@balister.org>  [100224 14:28]:
>> On 02/24/2010 12:35 PM, Tony Lindgren wrote:
>>> * Philip Balister<philip@balister.org>   [100224 11:31]:
>>>> I am trying to setup a dma operation to copy memory from GPMC
>>>> address space into RAM. The only examples using the omap-dma api use
>>>> hardware triggers.
>>>>
>>>> When I start a transfer, I end up with a DMA transaction error when
>>>> I start the transfer.
>>>>
>>>> Does anyone have a good example of a software transfer? Currently, I
>>>> am tracing the omap dma api to see how things map into the registers
>>>> ....
>>>
>>> Enjoy the GPMC timings. I recommend attaching a logic analyzer there
>>> to verify the things are right for the key lines if you have chance.
>>>
>>> Hmm I thought the hardware triggers were optional in at least
>>> drivers/usb/musb/tusb6010_omap.c.. Maybe I don't remember correctly.
>>
>> GPMC is easy :)
>
> Sounds like you just got lucky! :)

OK, I am using the 2K non-multiplexed mode atm :) Still I have a logic 
analyzer and am confident I can get the mux'd modes working. Burst is 
still a bit scary.

>> Basically, I have a device attached to a GPMC chip select and I need
>> to read/write to it. The GPNC bit is fine, we'd just like to use the
>> DMA controller to move the data.
>
> That should work, at least there has been several memory-to-memory
> dma test modules posted here over the years. Have you tried using
> OMAP_DMA_NO_DEVICE for omap_request_dma? Also search for omap dmatest
> or similar.

Thanks. This is suggesting I am on the right track, but the transfer 
still fails with: DMA transaction error with device 0.

The call to omap_set_dma_transfer_params adds these two args:

params->trigger, params->src_or_dst_synch);

I think they are more for hw synched transfers and set them to zero.

the src|dest param setting calls added the  params->src_ei, 
params->src_fi arguments. I've set these to 1.

Any more clues?

Philip
