From: "Subbrathnam, Swaminathan" <swami.iyer-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs
Date: Fri, 28 Aug 2009 15:41:14 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9A45083@dbde02.ent.ti.com>
References: <1251439096-10791-1-git-send-email-ajay.gupta@ti.com>
 <4A97A1FF.5050501@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E73940436A4A60D@dbde02.ent.ti.com>
 <4A97AB42.4070008@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A97AB42.4070008-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Sergei,
	Pl. do the required testing with and without the patch on the current tree for ISO transfers in Tx direction.  As Ajay indicated we have done the same and found it not working and hence the fix.

	ISO Rx is also broken and the patch for fixing the same is on the way.  Since that fix involves some bit of re-structuring it is delayed a bit.

	We can discuss further if need be.

Regards
swami

-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org] 
Sent: Friday, August 28, 2009 3:33 PM
To: Gupta, Ajay Kumar
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; Subbrathnam, Swaminathan; B, Ravi
Subject: Re: [PATCH] musb: fix ISOC Tx programming for CPPI DMAs

Hello.

Gupta, Ajay Kumar wrote:
>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org]
>> Sent: Friday, August 28, 2009 2:53 PM
>> To: Gupta, Ajay Kumar
>> Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
>> felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org; david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org; Subbrathnam, Swaminathan; B,
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



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
