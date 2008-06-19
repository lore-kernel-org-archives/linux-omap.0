From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: FW: [PATCH] suppress needless timer reprogramming {tick-sched.c} -
 test/comment
Date: Thu, 19 Jun 2008 07:54:19 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035B9BE166@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48966 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbYFSMy0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jun 2008 08:54:26 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m5JCsK1S032059
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 19 Jun 2008 07:54:25 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m5JCsK8u014454
	for <linux-omap@vger.kernel.org>; Thu, 19 Jun 2008 07:54:20 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I'll resend this to the omap list.  I had originally sent it with some pictures but I guess they were too big for the lists.  Individual should have got them.

If anyone has the time this is a good to test with.  If you have dynamic tick enabled it can double performance of high rate interrupt things like MUSB.

If anyone wants I'll re-send larger trace pictures individually.


> From: Woodruff, Richard, Monday, June 16, 2008 7:06 PM
>
> It simply does a check to see if the about to be reprogrammed 1 shot
> already is the last event programmed in the hardware.  If it is it skips
> calling the hardware.
>
> In my device I get many interrupts from a high speed USB device in a
> very short period of time.  The system spends a lot of time
> reprogramming the hardware timer which is in a slower timing domain as
> compared to the CPU.  This results in the CPU spending a huge amount of
> time waiting for the timer posting to be done.  All of this
> reprogramming is useless as the wake up time has not changed.
>
> As measured using ETM trace this drops my reprogramming penalty from
> almost 60% CPU load down to 15% during high interrupt rate.  If you like
> I can send traces to show this.

Attached are some results on OMAP-ARM from USB-OTG:

As host:

root@OMAP3EVM /]# mount -t vfat /dev/sda1 /mnt/
[root@OMAP3EVM /]# time -p cp /mnt/OE.mtn.bz2 /dev/null
real 32.51
user 0.02
sys 1.05
[root@OMAP3EVM /]# umount /mnt/
[root@OMAP3EVM /]# mount -t vfat /dev/sda1 /mnt/
[root@OMAP3EVM /]# time -p cp /mnt/OE.mtn.bz2 /dev/null
real 17.92
user 0.05
sys 1.57

As Client:

Attached are some visuals as of client doing gadget zero tests.  Pictures clearly show before a domination by timer reprogram and after not.

Regards,
Richard W.


diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b854a89..ff6b967 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -254,6 +254,17 @@ void tick_nohz_stop_sched_tick(void)
        /* Schedule the tick, if we are at least one jiffie off */
        if ((long)delta_jiffies >= 1) {

+               /*
+               * calculate the expiry time for the next timer wheel
+               * timer
+               */
+               expires = ktime_add_ns(last_update, tick_period.tv64 *
+                                  delta_jiffies);
+
+               /* Skip reprogram of event if its not changed */
+               if(ts->tick_stopped && ktime_equal(expires, dev->next_event))
+                       goto out2;
+
                if (delta_jiffies > 1)
                        cpu_set(cpu, nohz_cpu_mask);
                /*
@@ -304,12 +315,7 @@ void tick_nohz_stop_sched_tick(void)
                        goto out;
                }

-               /*
-                * calculate the expiry time for the next timer wheel
-                * timer
-                */
-               expires = ktime_add_ns(last_update, tick_period.tv64 *
-                                      delta_jiffies);
+               /* Mark expiries */
                ts->idle_expires = expires;

                if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
@@ -328,6 +334,7 @@ void tick_nohz_stop_sched_tick(void)
                tick_do_update_jiffies64(ktime_get());
                cpu_clear(cpu, nohz_cpu_mask);
        }
+out2:
        raise_softirq_irqoff(TIMER_SOFTIRQ);
 out:
        ts->next_jiffies = next_jiffies;
