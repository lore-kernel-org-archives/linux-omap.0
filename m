From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3EVM: Update pad configuration for wakeup enabled pads
Date: Thu, 29 Apr 2010 07:11:02 -0700
Message-ID: <87wrvq5oy1.fsf@deeprootsystems.com>
References: <1272369361-25147-1-git-send-email-ranjithl@ti.com>
	<87fx2hq61m.fsf@deeprootsystems.com> <4BD7FF39.8080607@ti.com>
	<87y6g7e8s2.fsf@deeprootsystems.com> <4BD96998.9090902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47841 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758900Ab0D3SJ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 14:09:57 -0400
Received: by pxi17 with SMTP id 17so302650pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 11:09:51 -0700 (PDT)
In-Reply-To: <4BD96998.9090902@ti.com> (Ranjith Lohithakshan's message of "Thu\, 29 Apr 2010 16\:42\:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> On Wed, 28-Apr-10 11:53 PM +0530, Kevin Hilman wrote:
>> Ranjith Lohithakshan <ranjithl@ti.com> writes:
>> 
>>> Kevin,
>>>
>>> On Tue, 27-Apr-10 8:46 PM +0530, Kevin Hilman wrote:
>>>> Ranjith Lohithakshan <ranjithl@ti.com> writes:
>>>>
>>>>> OMAP3530 TRM section 7.4.4.4.2 requires OFFOUTENABLE to be set (active low)
>>>>> if wakeup capabilities are enabled on a pad. During OFF mode testing
>>>>> on OMAP3530 EVM, it was observed that the device was not residing in
>>>>> the OFF state. The device enters into the OFF state and immediately exits
>>>>> from that state as if an IO wakeup event has occured. The issue was traced
>>>>> down to the pad configuration of wkaeup enabled pad's.
>>>> Nice.
>>>>
>>>>> Also, the pad configuration is included only if the respective drivers are
>>>>> enabled in the defconfig.
>>>> Hmm, do you really want this?  If you don't have the driver enabled,
>>>> you have to rely on the bootloader settings of these pads which may
>>>> also be wrong and trigger an IO wakeup as well.
>>> The thought process was that, for example, if keypad is not enabled
>>> in a system configuration you probably don't want to see a wakeup
>>> occurring if someone presses a key stroke. I understand the concern
>>> that you have raised regarding bootloader mis-configurations. My
>>> impression was that the bootloaders typically set the mux modes and
>>> pull up's/downs and dont really program or enable the wakeup
>>> capability.  But we cannot depend on that thumb rule.
>> 
>> Unfortunately, Bootloaders don't "typically" do anything.  They are
>> routinely hacked/patched and cannot be trusted at all.
>> 
>>> What is your recommendation?
>> 
>> First, I suggest you fix the OFFOUTENABLE bug in a single patch
>> without introducing the #ifdefs.  Then, address the enable/disable of
>> the wakeups in a separate patch.
>
> I will do that.
>
>> Next, ideally wakeups should not be configured a this level of board
>> code.  There are APIs for that: enable_irq_wake()/disable_irq_wake()
>> 
>> For GPIOs (like the touchscreen), you really need to enable wakeups
>> using existing APIs, either in the driver or in board init code and be
>> sure there is an interrupt handler.  Please see the 'Known Problems'
>> section of the OMAP PM wiki[2] where it talks about GPIO wakeups.
>> Below[2] is an test patch I've used.
>
> I have pushed a patch on ads7846 to linux-input some time ago adding
> wakeup support.
>
> fdba2bb : Input: ads7846 - add wakeup support
>
> There is now a wakeup flag added to the ads7846 platform data which can
> enabled at the board level. Once this is set , the driver will do an
> enable_irq_wake. The patch is now accepted and in mainline. I will
> remove the wakeup mux configuration from the board file and instead will
> just set the wakeup flag in the ads7846 platform data.

Brilliant!  you're several steps ahead of me.  Would you mind
submitting a patch to l-o to enable that for SDP and omap3evm so I
can drop my suggested patch?

> The keypad uses a pin in the non-gpio mode. Is enable_irq_wake supported
> for non-gpio mode?

Not currently, as enable_irq_wake() ends up calling into the
irq_chip's set_wake() method.  This then calls into the OMAP GPIO
layer as plat-omap/gpio.c:gpio_wake_enable()

For now, the keypad could just use the mux API at runtime like SDP does
to enable wakeups when needed.

Kevin
