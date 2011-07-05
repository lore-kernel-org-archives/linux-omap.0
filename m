From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 00/20] GPIO: OMAP: driver cleanup and fixes
Date: Tue, 05 Jul 2011 16:46:11 -0700
Message-ID: <87liwcp9z0.fsf@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:38666 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751449Ab1GEXqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 19:46:16 -0400
Received: by mail-iw0-f177.google.com with SMTP id 35so6842255iwn.8
        for <linux-omap@vger.kernel.org>; Tue, 05 Jul 2011 16:46:15 -0700 (PDT)
In-Reply-To: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 1 Jul 2011 15:16:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.
>
> Baseline: git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
> Branch: wip/gpio-cleanup

This fails to boot for me on 4430/Blaze and 3630/Zoom3.

In both cases, I have these boards setup for NFS root, and it appears
that the IRQ setup (specifically triggering) is failing during init, so
the result is no ethernet interface is detected in either case.

Here's the example error from 3630/Zoom3:

[    1.565338] smsc911x: Driver version 2008-10-21                          
[    1.570373] setting trigger mode 8 for irq 318 failed (gpio_irq_type+...)
[    1.577941] smsc911x: probe of smsc911x.0 failed with error -22              

and a similar thing happens on Blaze but with errors from the SPI NIC.

> Test Details:
> - Compile tested for omap1_defconfig and omap2plus_defconfig.
> - OMAP1710-H3: Bootup test.
> - OMAP2430-SDP, OMAP3430-SDP, OMAP4430-SDP: Functional testing. 

Looks like the functional tests need to be expanded to set different
triggering modes, since they're failing above.

> - PM Testing on OMAP3430-SDP: retention, off_mode, system_wide
>   suspend and gpio wakeup.
>
> Following patch is required for testing retention and off-mode:
> https://patchwork.kernel.org/patch/834372/
> OMAP: PM: omap_device: fix device power domain callbacks

FYI... for my testI applied your series on top of my
for_3.1/gpio-cleanups branch and then merged in my for_3.0/pm-fixes
branch (which includes the above fix/dependency).

Kevin
