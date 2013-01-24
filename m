From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
Date: Thu, 24 Jan 2013 18:08:20 +0100
Message-ID: <51016A84.20703@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch> <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch> <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49302 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab3AXRIa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Jan 2013 12:08:30 -0500
In-Reply-To: <5101663C.7020301@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 01/24/2013 05:50 PM, Florian Vaussard wrote:
>>> I did it at first, but the led API executes in atomic context, where the
>>> pwm-twl-led driver uses i2c communication. Setting a trigger will result in a
>>> kernel panic.
>>
>> Now that you mentioned it, this might be true.
>>
> 
> [<c0013204>] (unwind_backtrace+0x0/0xec) from [<c00348ac>]
> (warn_slowpath_common+0x4c/0x64)
> [<c00348ac>] (warn_slowpath_common+0x4c/0x64) from [<c00348e0>]
> (warn_slowpath_null+0x1c/0x24)
> [<c00348e0>] (warn_slowpath_null+0x1c/0x24) from [<c054d384>]
> (__mutex_lock_slowpath+0x6c/0x26c)
> [<c054d384>] (__mutex_lock_slowpath+0x6c/0x26c) from [<c054d590>]
> (mutex_lock+0xc/0x20)
> [<c054d590>] (mutex_lock+0xc/0x20) from [<c02d740c>]
> (regmap_bulk_write+0x48/0x138)
> [<c02d740c>] (regmap_bulk_write+0x48/0x138) from [<c02de2c0>]
> (twl_i2c_write+0xa4/0xf0)
> [<c02de2c0>] (twl_i2c_write+0xa4/0xf0) from [<c0299e34>]
> (twl4030_pwmled_config+0x70/0x9c)
> [<c0299e34>] (twl4030_pwmled_config+0x70/0x9c) from [<c029875c>]
> (pwm_config+0x5c/0x6c)
> [<c029875c>] (pwm_config+0x5c/0x6c) from [<c039dc04>] (led_pwm_set+0x28/0x64)
> [<c039dc04>] (led_pwm_set+0x28/0x64) from [<c039e27c>]
> (led_heartbeat_function+0x10c/0x134)
> [<c039e27c>] (led_heartbeat_function+0x10c/0x134) from [<c004359c>]
> (call_timer_fn+0x90/0x178)
> [<c004359c>] (call_timer_fn+0x90/0x178) from [<c0043994>]
> (run_timer_softirq+0x250/0x2c8)
> [<c0043994>] (run_timer_softirq+0x250/0x2c8) from [<c003cf78>]
> (__do_softirq+0xf8/0x248)
> [<c003cf78>] (__do_softirq+0xf8/0x248) from [<c003d154>] (irq_exit+0x44/0x98)
> [<c003d154>] (irq_exit+0x44/0x98) from [<c000e338>] (handle_IRQ+0x68/0x8c)
> [<c000e338>] (handle_IRQ+0x68/0x8c) from [<c000870c>]
> (omap3_intc_handle_irq+0x58/0x70)
> [<c000870c>] (omap3_intc_handle_irq+0x58/0x70) from [<c054f8c0>]
> (__irq_svc+0x40/0x70)
> Exception stack(0xc077df60 to 0xc077dfa8)
> 
> :-)
> 
>>> I am working on a patch for pwm-twl-led to defer using a workqueue right now.
>>
>> Great!
>> The only thing I worry about is the latency we are going to get with the
>> workqueue.
>>
> 
> If the latency becomes critical, we can create our own workqueue.

Hrm, when we handled the led via gpio-leds it was also going through the same
path at the end, via i2c to twl4030.
I think the fix for this is going to be needed in the pwm core level. Just
need to look at the gpio code to have similar handling of might_sleep interfaces.

> Do we merge anyway this patchset, or do we wait until the trigger has been fixed?

I think it can go and later when we have the fix for the slow path you can add
the default trigger.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
