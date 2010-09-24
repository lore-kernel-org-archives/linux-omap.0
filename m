From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: runtime_pm_get_sync() from ISR with IRQs disabled?
Date: Thu, 23 Sep 2010 17:05:03 -0700
Message-ID: <8762xwnh00.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61041 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab0IXAFF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 20:05:05 -0400
Received: by pvg2 with SMTP id 2so522681pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 17:05:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Partha Basak <p-basak2@ti.com>, linux-omap@vger.kernel.org

Hello,

Looking for advice for a little runtime PM dilemma...

After some inactivity, a driver decides to supend iteslf using
pm_runtime_put_sync().

The device is now suspended, it's ->runtime_suspend() method has
disabled its clock, so its registers cannot be accessed anymore.

Now, as interrupts are still enabled, an interrupt for this device might
still arrive.  For example, if this device is a wakeup source, its
->runtime_suspend() method may not have masked its interrupt.

So, the IRQ fires, and the drivers ISR is called.  The driver wants to
access the device registers, but since it has been runtime suspended,
it's registers are not available.

The first reflex would be to simply do a pm_runtime_get_sync() in the
ISR, however this is not safe if the ISR is an IRQs-disabled handler (as
is the case for me, where the problematic handler is chained handler
used for demuxing GPIO IRQs.)

So, what is the "right" thing to do here?

A quick hack would be to for the drivers ISR to do a
pm_runtime_get_noresume() and directly call the its ->runtime_resume()
method, then do its normal stuff, followed by a pm_runtime_put() at the
end of the ISR.

Is this an acceptable hack given that it's only needed for the
increasingly rare cases of ISRs with interrupts disabled?

Or should we think of making a version of _get_sync() that is safe for
IRQs disabled contexts like this where we know the device is already
RPM_SUSPENDED?

Any advice appreciated...

Kevin
