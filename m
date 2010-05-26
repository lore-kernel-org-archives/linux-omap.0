From: uthappa <uthappa@mistralsolutions.com>
Subject: Delay in performing "suspend-to-ram" issued via RT thread
	(SCHED_FIFO)
Date: Wed, 26 May 2010 17:37:34 +0530
Message-ID: <1274875654.12225.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from blrmail.mistralsolutions.com ([220.227.112.130]:2965 "EHLO
	mistralsolutions.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757251Ab0EZMHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 May 2010 08:07:00 -0400
Received: from [10.20.30.50] by mistralsolutions.com (Cipher SSLv3:RC4-MD5:128) (MDaemon PRO v10.0.5)
	with ESMTP id md50003411336.msg
	for <linux-omap@vger.kernel.org>; Wed, 26 May 2010 17:36:24 +0530
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hello Everyone,

	I am currently working with the linux 2.6.29-omap1 kernel. Right now I
am porting a legacy application code that puts the OMAP 5912 host to
sleep. The host wakes up after 4 secs via an RTC interrupt which is
configured to be the wake-up source. Everything seems to be fine running
in a loop. The system wakes up and goes back to sleep in 4 seconds every
time. But I am observing a behavior that I am unable to explain. The
legacy application thread that puts the system to sleep is originally an
RT thread with the scheduling policy (SCHED_FIFO) and priority 5. The
thread runs in a loop. The following bash script mimics the behavior of
this thread exactly (however you will probably need some wake up source
like an RTC interrupt to try it on your side):

## Script start #############################

#!/bin/bash

NAME_OF_THE_SCRIPT=`basename $0`

SELF_PID=`pidof $NAME_OF_THE_SCRIPT`
/usr/bin/chrt -f -p 5 $SELF_PID

sleep 1

while (true)
do
        echo mem > /sys/power/state
        usleep 30000
done

## Script end ###############################

	With this thread running, I see the following messages looping
repeatedly on the target console screen:

## Console o/p start #############################

PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.92 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.99 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: OMAP16212316 is trying to enter deep sleep...
PM: OMAP16212316 is re-starting from deep sleep...
Restarting tasks ... RTC IRQ cleared
done.
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.90 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.99 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: OMAP16212316 is trying to enter deep sleep...
PM: OMAP16212316 is re-starting from deep sleep...
Restarting tasks ... RTC IRQ cleared
done.
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.92 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.99 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: OMAP16212316 is trying to enter deep sleep...
PM: OMAP16212316 is re-starting from deep sleep...
Restarting tasks ... RTC IRQ cleared
done.

## Console o/p end ###############################

	You can observe from the above messages that the elapsed time in
"Freezing" the user processes is in the order of around 0.9 seconds.
Also, (although not evident here) when the message "Restarting
tasks ..." appears it takes around a second for the "done." message to
follow.

	Now comes the fun part. When I do not fiddle around with the scheduling
policy and priority of the legacy RT thread and just let it be a normal
user space thread (SCHED_OTHER with priority 20, nice 0) (You can
achieve this in the script that I shared with you all by simply
commenting out the command that says "/usr/bin/chrt -f -p 5 $SELF_PID").
Then there is almost no delay at all during "Freezing" and
"Restarting" (I should probably call this "Thawing") the user space
tasks. That is, I now have the following console o/p:

## Console o/p start #############################

PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: OMAP16212316 is trying to enter deep sleep...
PM: OMAP16212316 is re-starting from deep sleep...
Restarting tasks ... RTC IRQ cleared
done.
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: OMAP16212316 is trying to enter deep sleep...
PM: OMAP16212316 is re-starting from deep sleep...
Restarting tasks ... RTC IRQ cleared
done.
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: OMAP16212316 is trying to enter deep sleep...
PM: OMAP16212316 is re-starting from deep sleep...
Restarting tasks ... RTC IRQ cleared
done.

## Console o/p end ###############################

	As you can see from the above log that the time elapsed during freeze
is now reported as 0.00 seconds. And I observed here that there is no
time delay between printing "Restarting tasks ..." and "done.".

	I am having a tough time searching for an explanation to this behavior.
And I hoping that some of you might have already experienced this
behavior or knows what is happening and can explain this to me.

	Many thanks in advance.

Best regards,
Uthappa



Please do not print this email unless it is absolutely necessary. Spread environmental awareness.

-------------------------------------------------------DISCLAIMER------------------------------------------------------
The information transmitted herewith is confidential and proprietary information intended only for use by the individual or entity to which it is addressed. If the reader of this message is not the intended recipient, you are hereby notified that any review, retransmission, dissemination, distribution, copying or other use of, or taking of any action in reliance upon this information is strictly prohibited. If you have received this communication in error, please contact the sender and delete the material from your computer.
---------------------------------------------------------------------------------------------------------------------------

