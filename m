From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 02/13] USB: phy: nop: Defer probe if device needs VCC/RESET
Date: Tue, 12 Mar 2013 11:10:09 +0200
Message-ID: <513EF0F1.5000901@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-3-git-send-email-rogerq@ti.com> <51109E95.3000307@ti.com> <5110C655.3060305@ti.com> <20130205090920.GH32118@arwen.pp.htv.fi> <5110D45A.3040007@ti.com> <513DFF17.5010207@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44643 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932122Ab3CLJK3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 05:10:29 -0400
In-Reply-To: <513DFF17.5010207@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: balbi@ti.com, kishon <kishon@ti.com>, tony@atomide.com, b-cousson@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

On 03/11/2013 05:58 PM, Marc Kleine-Budde wrote:
> On 02/05/2013 10:43 AM, Roger Quadros wrote:
>> On 02/05/2013 11:09 AM, Felipe Balbi wrote:
>>> On Tue, Feb 05, 2013 at 10:44:05AM +0200, Roger Quadros wrote:
>>>>>> diff --git a/include/linux/usb/nop-usb-xceiv.h b/include/linux/usb/nop-usb-xceiv.h
>>>>>> index 3265b61..148d351 100644
>>>>>> --- a/include/linux/usb/nop-usb-xceiv.h
>>>>>> +++ b/include/linux/usb/nop-usb-xceiv.h
>>>>>> @@ -6,6 +6,10 @@
>>>>>>   struct nop_usb_xceiv_platform_data {
>>>>>>       enum usb_phy_type type;
>>>>>>       unsigned long clk_rate;
>>>>>> +
>>>>>> +    /* if set fails with -EPROBE_DEFER if can't get regulator */
>>>>>> +    unsigned int needs_vcc:1;
>>>>>> +    unsigned int needs_reset:1;
>>>>>
>>>>> how about u8 here?
>>>>
>>>> Not sure. Bitfields are usually defined as unsigned int.
>>>
>>> IIRC the benefit is that compiler can try to optimize those flags. I
>>> mean, if you have 32 1-bit flags, compiler will combine those in a
>>> single u32. Someone correct me if I'm wrong.
>>>
>>
>> Yes you are right. Kishon was asking me to use u8 instead of unsigned int, which
>> I don't think is necessary. AFAIK, it is a norm to use unsigned int when defining
>> a bitfield. Compilers are known to behave funny with bitfields. I don't mind
>> using bool for each.
> 
> In the current version (rogerq/v3.8-usbhost17-dt) of this patch you've
> put both needs_* into the private data struct and the pdata, but it's
> only used inside the probe function.
> 

Good catch! Will fix.

cheers,
-roger
