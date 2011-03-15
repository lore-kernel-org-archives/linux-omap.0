From: Kevin Hilman <khilman@ti.com>
Subject: Re: Question regarding suspend/resume
Date: Tue, 15 Mar 2011 13:11:42 -0700
Message-ID: <87wrk0gn41.fsf@ti.com>
References: <4D7FBD31.6050806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50105 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757677Ab1COULt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 16:11:49 -0400
Received: by mail-gx0-f169.google.com with SMTP id 23so514043gxk.14
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 13:11:45 -0700 (PDT)
In-Reply-To: <4D7FBD31.6050806@gmail.com> (Peter Barada's message of "Tue, 15
	Mar 2011 15:25:37 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: Linux OMAP list <linux-omap@vger.kernel.org>

Peter Barada <peter.barada@gmail.com> writes:

> Is there any reference how to decode the output of
> /debug/pm_debug/count?  I'm trying to figure out when I resume why it
> says the core_pwrdm didn't enter the target state, and I'm assuming
> because a clock used is not disabled in the suspend path, but as fars
> as I can tell there's no output in the pm_debug code that tells which
> clocks in a power domain are active at the time of a suspend.

You're right.

What you need the patch in my pm-wip/debug branch from my pm tree[1].
With that patch, it takes a snapshot of the PRCM registers just before
and after suspend.

When you come back from suspend, view the register snapshot just before
suspend:

# cat /debug/pm_debug/register/1  

and the register snapshot just after

# cat /debug/pm_debug/register/2

the snapshot just before suspend is useful for debugging problems like
yours, and the snapshot just after can be useful for debugging wakeups.

Feel free to post the register dump if you want some help deciphering
it.  If you do, please post more details on what kernel you're using as
well as the bootloader etc.

One of the common root causes for a problem like yours is a bootloader
that leaves a particular module in a state that it cannot properly
idle.  If the kernel is not using that particular device and/or has not
reset that device, the result is the powerdomain for that device can not
hit idle and you'll have a problem like yours.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
