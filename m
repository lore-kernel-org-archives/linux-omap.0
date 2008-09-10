From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH 1/2]  McBSP DMA support for  34xx
Date: Wed, 10 Sep 2008 15:47:34 +0530
Message-ID: <0d7601c9132e$72d82100$LocalHost@wipultra806>
References: <51857.192.168.10.89.1219911960.squirrel@dbdmail.itg.ti.com> <20080828135202.657264e6.jarkko.nikula@nokia.com> <01fe01c90900$26f83320$LocalHost@wipultra806> <20080909163149.GO29054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42278 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbYIJKRv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Sep 2008 06:17:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "shekhar, chandra" <x0044955@ti.com>
Cc: "Jarkko Nikula" <jarkko.nikula@nokia.com>; <linux-omap@vger.kernel.org>
Sent: Tuesday, September 09, 2008 10:01 PM
Subject: Re: [PATCH 1/2] McBSP DMA support for 34xx


>* shekhar, chandra <x0044955@ti.com> [080828 04:21]:
>>
>> ----- Original Message ----- From: "Jarkko Nikula"
>> <jarkko.nikula@nokia.com>
>> To: "ext chandra shekhar" <x0044955@ti.com>
>> Cc: <linux-omap@vger.kernel.org>
>> Sent: Thursday, August 28, 2008 4:22 PM
>> Subject: Re: [PATCH 1/2] McBSP DMA support for 34xx
>>
>>
>>> On Thu, 28 Aug 2008 13:56:00 +0530 (IST)
>>> "ext chandra shekhar" <x0044955@ti.com> wrote:
>>>
>>>> This patch supports DMA chaining mode and one time configuration for
>>>> entire transfer to improve performance.
>>>> Signed-off-by: chandra shekhar <x0044955@ti.com>
>>>> ---
>>>>  arch/arm/mach-omap2/mcbsp.c       |  702 ++++++++++++++++++++++++++++
>>>> +++++++++- arch/arm/plat-omap/mcbsp.c        |   19 -
>>>>  include/asm-arm/arch-omap/mcbsp.h |  127 +++++-
>>>>  3 files changed, 811 insertions(+), 37 deletions(-)
>>>>
>>> Hi
>>>
>>> What's the expected use case for DMA chaining mode or existing driver
>>> which would get improved performance? There should have some reason why
>>> this amount of new lines should be added.
>>
>> current McBSP ( arch/arm/plat-omap/mcbsp.c) code request and releases dma
>> channel for each transfer .
>> so there is latency involved. Chaining help with smooth audio play
>> because we can enque the buffer
>> while another transfer is ongoing.
>
> But the omap ASoC does already circular dma that automatically loops back
> to the beginning of fifo as long as there's data. How would the chaining help
> with this?
>
> Maybe update your codec to work with omap ASoC and see if you still
> need chaining?
>

Yes, Codec driver can be modified to adapt OMAP ASoC.
but there are some additional features.

1> 16/24 bit mono and stereo data transfer
2>  Separate Rx and Tx path, enable only respective path.
3>  data transfer in 8,16,32 bit mode

Most importantly,
4> McBSP buffer ( To save power, for 34xx).
OMAP3430 McBSP interface 2 has 5k buffer for audio.  handling of this buffer 
should be specific to McBSP.

Apart from that this is a generic McBSP code which will not interrupt the ASoC 
functionality.

In OMAP ASoC code the channel is linked to itself , i am not sure about latency 
in that case, but if DMA channels are available
we can use chaining of two channels in ASoC. this might reduce latency.




>
>>
>>>
>>> Also ideally this should cover also OMAP1's from 16xx onward since they
>>> can link DMA channels together as well?
>>
>> Current code might even work for 16xx and later versions for 16 bit data.
>> ( or can be extended to work on 16xx and later versions)
>> but i dont have board or TRM to check for any changes in DMA subsytem or
>> McBSP. better to play safe.
>>
>> 2430 onwards McBSP dxr/drr is 32 bits, which allows 24 bit mono/stereo
>> transfer easily. if we had to have 16 bit dxr1,2/drr1,2
>> then we will have to perform the manipulation on data for 24 bit ops. we
>> will have to consider all the options before extending it to 16xx.
>>
>>>
>>>
>>> Jarkko
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

