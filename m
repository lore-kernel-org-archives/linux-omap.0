From: <shivananda.hebbarp@wipro.com>
Subject: PM Issues after Android bootup on 2430
Date: Tue, 29 Apr 2008 20:49:16 +0530
Message-ID: <70E3BF80B2DA6E469688AD5C3BBCC6C40365F3B7@BLR-EC-MBX02.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wipro-blr-out01.wipro.com ([203.91.198.74]:25971 "EHLO
	wipro-blr-out01.wipro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbYD2PTT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2008 11:19:19 -0400
Received: from blr-ec-bh01.wipro.com (unknown [10.201.50.91])
	by wipro-blr-out01.wipro.com (Symantec Mail Security) with ESMTP id 540414E4002
	for <linux-omap@vger.kernel.org>; Tue, 29 Apr 2008 20:49:17 +0530 (IST)
Content-class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi ,
 
I am seeing some issues after booting up customized android kernel on
2430. I have taken the 2.23 kernel extracted from the SDK (2.6.23,
m5-rc14) and applied the changes to 2.6.14 OMAP linux kernel.
 
I am able to see the GUI after a duration of ~ 10 to 15 minutes. I have
followed the steps mentioned in the Wiki as well as emails chains for
issues while porting it to 2430.
 
After initial display ,successfully transits from sleep to active  mode
twice .But Third time fails. Transition from sleep to normal mode was
done by pressing the key on the hardware keypad.
LCD switches off and console hangs.
Here is the trace from my console:
----------------------------------------------------
# android_power_suspend: 1604321547460
android sleep state 0->2 at 1604321547460
active wake lock PowerManagerService
android_power_suspend: enter suspend
Stopping tasks ... done.
Suspending console(s)
Restarting tasks ... android_power_wakeup 2->0 at 1604535606537
done.
android_power_suspend: exit suspend, ret = 0
android_power_suspend: done
 
# android_power_suspend: 1659940954691
android sleep state 0->2 at 1659940954691
active wake lock PowerManagerService
android_power_suspend: 1659960619076
android_power_suspend: enter suspend
Stopping tasks ... done.
Suspending console(s)
omapfb omapfb: irq error status 00e2
omapfb omapfb: irq error status 0040
omapfb omapfb: irq error status 0040
omapfb omapfb: irq error status 0040
omapfb omapfb: irq error status 0040
omapfb omapfb: irq error status 0040
omapfb omapfb: irq error status 0040
omapfb omapfb: irq error status 0040
omapfb omapfb: irq error status 0040
omapfb omapfb: irq error status 0040
Restarting tasks ... android_power_wakeup 2->0 at 1660136538459
done.
android_power_suspend: exit suspend, ret = 0
android_power_suspend: done
 
#
#
# android_power_suspend: 1807690295383
android sleep state 0->2 at 1807690295383
active wake lock PowerManagerService
android_power_suspend: enter suspend
Stopping tasks ... done.
Suspending console(s)
------------------------------------------------------------------------
-----
Pls Let me know if you have any inputs on this. 
 
Regards,
Shivananda

