From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 3/5] OMAP4: hwmod data: add mailbox data
Date: Tue, 15 Feb 2011 23:05:46 +0100
Message-ID: <4D5AF8BA.8080403@ti.com>
References: <1296674843-12718-1-git-send-email-omar.ramirez@ti.com>	<1296674843-12718-4-git-send-email-omar.ramirez@ti.com>	<4D5943A9.8010205@ti.com> <AANLkTinA2a60TSM7qDC1LQiRaUTs0DR3bDMv+oVsVOE0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36957 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865Ab1BOWF7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 17:05:59 -0500
In-Reply-To: <AANLkTinA2a60TSM7qDC1LQiRaUTs0DR3bDMv+oVsVOE0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Omar,

On 2/15/2011 10:55 PM, Ramirez Luna, Omar wrote:
> Hi Benoit,
>
> On Mon, Feb 14, 2011 at 9:00 AM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>>> +static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
>>> +       { .name = "mbox", .irq = 26 + OMAP44XX_IRQ_GIC_START, },
>>
>> The original entry was unnamed since it is an unique entry and thus does not
>> need to be differentiate on this platform.
>>
>>         { .irq = 26 + OMAP44XX_IRQ_GIC_START },
>>
>> Do you really need to have a name here? The strategy being to provide a name
>> only if more than one entry exist.
>> It is perfectibility doable, I'm just trying to understand your rational.
>
> It is this way instead of plain platform_get_irq because omap2420 has
> two interrupt sources to MPU and mailbox driver uses
> platform_get_irq_byname to get the irq number.

This is what I was thinking, except that on OMAP2420 the names are:
+	{ .name = "dsp", .irq = 26, },
+	{ .name = "iva", .irq = 34, },

and on OMAP2430 and OMAP3
+	{ .name = "dsp", .irq = 26, },

so why is it named "mbox" on OMAP4?

If you have to do several platform_get_irq_byname to get this one, I'd 
prefer to get rid of that name for OMAP4. It will make mailbox irq 
consistent with the other hwmods.

Thanks,
Benoit

