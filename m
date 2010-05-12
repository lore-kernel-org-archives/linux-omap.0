From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
 >= 1.8
Date: Wed, 12 May 2010 18:59:52 +0400
Message-ID: <4BEAC268.1080601@ru.mvista.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com> <1273664979-493-2-git-send-email-ajay.gupta@ti.com> <1273664979-493-3-git-send-email-ajay.gupta@ti.com> <1273664979-493-4-git-send-email-ajay.gupta@ti.com> <4BEAAA8A.1000003@ru.mvista.com> <19F8576C6E063C45BE387C64729E7394044E405072@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:57941 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab0ELPAn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 11:00:43 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E405072@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello.

Gupta, Ajay Kumar wrote:

> Hi,
>   
>>>  	if (channel->status == MUSB_DMA_STATUS_BUSY) {
>>>  		if (musb_channel->transmit) {
>>> +			if (musb_channel->sysdma_channel != -1)
>>> +				omap_stop_dma(musb_channel->sysdma_channel);
>>> +
>>>
>>>       
>>    Have you thought about e.g. Blackfin? How this is going to compile
>> there, without omap_*() functions even existing? Or did you think that
>> OMAP is the only user of this driver?
>>     
> Thanks for pointing this. It would require adding wrapper functions for
> Blckfin's.
>   

   Better wrap your stuff into #ifdef OMAP, I think...

> -Ajay
>   
WBR, Sergei


