From: Raghuveer Murthy <x0075817@ti.com>
Subject: Re: [PATCH v10 18/18] OMAP2, 3: DSS2: Get DSS IRQ from platform	device
Date: Thu, 27 Jan 2011 18:34:41 +0530
Message-ID: <4D416D69.6030200@ti.com>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com> <1295850125-21405-19-git-send-email-sumit.semwal@ti.com> <4D4169D1.20001@ti.com> <20110127125955.GC26418@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40637 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab1A0NJf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 08:09:35 -0500
In-Reply-To: <20110127125955.GC26418@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thursday 27 January 2011 06:29 PM, Russell King - ARM Linux wrote:
> On Thu, Jan 27, 2011 at 06:19:21PM +0530, Raghuveer Murthy wrote:
>>> +	r = request_irq(dss_irq,
>>> +		cpu_is_omap24xx()
>>> +		? dss_irq_handler_omap2
>>> +		: dss_irq_handler_omap3,
>>
>> it should be
>>
>> 		cpu_is_omap24xx()
>> 		? dss_irq_handler_omap3
>> 		: dss_irq_handler_omap2,
>>
>> I am seeing a crash on Panda, which gets rectified with this
>> change. The root cause is access to DSS_IRQSTATUS register in the
>> dss_irq_handler_omap3 handler, which is not valid for OMAP4.
>
> That really doesn't look right.  Let me translate the code you've just
> written:
>
> 	if (cpu_is_omap24xx())
> 		handler = dss_irq_handler_omap3;
> 	else
> 		handler = dss_irq_handler_omap2;
>
> Which means: if we have an OMAP24xx device, use the OMAP3 handler,
> otherwise use the OMAP2 handler.  That's got to be wrong.
>
I agree, that the logic seems counter-intuitive. I was doing a quick test.

However, to  keep the correct sequence, the logic inside the respective 
handlers need to be looked at.

Regards,
Raghuveer
