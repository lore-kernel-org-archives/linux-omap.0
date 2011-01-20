From: Kevin Hilman <khilman@ti.com>
Subject: Re: Fail to suspend to ram: "Class driver suspend failed for cpu0"
Date: Thu, 20 Jan 2011 14:54:51 -0800
Message-ID: <8762tjjidg.fsf@ti.com>
References: <AANLkTin-q5o1x=0Eu1HvwDZxuCAOsGiVySWHBuAW0v+C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:32858 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755760Ab1ATWyz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 17:54:55 -0500
Received: by mail-iy0-f182.google.com with SMTP id 26so1162962iyb.41
        for <linux-omap@vger.kernel.org>; Thu, 20 Jan 2011 14:54:54 -0800 (PST)
In-Reply-To: <AANLkTin-q5o1x=0Eu1HvwDZxuCAOsGiVySWHBuAW0v+C@mail.gmail.com>
	(Luke Gong's message of "Thu, 20 Jan 2011 16:16:58 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Luke Gong <lukejgong@gmail.com>
Cc: linux-omap@vger.kernel.org

Luke Gong <lukejgong@gmail.com> writes:

> I have a beagle board with OMAP3530. I ported linux-omap-pm2.6.32 to
> this board. When I want to let it suspend to ram, 

This is an old kernel.  Any reason you're not using a newer kernel?

> it fails and I get
> the message "Class driver suspend failed for cpu0"

This is the CPUfreq driver failing to suspend, probably because there is
no CPUfreq driver implemented in your kernel.  Try disabling CPU_FREQ in
your kernel config.

Kevin

> . Here is the log:
>
> root@beagleboard:~# echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> omapfb omapfb: timeout waiting for FRAME DONE
> Class driver suspend failed for cpu0
> Restarting tasks ... done.
>
> *********************************************
>
> Is there any idea to fix this problem? Thanks.
