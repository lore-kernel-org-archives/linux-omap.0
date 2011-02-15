From: archit taneja <archit@ti.com>
Subject: Re: OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Tue, 15 Feb 2011 09:58:24 +0530
Message-ID: <4D5A00E8.4060701@ti.com>
References: <1296636990-24775-1-git-send-email-archit@ti.com> <1297693307.2951.25.camel@deskari> <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43846 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab1BOE1d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 23:27:33 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1F4RTvV009102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 22:27:32 -0600
In-Reply-To: <20110214143001.GK2549@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Monday 14 February 2011 08:00 PM, Balbi, Felipe wrote:
> Hi,
>
> On Mon, Feb 14, 2011 at 04:21:47PM +0200, Tomi Valkeinen wrote:
>> On Wed, 2011-02-02 at 08:56 +0000, archit taneja wrote:
>>> OMAP2 has an irq line dedicated for DISPC interrupts, there is no DSI
>>> on omap2.
>>> OMAP3 has a common irq line for DISPC and DSI interrupts.
>>> OMAP4 has seperate irq lines for DISPC and DSI Interrupts.
>>>
>>> Use dss_features to have a common DSS irq handler for all OMAP revisions.
>>>
>>> Also, use a member of the global dss structure to store the irq number
>>> as it is used in 2 functions.
>>
>> It's good to remove the cpu_is_xxxx() calls, but I'm not quite sure
>> about this patch...
>>
>> Could we use shared interrupt handlers here, so that dss.c would handle
>> only DISPC interrupts (or should it be even in dispc.c?) and dsi.c would
>> handle DSI interrupts?

Could you elaborate this a bit more?

>>
>> On OMAP3 both dss.c and dsi.c would register to the same interrupt, and
>> they would need to check if the interrupt was really for them. On OMAP4
>> the code could be the same, even though the check is unnecessary.

The code can't be exactly the same. The DSS_IRQSTATUS register used on 
OMAP3 doesn't exist on OMAP4. A read to this register on OMAP4 would 
cause a hang/crash.

>>
>> Also, as I mentioned in the email I sent some minutes ago, this patch
>> fixes the free_irq call in dss_exit. Things like that should never be
>> fixed silently, even if it's trivial like in this case.
>

Will take care of this from now on.

> does it make sense to install an irq_chip for that ? I mean, can you
> mask/unmask dss and or dsi IRQs ? If you can, then it might make sense
> to take a look into GENIRQ and install an irq_chip for that. Then both
> dsi and dss would be able to use standard request_irq() API.
>

We could disable dsi IRQs by masking all the possible interrupt events 
in DSI_IRQSTATUS. The same goes for dispc. Is this what you meant by 
masking/unmasking irqs?

<snip>

Regards,
Archit
