From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 14:02:42 +0400
Message-ID: <4A97AB42.4070008@ru.mvista.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com> <4A97A1FF.5050501@ru.mvista.com> <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:47112 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751451AbZH1KCs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Aug 2009 06:02:48 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>, "B, Ravi" <ravibabu@ti.com>

Hello.

Gupta, Ajay Kumar wrote:
>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]
>> Sent: Friday, August 28, 2009 2:53 PM
>> To: Gupta, Ajay Kumar
>> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
>> felipe.balbi@nokia.com; david-b@pacbell.net; Subbrathnam, Swaminathan; B,
>> Ravi
>> Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
>>
>> Hello.
>>
>> Ajay Kumar Gupta wrote:
>>
>>     
>>> Isochronous Tx DMA is getting programmed but never getting started
>>> for CPPI and TUSB DMAs and thus Isochronous Tx doesn't work.
>>>
>>>       
>>    That's not true.
>>     
>
> We have tested and it doesn't work with current driver. Have you tested it and was it working for you ?
>   

   Not with the current driver, I must admit. I'll try it today...

>>> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
>>> index cf94511..e3ab40a 100644
>>> --- a/drivers/usb/musb/musb_host.c
>>> +++ b/drivers/usb/musb/musb_host.c
>>> @@ -1301,8 +1301,11 @@ void musb_host_tx(struct musb *musb, u8 epnum)
>>>  		return;
>>>  	} else	if (usb_pipeisoc(pipe) && dma) {
>>>  		if (musb_tx_dma_program(musb->dma_controller, hw_ep, qh, urb,
>>> -				offset, length))
>>> +				offset, length)) {
>>> +			if (is_cppi_enabled() || tusb_dma_omap())
>>> +				musb_h_tx_dma_start(hw_ep);
>>>  			return;
>>>
>>>       
>>    It will have been already started by this moment -- from
>> musb_start_urb() which is enough . Otherwise it wouldn't work, and I've
>> made sure it *does* work.
>>     
>
> This part is being done at musb_host_rx()

   You're doing it in musb_host_tx() actually. Although musb_host_rx() 
is also broken WRT the isochronous transfers.

>  doing next packet programming within same urb and *not* starting next urb. Thus musb_start_urb() doesn't come into this path.

   What? Read the code, please -- musb_start_urb() call should always 
precede musb_host_tx() which handles the DMA interrupt. Unless something 
clears DMAReqEnab after musb_start_urb() call, setting it only once 
should work.

> So it wouldn't start the DMAs.
>   

   How musb_host_tx() can be called without musb_start_urb()?

> In case of PIO, it does load the FIFO and sets the TXPKTREADY.
>   

   Only is URB_ISO_ASAP is not set.

WBR, Sergei

> -Ajay

WBR, Sergei


