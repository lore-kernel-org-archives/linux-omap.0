From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] AM35x: Add musb support
Date: Mon, 22 Mar 2010 13:14:05 +0300
Message-ID: <4BA742ED.6080004@ru.mvista.com>
References: <1267017495-17548-1-git-send-email-ajay.gupta@ti.com>,<4BA4CCF3.4060500@ru.mvista.com> <19F8576C6E063C45BE387C64729E7394044DCC5F29@dbde02.ent.ti.com> <4BA5FBF6.8010102@mvista.com> <19F8576C6E063C45BE387C64729E7394044DE0E5E6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:41141 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab0CVKOi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 06:14:38 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DE0E5E6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hello.

Gupta, Ajay Kumar wrote:

>>>> +/* USB 2.0 OTG module registers */
>>>> +#define USB_REVISION_REG     0x00
>>>> +#define USB_CTRL_REG         0x04
>>>> +#define USB_STAT_REG         0x08
>>>> +#define USB_EMULATION_REG    0x0c
>>>> +/* 0x10 Reserved */
>>>>  Wait... so the mode register isn't supported? Does AM35x support any
>>>> accelerated modes?
>>>>
>>>>         
>>> Mode register is available though with some difference due to 15Rx/Tx
>>>       
>> eps.
>>     
>>> I have not added CPPI4.1 DMA  specific register here..
>>>
>>>       
>>    Ah. Then they're not compatible with DA8xx anyway...
>>     
>
> We could make it compatible with some change as done at,
> http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=commitdiff;h=2ecce9529bd56c32997e0b2cbe84f7727ba5b217
>   

   I'm not sure where cppi41_dma.c gets the definitions for 
USB_[RT]X_MODE_REG... anyway, I'm thinking of a different solution now, 
i.e. moving the functions that access the implementation specific 
acceleration

>>>> +#define USB_END_OF_INTR_REG  0x60
>>>>   Hm, I don't see the generic RNDIS EP size registers also. So, generic
>>>> RNDIS mode isn't supported? Then cppi41_dma.c won't work with this
>>>> chip... :-/
>>>>
>>>>         
>>> Generic RNDIS mode is suported and CPPi4,1 is already verified to be
>>>       
>> working on
>>     
>>> AM3517.
>>>       
>>    I wonder how it can work as the registers cppi41_dma.c relies upon
>> are not the same as in DA8xx. Did you make some changes to cppi41_dma.c?
>>     
>
> There were only few changes to make it work. You can see the changes
> in our internal release tree at,
> http://arago-project.org/git/people/?p=sriram/ti-psp-omap.git;a=summary
>
> They have all the CPPI patches based out of your latest patch. All these
>   

   My latest was take 5, this tree has take 3 as a base.

> have to be reviewed/cleaned which is not happening as the base CPPI4.1 patch
> itself is pending to be merged.
>
> Any update on CPPI4.1 driver location?

   I'm pretty sure it should be in arch/arm/common/...

>  Are you still waiting for Russell's reply?
>   

   Well, yes and no. I'm not hoping on Russell's reply though but 
haven't found time to move the code and post the new patch...

WBR, Sergei


