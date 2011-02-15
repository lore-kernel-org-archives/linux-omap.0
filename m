From: archit taneja <archit@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 14:55:04 +0530
Message-ID: <4D5A4670.9030405@ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com>	 <1297693307.2951.25.camel@deskari>	 <20110214143001.GK2549@legolas.emea.dhcp.ti.com>  <4D5A00E8.4060701@ti.com>	 <1297754826.2289.9.camel@deskari>  <4D5A39AE.3030006@ti.com> <1297759057.2289.40.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50424 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450Ab1BOJYM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 04:24:12 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1F9O8ZJ030619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 03:24:11 -0600
In-Reply-To: <1297759057.2289.40.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Copying Benoit,

On Tuesday 15 February 2011 02:07 PM, Valkeinen, Tomi wrote:
> On Tue, 2011-02-15 at 02:30 -0600, Taneja, Archit wrote:
>> Hi,
>>
>> On Tuesday 15 February 2011 12:57 PM, Valkeinen, Tomi wrote:
>>
>> <snip>
>>
>>> I meant something like this:
>>>
>>> dispc.c:
>>>
>>> dispc_init()
>>> {
>>> 	/* did we have a pdev for dispc? if not, this needs to be dss.pdev */
>>> 	request_irq(platform_get_irq(dispc.pdev, 0), irq_handler, IRQF_SHARED, "dispc irq", foo);
>>> }
>>>
>>> irq_handler()
>>> {
>>> 	if (irq_can_be_shared) {
>>> 		check if the irq is for us. exit if not;
>>> 	}
>>>
>>> 	handle;
>>> }
>>>
>>> dsi.c:
>>>
>>> dsi_init()
>>> {
>>> 	request_irq(platform_get_irq(dsi.pdev, 0), irq_handler, IRQF_SHARED, "dsi irq", foo);
>>> }
>>>
>>> irq_handler()
>>> {
>>> 	if (irq_can_be_shared) {
>>> 		check if the irq is for us. exit if not;
>>> 	}
>>>
>>> 	handle;
>>> }
>>>
>>
>> This approach looks clean, but isn't IRQF_SHARED used the other way
>> around. One irq line and multiple handlers?
>
> That is the case here, isn't it (on omap3)? One interrupt line (the DSS
> irq, the same returned both from dsi.pdev and dispc.pdev), and two
> handlers, one in dispc and one in dsi? Or what do you mean?
>
> On omap2 there's no dsi code ran, so dispc is the only one requesting
> the irq, and thus IRQF_SHARED is extra. In omap4 there are separate irq
> lines (dsi.pdev and dispc.pdev return different irqs), and so
> IRQF_SHARED is again extra. But I don't see any harm in IRQF_SHARED even
> in omap2/4.
>
>   Tomi
>

Benoit,

Is it okay to have the same irq entry for 2 different hwmods?
This requirement comes from OMAP3 where dispc and dsi have a common irq 
line, where as on OMAP4 dispc and dsi have separate irq lines.

We basically want to get rid of a central dss irq handler (hence, remove 
irq entries for dss_core hwmod) and instead have separate irq handlers 
for each module which may or may not share an irq line.

Regards,
Archit
