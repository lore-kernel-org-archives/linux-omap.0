From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 13:56:16 +0100
Message-ID: <4D5A77F0.2030101@ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com> <1297693307.2951.25.camel@deskari> <20110214143001.GK2549@legolas.emea.dhcp.ti.com> <4D5A00E8.4060701@ti.com> <1297754826.2289.9.camel@deskari> <4D5A39AE.3030006@ti.com> <1297759057.2289.40.camel@deskari> <4D5A4670.9030405@ti.com> <4D5A5410.1010300@ti.com> <AANLkTikZXdrjXMq811LR8dQ0eq-QDDUb=pUdBDghWD3E@mail.gmail.com> <4D5A5A5C.4070909@ti.com> <4D5A74F2.1060100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60591 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752572Ab1BOM4T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 07:56:19 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1FCuJc3021879
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 06:56:19 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1FCuJlk010489
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 06:56:19 -0600 (CST)
In-Reply-To: <4D5A74F2.1060100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

On 2/15/2011 1:43 PM, Taneja, Archit wrote:
> Hi,
>
> <snip>
>
>>>>>
>>>>> Is it okay to have the same irq entry for 2 different hwmods?
>>>>> This requirement comes from OMAP3 where dispc and dsi have a common irq
>>>>> line, where as on OMAP4 dispc and dsi have separate irq lines.
>>>>
>>>> Well, no. I explained that in one of my comment about hwmod modification.
>>>> The hwmod data are reflecting the exact HW capabilities.
>>>> So, if there is a change in the HW, the hwmod will be different.
>>>> It is up to the driver to adapt to this change.
>>> I guess what Archit wanted to say is, for hw IPs DISPC and DSI, on
>>> OMAP3, have a common IRQ line, so could both their hwmod databases
>>> have the same IRQ added for them? This would us call, for a common IRQ
>>> line shared w/ DISPC and DSI, like
>>> mentioned in Tomi's sample code above.
>>
>> OK, thanks for the clarification, actually I missed a little bit the
>> point :-(
>>
>> So in fact the 2 modules share that same IRQ today, and you just want to
>> populate both hwmod with the same input.
>> If this is a real OR between the two IRQ lines, meaning the dispc cannot
>> mask the dsi IRQ or the opposite, then having the same IRQ number in the
>> two different hwmods is a correct representation of the HW.
>
> There is a real OR between the 2 irq lines in OMAP3, as there is no
> DSS_IRQENABLE, but there is a DSS_IRQSTATUS.
>
> You can mask one of DISPC or DSI by zeroing all the bits in
> DISPC_IRQENABLE or DSI_IRQENABLE respectively. But there is no higher
> level register to mask them.

That's perfect then, and it deserves the duplication of this irq number 
for both hwmods.

Regards,
Benoit
