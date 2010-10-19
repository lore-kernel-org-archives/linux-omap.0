From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 4/4] Input: ads7846 - modificatons of _stop()/_disable()
 conditions
Date: Tue, 19 Oct 2010 09:25:33 +0800
Message-ID: <4CBCF38D.3040703@gmail.com>
References: <4C9332CE.6040905@gmail.com> <20100917160709.GC14186@core.coreip.homeip.net> <4C9718E9.5040104@gmail.com> <4CB4314C.7050308@gmail.com> <20101012160055.GA6355@core.coreip.homeip.net> <4CB523B7.8010209@gmail.com> <AANLkTi=0b-q3LK3-4mgdpSP7pScVSF1ZWzD45bLoAmJO@mail.gmail.com> <4CB66777.5060309@gmail.com> <AANLkTimRqaFkNkRzubY4-Gx=y0yJ_C1VFycL0+uEa_Wm@mail.gmail.com> <4CB7BCA0.1080604@gmail.com> <20101018231916.GL13341@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33224 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab0JSBVY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 21:21:24 -0400
In-Reply-To: <20101018231916.GL13341@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jason Wang <jason77.wang@gmail.com>, Grazvydas Ignotas <notasas@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, vapier@gentoo.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, roman.tereshonkov@nokia.com

Tony Lindgren wrote:
> * Jason Wang <jason77.wang@gmail.com> [101014 19:17]:
>   
>> Grazvydas Ignotas wrote:
>>     
>>> On Thu, Oct 14, 2010 at 5:14 AM, Jason Wang <jason77.wang@gmail.com> wrote:
>>>       
>>>> Grazvydas Ignotas wrote:
>>>>         
>>>>> Working here on pandora too, applied on top of linux-next (did not
>>>>> test suspend though).
>>>>>
>>>>> Not caused by this patch, but the old problem where lower measurement
>>>>> bits get lost is back - when I draw diagonal line it looks like
>>>>> stairs. I think it's caused by OMAP SPI driver, CCing linux-omap.
>>>>>
>>>>>
>>>>>           
>>>> Yes, it is OMAP spi driver issues, I have met the same problem before,
>>>> please refer to:
>>>> http://www.spinics.net/lists/arm-kernel/msg91538.html
>>>>
>>>> you can apply this patch and test again.
>>>>         
>>> It solves my issue, thanks
>>> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
>>>
>>> BTW I have done similar patch almost 2 years ago for exactly the same problem:
>>> http://marc.info/?l=linux-omap&m=122565580616920&w=2
>>> but then problem went away after random kernel update (from what I
>>> remember), and my patch was no longer needed.
>>>
>>>       
>> Really similar problem and similar solution, :-)
>>     
>
> Let's get this fix into the mainline tree then. Jason, care to
> refresh (it's wrapped at least) and then repost with the acks so
> Grant can queue it up for the upcoming merge window?
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>
>   
OK, i will refresh it and re-post it to linux-spi and Grant.

Thanks,
Jason.

