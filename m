From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/13] Revert "ARM: OMAP: Mask interrupts when disabling interrupts, v2"
Date: Fri, 22 May 2009 07:54:32 -0700
Message-ID: <87hbzd89xz.fsf@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
	<1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
	<4A15E5D9.7090704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f103.google.com ([209.85.216.103]:49906 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbZEVPAV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 11:00:21 -0400
Received: by pxi1 with SMTP id 1so1380913pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2009 08:00:23 -0700 (PDT)
In-Reply-To: <4A15E5D9.7090704@samsung.com> (Kim Kyuwon's message of "Fri\, 22 May 2009 08\:38\:01 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <q1.kim@samsung.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Kim Kyuwon <q1.kim@samsung.com> writes:

> Kevin Hilman wrote:
>> This reverts commit 5461af5af5c6a7fee78978aafe720541bf3a2f55.
>>
>> Adding a disable hook to the irq_chip is not the way to fix the
>> problem being addressed by this patch.  Instead, we need to fix
>> support for [enable|disable]_irq_wake().
>
> Agree with you if we can use disable_irq_wake for MPU Interrupt with
> not masking the IRQ. Can you explain how we can fix support for
> disable_irq_wake() for omap_irq_chip?

Yes.  The PRCM has a wake-enable per device bit that can be set (see
PM_WKEN_<pwrdm>) to control device wakeup enables.

But the implemenation of that should not hold up this revert because
this patch breaks *all* wakeups since the PRCM interrupt itself is
disabled in the suspend path.

As a workaround for your USB problem that this patch was initially
intended to fix you could manually disable USB OTG wakeups like this:

	wken = prm_read_mod_reg(CORE_MOD, PM_WKEN);
        wken &= ~OMAP3430_EN_HSOTGUSB; 
	prm_write_mod_reg(wken, CORE_MOD, PM_WKEN);
	
At least until the irq_wake stuff is fixed.

Kevin
