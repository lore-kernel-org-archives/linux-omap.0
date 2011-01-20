From: Luke Gong <lukejgong@gmail.com>
Subject: Fail to suspend to ram: "Class driver suspend failed for cpu0"
Date: Thu, 20 Jan 2011 16:16:58 -0500
Message-ID: <AANLkTin-q5o1x=0Eu1HvwDZxuCAOsGiVySWHBuAW0v+C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41093 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab1ATVQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 16:16:59 -0500
Received: by wwa36 with SMTP id 36so1133381wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 13:16:58 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I have a beagle board with OMAP3530. I ported linux-omap-pm2.6.32 to
this board. When I want to let it suspend to ram, it fails and I get
the message "Class driver suspend failed for cpu0". Here is the log:

root@beagleboard:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
omapfb omapfb: timeout waiting for FRAME DONE
Class driver suspend failed for cpu0
Restarting tasks ... done.

*********************************************

Is there any idea to fix this problem? Thanks.

-- 
Luke
