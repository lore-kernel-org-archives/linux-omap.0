From: Jean Pihet <jpihet@mvista.com>
Subject: 2.6.29 PM and CPUIDLE
Date: Fri, 10 Apr 2009 16:54:58 +0200
Message-ID: <200904101654.58917.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:35601 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZDJOzL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Apr 2009 10:55:11 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

I am having problems using CPUIDLE PM_SLEEP on Beagleboard with the latest pm 
tree.
It looks like CPUIDLE prevents the system to go into retention mode, while it 
works fine without CPUIDLE enabled:

root@beagleboard:~# echo 1 > /sys/power/clocks_off_while_idle
root@beagleboard:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
omapfb omapfb: timeout waiting for FRAME DONE
Powerdomain (core_pwrdm) didn't enter target state 1
Powerdomain (dss_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
Restarting tasks ... done.

The registers dump shows the next power state in PM_PWSTCTRL is set to ON 
instead of RET for MPU and CORE. Furthermore DSS is not reaching RET (stays 
ON).

Are the CPUIDLE and suspend/resume features compatible with each other? Am I 
missing something, e.g. a way to change the behavior from /sys?

Regards,
Jean
