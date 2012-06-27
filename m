From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
Date: Wed, 27 Jun 2012 10:49:24 +0530
Message-ID: <4FEA97DC.4070902@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>	 <1340372890-10091-6-git-send-email-rnayak@ti.com>	 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>	 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>	 <1340630090.3395.85.camel@deskari> <20120627004709.GA22766@gmail.com> <1340770798.1972.4.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:42712 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752592Ab2F0FTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Jun 2012 01:19:33 -0400
Received: by obfk16 with SMTP id k16so1148525obf.29
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 22:19:31 -0700 (PDT)
In-Reply-To: <1340770798.1972.4.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mike Turquette <mturquette@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, "Hilman, Kevin" <khilman@ti.com>

On Wednesday 27 June 2012 09:49 AM, Tomi Valkeinen wrote:
> On Tue, 2012-06-26 at 17:47 -0700, Mike Turquette wrote:
>> On 20120625-16:14, Tomi Valkeinen wrote:
>>> A question about clk_prepare/unprepare, not directly related: let's say
>>> I have a driver for some HW block. The driver doesn't use clk functions,
>>> but uses runtime PM. The driver also sets pm_runtime_irq_safe().
>>>
>>> Now, the driver can call pm_runtime_get_sync() in an atomic context, and
>>> this would lead to the underlying framework (hwmod, omap_device, I don't
>>> know who =) enabling the func clock for that HW. But this would happen
>>> in atomic context, so the underlying framework can't use clk_prepare.
>>>
>>> How does the underlying framework handle that case? (sorry if that's a
>>> stupid question =).
>>>
>>
>> I think it's a good question!
>>
>> If we're going to call clk_prepare_enable from within a runtime pm
>> callback then I think we'll need to check if _irq_safe() is set and
>> conditionally call only clk_enable in such a case.
>>
>> I'm not a runtime pm expert, but if the driver owns the responsibility
>> of calling pm_runtime_irq_safe then the driver has the proper context
>> to know that it should call clk_prepare BEFORE calling
>> pm_runtime_get_sync.
>
> That's not quite what I meant. If it's the driver that does clk_enable,
> be it in runtime PM callback or not, it's driver's responsibility.
>
> But some clocks are not handled by the driver, but the hwmod/omap_device
> framework. Mainly I think this is for the functional and interface
> clocks. The driver has no visibility to those, they are implicitly
> enabled via pm_runtime_get.

yes, thats the tricky part on how would hwmod/omap_device know if the
driver would use runtime pm within atomic context or non-atomic context.
The driver does inform the runtime pm framework about this by calling a
pm_runtime_irq_safe(), which is then used to set the .irq_safe flag 
telling it to leave the interrupts disabled during callbacks.
This information however does not flow down to hwmod/omap_device in any
way. So the way its currently handled is to do an early prepare of all
hwmod controlled clocks.

I have copied Kevin in case he has any better ideas on how this should
be handled.

>
>   Tomi
>

