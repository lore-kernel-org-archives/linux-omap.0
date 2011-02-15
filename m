From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 11:50:04 +0100
Message-ID: <4D5A5A5C.4070909@ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com> <1297693307.2951.25.camel@deskari> <20110214143001.GK2549@legolas.emea.dhcp.ti.com> <4D5A00E8.4060701@ti.com> <1297754826.2289.9.camel@deskari> <4D5A39AE.3030006@ti.com> <1297759057.2289.40.camel@deskari> <4D5A4670.9030405@ti.com> <4D5A5410.1010300@ti.com> <AANLkTikZXdrjXMq811LR8dQ0eq-QDDUb=pUdBDghWD3E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51441 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab1BOKuI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 05:50:08 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1FAo7vk014678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 04:50:07 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1FAo7Cl026237
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 04:50:07 -0600 (CST)
In-Reply-To: <AANLkTikZXdrjXMq811LR8dQ0eq-QDDUb=pUdBDghWD3E@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi Sumit,

On 2/15/2011 11:28 AM, Semwal, Sumit wrote:
> Hi Benoit,
>
> On Tue, Feb 15, 2011 at 3:53 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Hi Archit,
>>
>> On 2/15/2011 10:25 AM, Taneja, Archit wrote:
>>>
>>> Copying Benoit,
>>>
>>> On Tuesday 15 February 2011 02:07 PM, Valkeinen, Tomi wrote:
>>>>
>>>> On Tue, 2011-02-15 at 02:30 -0600, Taneja, Archit wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On Tuesday 15 February 2011 12:57 PM, Valkeinen, Tomi wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>>> I meant something like this:
>>>>>>
>>>>>> dispc.c:
>>>>>>
>>>>>> dispc_init()
>>>>>> {
>>>>>>         /* did we have a pdev for dispc? if not, this needs to be
>>>>>> dss.pdev */
>>>>>>         request_irq(platform_get_irq(dispc.pdev, 0), irq_handler,
>>>>>> IRQF_SHARED, "dispc irq", foo);
>>>>>> }
>>>>>>
>>>>>> irq_handler()
>>>>>> {
>>>>>>         if (irq_can_be_shared) {
>>>>>>                 check if the irq is for us. exit if not;
>>>>>>         }
>>>>>>
>>>>>>         handle;
>>>>>> }
>>>>>>
>>>>>> dsi.c:
>>>>>>
>>>>>> dsi_init()
>>>>>> {
>>>>>>         request_irq(platform_get_irq(dsi.pdev, 0), irq_handler,
>>>>>> IRQF_SHARED, "dsi irq", foo);
>>>>>> }
>>>>>>
>>>>>> irq_handler()
>>>>>> {
>>>>>>         if (irq_can_be_shared) {
>>>>>>                 check if the irq is for us. exit if not;
>>>>>>         }
>>>>>>
>>>>>>         handle;
>>>>>> }
>>>>>>
>>>>>
>>>>> This approach looks clean, but isn't IRQF_SHARED used the other way
>>>>> around. One irq line and multiple handlers?
>>>>
>>>> That is the case here, isn't it (on omap3)? One interrupt line (the DSS
>>>> irq, the same returned both from dsi.pdev and dispc.pdev), and two
>>>> handlers, one in dispc and one in dsi? Or what do you mean?
>>>>
>>>> On omap2 there's no dsi code ran, so dispc is the only one requesting
>>>> the irq, and thus IRQF_SHARED is extra. In omap4 there are separate irq
>>>> lines (dsi.pdev and dispc.pdev return different irqs), and so
>>>> IRQF_SHARED is again extra. But I don't see any harm in IRQF_SHARED even
>>>> in omap2/4.
>>>>
>>>>    Tomi
>>>>
>>>
>>> Benoit,
>>>
>>> Is it okay to have the same irq entry for 2 different hwmods?
>>> This requirement comes from OMAP3 where dispc and dsi have a common irq
>>> line, where as on OMAP4 dispc and dsi have separate irq lines.
>>
>> Well, no. I explained that in one of my comment about hwmod modification.
>> The hwmod data are reflecting the exact HW capabilities.
>> So, if there is a change in the HW, the hwmod will be different.
>> It is up to the driver to adapt to this change.
> I guess what Archit wanted to say is, for hw IPs DISPC and DSI, on
> OMAP3, have a common IRQ line, so could both their hwmod databases
> have the same IRQ added for them? This would us call, for a common IRQ
> line shared w/ DISPC and DSI, like
> mentioned in Tomi's sample code above.

OK, thanks for the clarification, actually I missed a little bit the 
point :-(

So in fact the 2 modules share that same IRQ today, and you just want to 
populate both hwmod with the same input.
If this is a real OR between the two IRQ lines, meaning the dispc cannot 
mask the dsi IRQ or the opposite, then having the same IRQ number in the 
two different hwmods is a correct representation of the HW.

Then both devices with get the same IRQ number during the 
platform_get_irq, so if the driver is aware of that it is fine.

> How is hwmod data for these cases handled today? [shared IRQ,
> different platform devices?]

I don't think we have such case today at least on OMAP4. Or maybe it is 
just not properly documented, so only one hwmod is mapped to the IRQ line.

Regards,
Benoit

>
> Best regards,
> ~Sumit.
>>
>> The driver has to evolve to handle properly the new HW capabilities while
>> keeping the old stuff working.
>>
>>> We basically want to get rid of a central dss irq handler (hence, remove
>>> irq entries for dss_core hwmod) and instead have separate irq handlers
>>> for each module which may or may not share an irq line.
>>
>> Then you need to hack your driver but not the hwmod data:-(
>>
>> Regards,
>> Benoit
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

