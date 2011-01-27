From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v10 18/18] OMAP2, 3: DSS2: Get DSS IRQ from platform
	device
Date: Thu, 27 Jan 2011 12:59:55 +0000
Message-ID: <20110127125955.GC26418@n2100.arm.linux.org.uk>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com> <1295850125-21405-19-git-send-email-sumit.semwal@ti.com> <4D4169D1.20001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53941 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab1A0NA3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 08:00:29 -0500
Content-Disposition: inline
In-Reply-To: <4D4169D1.20001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghuveer Murthy <x0075817@ti.com>
Cc: Sumit Semwal <sumit.semwal@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Jan 27, 2011 at 06:19:21PM +0530, Raghuveer Murthy wrote:
>> +	r = request_irq(dss_irq,
>> +		cpu_is_omap24xx()
>> +		? dss_irq_handler_omap2
>> +		: dss_irq_handler_omap3,
>
> it should be
>
> 		cpu_is_omap24xx()
> 		? dss_irq_handler_omap3
> 		: dss_irq_handler_omap2,
>
> I am seeing a crash on Panda, which gets rectified with this
> change. The root cause is access to DSS_IRQSTATUS register in the
> dss_irq_handler_omap3 handler, which is not valid for OMAP4.

That really doesn't look right.  Let me translate the code you've just
written:

	if (cpu_is_omap24xx())
		handler = dss_irq_handler_omap3;
	else
		handler = dss_irq_handler_omap2;

Which means: if we have an OMAP24xx device, use the OMAP3 handler,
otherwise use the OMAP2 handler.  That's got to be wrong.
