From: Cliff Brake <cliff.brake@gmail.com>
Subject: omap-pm: no_console_suspend breaks resume
Date: Fri, 7 May 2010 18:06:55 -0400
Message-ID: <x2gf96d234e1005071506l1a907d69r7ca218a11d93287f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43845 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab0EGWG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 18:06:58 -0400
Received: by wyg36 with SMTP id 36so1173958wyg.19
        for <linux-omap@vger.kernel.org>; Fri, 07 May 2010 15:06:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I've been experiementing with the omap-pm branch on a overo.  The
no_console_suspend seems to cause the system to not suspend/resume
properly.  Without the option:

root@ts3:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: suspend of devices complete after 109.710 msecs
PM: late suspend of devices complete after 0.305 msecs
Wake up daisy chain activation failed.
Successfully put all powerdomains to target state
PM: early resume of devices complete after 0.061 msecs
PM: resume of devices complete after 304.229 msecs
Restarting tasks ... done.
root@ts3:~#


With the option:
root@ts3:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
PM: suspend of devices complete after 106.811 msecs
PM: late suspend of devices complete after 0.305 msecs
(the current is quite high at this point, so I don't think we ever got
into suspend)

is no_console_suspend working for other people?

Thanks,
Cliff
