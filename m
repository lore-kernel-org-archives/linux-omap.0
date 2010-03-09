From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: GPIO: Added dynamic control logic for pad wakeups
Date: Tue, 09 Mar 2010 11:27:18 -0800
Message-ID: <87vdd5nvmx.fsf@deeprootsystems.com>
References: <1255695824-17523-1-git-send-email-tero.kristo@nokia.com>
	<873a0awxoj.fsf@deeprootsystems.com>
	<1F18D6510CF0474A8C9500565A7E41A224FCDB832F@NOK-EUMSG-02.mgdnok.nokia.com>
	<20100309190125.GA2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:59617 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0CIT1X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 14:27:23 -0500
Received: by yxe29 with SMTP id 29so1133899yxe.4
        for <linux-omap@vger.kernel.org>; Tue, 09 Mar 2010 11:27:23 -0800 (PST)
In-Reply-To: <20100309190125.GA2900@atomide.com> (Tony Lindgren's message of "Tue\, 9 Mar 2010 11\:01\:25 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero.Kristo@nokia.com, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Tero.Kristo@nokia.com <Tero.Kristo@nokia.com> [100309 00:20]:
>> >
>> >Changes in wakeup state should not be directly correlated to interrupt
>> >enabled GPIOs.  Rather, this should only be done for GPIOs that are
>> >explicitly wakeup enabled (via enable_irq_wake(), which in turn
>> >calls gpio_wake_enable()).
>> 
>> This logic somehow escapes me... I would guess drivers should not care during dynamic idle whether the device is in off/ret/ina and interrupts should just work. This is done to make this happen. Also, I understood that gpio wakeup logic is needed for the suspend wakeup, which is quite different from dynamic idle wakeup.
>> 
>> However, if this is intended behavior for the kernel, then I will accept it. You are saying the code below should be moved into the gpio_wake_enable() / disable() calls?
>
> I agree. I'd assume during the idle modes we want everything to
> automatically wake the system up. Otherwise we again have non-standard
> Linux behaviour that's mysterious to track down. The enable_irq_wake
> should only be needed for suspend states.

OK, then essentially all GPIO IRQs need to be configured in the
equivalent of an enable_irq_wake'd state by default.  That means
IO pad wakeups *and* module-level wakeups.

Upon suspend, the ability to wakeup should be removed for all except
for those that have been explicitly enabled via enable_irq_wake().

Kevin
