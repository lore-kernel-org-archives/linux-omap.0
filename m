From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
Date: Thu, 17 May 2012 16:56:48 -0700
Message-ID: <87mx56s6nz.fsf@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
	<1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
	<87y5oqtpnw.fsf@ti.com> <20120517231251.GH17852@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:38828 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751931Ab2EQX4u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 19:56:50 -0400
Received: by dadv2 with SMTP id v2so3266006dad.32
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 16:56:48 -0700 (PDT)
In-Reply-To: <20120517231251.GH17852@atomide.com> (Tony Lindgren's message of
	"Thu, 17 May 2012 16:12:52 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, "Cousson, Benoit" <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [120517 15:29]:
>> 
>> I just noticed that this patch has caused some strange problems, notably
>> with the GPIO IRQ used by smsc911x NIC (Overo, Zoom3, 2430SDP, etc. etc.)
>> 
>> The patch itself is OK, but it has exposed a bug in other parts of the
>> context restore path that was previously hidden.
>> 
>> We seem to have been finding lots of GPIO bugs by just testing the
>> network chips with GPIO IRQs.  Can I suggest that a platform with a GPIO
>> IRQ NIC be added to the test platforms you're using? 
>
> Yes considering the breakage it's pretty obvious the original series was
> never properly tested on omaps.

Agreed.

> Regarding this fix, using gpio/next + this patch fixes nfsroot for 2430sdp,
> and gets zoom3 nfsroot booting going a bit better.
>
> However, at least on zoom3 nfsroot now takes several _minutes_ to get to
> login: with gpio/next + this patch. The system is totally unusable.
>
> It seems that the GPIO interrupt wake-up events are not properly working
> now?
>
> Reverting the "gpio/omap: fix missing check in *_runtime_suspend()"
> patch seems to fix the issue.

Argh, then $SUBJECT patch here has caused brokeness in multiple ways.
It managed to break both runtime suspend and runtime resume at the same
time. :(

The change added by this patch to runtime_suspend effectively disables
the fix I did in 68942edb09 (gpio/omap: fix wakeups on level-triggered GPIOs)
causing the sluggish network problems to reappear, since that GPIO IRQ
is no longer causing wakeups.

Simple fix is below, which just moves the check added in $SUBJECT patch
below the workaround for the edge/level fix.  Can you confirm it works
on Zoom3 (applies on gpio/next + my previous fix.)

I didn't notice the same problem on Overo, but I guess it's because
Overo had some enabled non-wakeup GPIOs in the same bank, so it didn't
bypass the level-triggered IRQ fix.

>> Subject: [PATCH] gpio/omap: fix broken context restore for non-OFF mode
>>  transitions
>> 
>> The fix in commit 1b12870 (gpio/omap: fix missing check in
>> *_runtime_suspend()) exposed another bug in the context restore path.
>
> Kevin, looks like commit 1b12870 does not exist in gpio/next?

Will update the changelog.

Because of this new problem, I have to add the patch below too, so
I'll get them both queued up for Grant

In the mean time, they're availble in my for_3.5/fixes/gpio-2 branch.

Kevin

[1]
>From afb4f0836dc3c432aa999fc98a80bf75e1481e04 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 17 May 2012 16:42:16 -0700
Subject: [PATCH] gpio/omap: (re)fix wakeups on level-triggered GPIOs

commit 1b1287032 (gpio/omap: fix missing check in *_runtime_suspend())
broke wakeups on level-triggered GPIOs by adding the enabled
non-wakeup GPIO check before the workaround that enables wakeups
on level-triggered IRQs, effectively disabling that workaround.

To fix, move the enabled non-wakeup GPIO check after the
level-triggered IRQ workaround.

Reported-by: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio-omap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index b570a6a..c4ed172 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1157,9 +1157,6 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 
 	spin_lock_irqsave(&bank->lock, flags);
 
-	if (!bank->enabled_non_wakeup_gpios)
-		goto update_gpio_context_count;
-
 	/*
 	 * Only edges can generate a wakeup event to the PRCM.
 	 *
@@ -1180,6 +1177,9 @@ static int omap_gpio_runtime_suspend(struct device *dev)
 		__raw_writel(wake_hi | bank->context.risingdetect,
 			     bank->base + bank->regs->risingdetect);
 
+	if (!bank->enabled_non_wakeup_gpios)
+		goto update_gpio_context_count;
+
 	if (bank->power_mode != OFF_MODE) {
 		bank->power_mode = 0;
 		goto update_gpio_context_count;
-- 
1.7.9.2

