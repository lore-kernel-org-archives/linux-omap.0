From: Jon Hunter <jgchunter@gmail.com>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Tue, 28 May 2013 19:41:54 +0100
Message-ID: <51A4FA72.2070402@gmail.com>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi> <20130516180933.GG5600@atomide.com> <20130516210006.GA31836@blackmetal.musicnaut.iki.fi> <20130516214430.GN5600@atomide.com> <20130520174621.GI10378@atomide.com> <20130521173936.GE31836@blackmetal.musicnaut.iki.fi> <519BCCEC.8010303@gmail.com> <20130522212054.GG31836@blackmetal.musicnaut.iki.fi> <519E67AD.6070702@gmail.com> <20130523201358.GI31836@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:46561 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab3E1Sl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 May 2013 14:41:59 -0400
Received: by mail-wg0-f49.google.com with SMTP id y10so5560305wgg.28
        for <linux-omap@vger.kernel.org>; Tue, 28 May 2013 11:41:57 -0700 (PDT)
In-Reply-To: <20130523201358.GI31836@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org


On 23/05/13 21:13, Aaro Koskinen wrote:
> On Thu, May 23, 2013 at 08:02:05PM +0100, Jon Hunter wrote:
>> On 22/05/13 22:20, Aaro Koskinen wrote:
>>> On Tue, May 21, 2013 at 08:37:16PM +0100, Jon Hunter wrote:
>>>> On 21/05/13 18:39, Aaro Koskinen wrote:
>>>>> On Mon, May 20, 2013 at 10:46:21AM -0700, Tony Lindgren wrote:
>>>>>> * Tony Lindgren <tony@atomide.com> [130516 14:50]:
>>>>>>> * Aaro Koskinen <aaro.koskinen@iki.fi> [130516 14:05]:
>>>>>>>> On Thu, May 16, 2013 at 11:09:34AM -0700, Tony Lindgren wrote:
>>>>>>>>> * Aaro Koskinen <aaro.koskinen@iki.fi> [130513 13:58]:
>>>>>>>>>> I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:
>>>>>>>>>>
>>>>>>>>>> [    2.264221] retu-mfd 2-0001: Retu v3.2 found
>>>>>>>>>> [    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
>>>>>>>>>> [    2.300140] retu-mfd: probe of 2-0001 failed with error -12
>>>>>>>>>>
>>>>>>>>>> The error is coming from regmap code. According to git bisect, it is
>>>>>>>>>> caused by:
>>>>>>>>>>
>>>>>>>>>> 	commit ede4d7a5b9835510fd1f724367f68d2fa4128453
>>>>>>>>>> 	Author: Jon Hunter <jon-hunter@ti.com>
>>>>>>>>>> 	Date:   Fri Mar 1 11:22:47 2013 -0600
>>>>>>>>>>
>>>>>>>>>> 	    gpio/omap: convert gpio irq domain to linear mapping
>>>>>>>>>>
>>>>>>>>>> The commit does not anymore revert cleanly, and I haven't yet tried
>>>>>>>>>> crafting a manual revert, so any fix proposals/ideas are welcome...
>>>>>>>>>
>>>>>>>>> Hmm this might be a bit trickier to fix. Obviously the real solution
>>>>>>>>> is to convert omap1 to SPARSE_IRQ like we did for omap2+.
>>>>>>>>>
>>>>>>>>> For the -rc cycle, it might be possible to fix this by adding a
>>>>>>>>> different irq_to_gpio() and gpio_to_irq() functions for omap1.
>>>>>>>>
>>>>>>>> The commit reverts cleanly if we also revert
>>>>>>>> 3513cdeccc647d41c4a9ff923af17deaaac04a66 (gpio/omap: optimise interrupt
>>>>>>>> service routine), which seems to be just some minor optimization. The
>>>>>>>> result is below, and with it 770 works again.
>>>>>>>
>>>>>>> Hmm in this case it seems that we should just fix it rather than go back
>>>>>>> to the old code, so let's take a look at that first.
>>>>>>
>>>>>> Does the following fix it for you or do we need to fix something else
>>>>>> there too?
>>>>>
>>>>> Thanks, that fixes Retu probe on 770.
>>>>
>>>> Sorry for not responding sooner, but I have been moving. 
>>>>
>>>> From looking at the code it appears that the regmap_add_irq_chip()
>>>> is failing in the retu driver. I am not sure if this will work, 
>>>> but have you tried making the following change to the retu driver 
>>>> so that it also uses irq_domain_add_linear() as well? Just a thought ...
>>>
>>> This will trigger WARNING: at drivers/base/regmap/regmap-irq.c:514.
>>
>> Sorry, there is another change needed. Can you try ...
> 
> I will try this. However, I would also like to point out that Retu works
> fine on N800/N810 (OMAP2). If the problem is in Retu, why only OMAP1
> is affected?

The problem is not with retu or the gpio driver per-se, its just that
now they are conflicting because the way the irq domains are being
allocated. So probably just getting lucky on the n8xx. I had tested on
omap1-4 and had not seen any problems, but none of my boards used the
retu driver.

Cheers
Jon
