From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2]  McBSP DMA support for  34xx
Date: Tue, 9 Sep 2008 09:31:50 -0700
Message-ID: <20080909163149.GO29054@atomide.com>
References: <51857.192.168.10.89.1219911960.squirrel@dbdmail.itg.ti.com> <20080828135202.657264e6.jarkko.nikula@nokia.com> <01fe01c90900$26f83320$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53049 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbYIIQb4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 12:31:56 -0400
Content-Disposition: inline
In-Reply-To: <01fe01c90900$26f83320$LocalHost@wipultra806>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "shekhar, chandra" <x0044955@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

* shekhar, chandra <x0044955@ti.com> [080828 04:21]:
>
> ----- Original Message ----- From: "Jarkko Nikula" 
> <jarkko.nikula@nokia.com>
> To: "ext chandra shekhar" <x0044955@ti.com>
> Cc: <linux-omap@vger.kernel.org>
> Sent: Thursday, August 28, 2008 4:22 PM
> Subject: Re: [PATCH 1/2] McBSP DMA support for 34xx
>
>
>> On Thu, 28 Aug 2008 13:56:00 +0530 (IST)
>> "ext chandra shekhar" <x0044955@ti.com> wrote:
>>
>>> This patch supports DMA chaining mode and one time configuration for
>>> entire transfer to improve performance.
>>> Signed-off-by: chandra shekhar <x0044955@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/mcbsp.c       |  702 ++++++++++++++++++++++++++++
>>> +++++++++- arch/arm/plat-omap/mcbsp.c        |   19 -
>>>  include/asm-arm/arch-omap/mcbsp.h |  127 +++++-
>>>  3 files changed, 811 insertions(+), 37 deletions(-)
>>>
>> Hi
>>
>> What's the expected use case for DMA chaining mode or existing driver
>> which would get improved performance? There should have some reason why
>> this amount of new lines should be added.
>
> current McBSP ( arch/arm/plat-omap/mcbsp.c) code request and releases dma 
> channel for each transfer .
> so there is latency involved. Chaining help with smooth audio play 
> because we can enque the buffer
> while another transfer is ongoing.

But the omap ASoC does already circular dma that automatically loops back
to the beginning of fifo as long as there's data. How would the chaining help
with this?

Maybe update your codec to work with omap ASoC and see if you still
need chaining?

Tony


>
>>
>> Also ideally this should cover also OMAP1's from 16xx onward since they
>> can link DMA channels together as well?
>
> Current code might even work for 16xx and later versions for 16 bit data. 
> ( or can be extended to work on 16xx and later versions)
> but i dont have board or TRM to check for any changes in DMA subsytem or 
> McBSP. better to play safe.
>
> 2430 onwards McBSP dxr/drr is 32 bits, which allows 24 bit mono/stereo 
> transfer easily. if we had to have 16 bit dxr1,2/drr1,2
> then we will have to perform the manipulation on data for 24 bit ops. we 
> will have to consider all the options before extending it to 16xx.
>
>>
>>
>> Jarkko
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
