From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2]  McBSP DMA support for  34xx
Date: Wed, 24 Sep 2008 12:28:42 +0300
Message-ID: <20080924092841.GL5222@atomide.com>
References: <20080910141452.c59572e9.jarkko.nikula@nokia.com> <0e0b01c9133a$a479b3c0$LocalHost@wipultra806>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50618 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbYIXJ2r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 05:28:47 -0400
Content-Disposition: inline
In-Reply-To: <0e0b01c9133a$a479b3c0$LocalHost@wipultra806>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "shekhar, chandra" <x0044955@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

* shekhar, chandra <x0044955@ti.com> [080910 14:45]:
>
> ----- Original Message ----- From: "Jarkko Nikula" 
> <jarkko.nikula@nokia.com>
> To: "ext shekhar, chandra" <x0044955@ti.com>
> Cc: "Tony Lindgren" <tony@atomide.com>; <linux-omap@vger.kernel.org>
> Sent: Wednesday, September 10, 2008 4:44 PM
> Subject: Re: [PATCH 1/2] McBSP DMA support for 34xx
>
>
>> On Wed, 10 Sep 2008 15:47:34 +0530
>> "ext shekhar, chandra" <x0044955@ti.com> wrote:
>>
>>> Most importantly,
>>> 4> McBSP buffer ( To save power, for 34xx).
>>> OMAP3430 McBSP interface 2 has 5k buffer for audio.  handling of this
>>> buffer should be specific to McBSP.
>>>
>> Actually it's not specific to McBSP only. I haven't paid attention into
>> these HW buffering issues but they have an effect. Like
>>
>> - IRCC ALSA expects that playback/record is really stopped when trigger
>>  callback returns
>> - How HW buffering affects pointer callback? Some low-latency audio
>>  algorithms require that buffer position is known very precisely. E.g.
>>  if modifying already queued audio buffer content but which is not
>>  played out yet
>
> This harware buffer is not user accessible, but during data transfer it 
> is related to dma transfer.
> During data transfer instead of element sync, packet sync data transfer 
> can be used.
> DMA request length can be configured buffer threshold and packet sync 
> transfer can be used instead of element sync.

Let's put these on hold until we see the use cases. We should first
get all the other pending mcbsp patches into the mainline kernel, and
then all legacy audio code removed from l-o tree.

Then let's see how we can make use of the McBSP fifo and chaining if
needed.

Cheers,

Tony
