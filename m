From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Suspend to RAM broken on BeagleBoard ?
Date: Fri, 10 Sep 2010 14:54:23 -0700
Message-ID: <87sk1h4640.fsf@deeprootsystems.com>
References: <20100910174814.6e5d439e@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:51480 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab0IJVy0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 17:54:26 -0400
Received: by pxi10 with SMTP id 10so1148164pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 10 Sep 2010 14:54:26 -0700 (PDT)
In-Reply-To: <20100910174814.6e5d439e@surf> (Thomas Petazzoni's message of
	"Fri, 10 Sep 2010 17:48:14 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:

> Hello,
>
> I've tested the current linux-omap Git tree and Kevin's pm-core branch
> on a BeagleBoard using the omap3_defconfig, and when trying a suspend
> to RAM, I get a "Class driver suspend failed for cpu0" :

> # echo mem > /sys/power/state 
> [   93.395050] PM: Syncing filesystems ... done.
> [   93.410827] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [   93.434570] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> [   93.458557] Suspending console(s) (use no_console_suspend to debug)
> [   93.590728] PM: suspend of devices complete after 119.629 msecs
> [   93.593902] PM: late suspend of devices complete after 3.112 msecs
> [   93.594421] Class driver suspend failed for cpu0

It's the CPUfreq driver that's failing to suspend.

> [   93.595153] PM: early resume of devices complete after 0.518 msecs
> [   93.887603] PM: resume of devices complete after 292.052 msecs
> [   93.922851] Restarting tasks ... done.
>
> Is this a known issue ?

Yes, CPUfreq is not supported in l-o master or pm-core (only in the full
pm branch.)  If you Kconfig out CPUfreq, this failure will go away.

[...]

Kevin
