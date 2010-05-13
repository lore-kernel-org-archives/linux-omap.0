From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH 2/5] musb: use system DMA to fix Inventra DMA issue on
 RTL-1.4
Date: Thu, 13 May 2010 14:28:48 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F9F43A6@dbde02.ent.ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>,<20100512175113.GA3285@gandalf>
 <5A47E75E594F054BAF48C5E4FC4B92AB03216237DA@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E7394044E40516E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33007 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab0EMI7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 04:59:00 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044E40516E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

>-----Original Message-----
>From: linux-usb-owner@vger.kernel.org 
>[mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Gupta, Ajay Kumar
>Sent: Thursday, May 13, 2010 9:53 AM
>To: Gadiyar, Anand; me@felipebalbi.com
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
>Subject: RE: [PATCH 2/5] musb: use system DMA to fix Inventra 
>DMA issue on RTL-1.4
>
>Hi,
>>Subject: RE: [PATCH 2/5] musb: use system DMA to fix Inventra 
>DMA issue 
>>on
>> RTL-1.4

>
>Felipe,
>
>> > > Another approach to use PIO mode in opposite direction would 
>> > > increase
>> the
>> > > cpu loading and thus using system DMA is preferred workaround.
>> > >
>> > > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> >
>> > I think falling back to pio is better than this patch.
>At the cost of cpu, which certainly is not preferred.
>
>>> It will most likely be only one transfer.
>
>How about host mode with multiple devices connected and doing 
>transfers?
>Falling back to PIO would kill the cpu.
>
>>> Another approach is to allocate dma channels on a transfer basis.
>
>Can you elaborate this?

It might be good idea to allocate the dma channels on tarnsfer basis as Felipe
Suggested. The musb driver allocates dma channels for the first 8 enabled 
endpoints and  higher endpoints works in PIO mode. 
For system dma if there are more nummber of Rx endpoints enabled but not used for data 
Transfer you might end up having many sdma channles allocated biut not used which will
Impact in the system of not utilizing the sdma channels effectively.

~Hema

>>> This is way too big of a problem.
>
>
>If we think of the scenarios in host mode then certainly using 
>system DMA is best approach.
>
>-Ajay
>> Which one is better depends on how many endpoints are doing, 
>transfers 
>> in parallel, I suppose.
>> 
>> I did post the a patch for the other approach (to fall back to PIO).
>> I haven't received a response to that yet. I'm okay with 
>either approach.
>> 
>> 
>> - Anand
>--
>To unsubscribe from this list: send the line "unsubscribe 
>linux-usb" in the body of a message to 
>majordomo@vger.kernel.org More majordomo info at  
>http://vger.kernel.org/majordomo-info.html
>