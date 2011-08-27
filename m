From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [linux-pm] Issue: Runtime API usage in wake-up device irq_handler
 during wakeup from system-wide-suspend.
Date: Sat, 27 Aug 2011 12:00:02 +0530
Message-ID: <4E588EEA.7090004@ti.com>
References: <Pine.LNX.4.44L0.1108261429340.2275-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:59534 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750865Ab1H0GaL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Aug 2011 02:30:11 -0400
Received: by pzk2 with SMTP id 2so7012418pzk.6
        for <linux-omap@vger.kernel.org>; Fri, 26 Aug 2011 23:30:10 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1108261429340.2275-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Partha Basak <p-basak2@ti.com>, Tero Kristo <t-kristo@ti.com>, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

Alen,

On Saturday 27 August 2011 12:06 AM, Alan Stern wrote:
> On Fri, 26 Aug 2011, Govindraj.R wrote:
>
>> Hello,
>>
>> During system_wide_suspend pm runtime is disabled.
>> I.e. __pm_runtime_disable is called from __device_suspend.
>> Now, if a wakeup interrupt is triggered and the wakeup device irq handler
>> is called even before device_resume and pm_runtime_enable happens,
>> the device irq_handler proceeds to enable clock with runtime API to
>> handle wakeup event.
>>
>> Wouldn't this result in system wide abort since the pm_runtime is not enabled
>> yet from dpm_resume?
>> As we end up accessing regs after doing runtime get_sync.
>>
>> Looks like this scenario is not handled currently.
>> Or Am I missing something here?
>
> I don't have the complete picture, but it seems that the IRQ handler
> needs to check the return code from pm_runtime_get_sync().  If the call
> fails then the handler shouldn't try to access the device registers.
>
> In the case of a genuine wakeup event, the event should be handled
> later on as part of the resume or resume_noirq processing.
>
> However, this does raise a potential problem.  What happens if the
> clocks are needed in order to turn off the IRQ source?  Runtime PM
> won't allow the clocks to be enabled until after interrupts have been
> enabled, and by then it will be too late -- the source will have caused
> an interrupt storm.
>
I might be wrong here, but after discussion with Govindraj on this
issue, it seems there is a flaw in the way OMAP chain handler
handling the child interrupts.

On OMAP, we have special interrupt wakeup source at PRCM level and
many devices can trigger wakeup from low power via this common
interrupt source. The common interrupt source upon wakeup from low
power state, decodes the source of interrupt and based on that
source, calls the respective device ISR directly.

The issue I see here is, the ISR on _a_ device (UART in this case)
is happening even before UART resume and DPM resume has been completed.
If this is the case, then it is surely asking for trouble. Because not
just clocks, but even driver state machine is already in suspend state
when the ISR is called.

Regards
Santosh
