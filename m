From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Tue, 10 Jul 2012 16:58:18 -0700
Message-ID: <87zk77p3s5.fsf@ti.com>
References: <WC20120705150314.450045@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:48582 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755384Ab2GJX6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jul 2012 19:58:21 -0400
Received: by pbbro8 with SMTP id ro8so1012904pbb.25
        for <linux-omap@vger.kernel.org>; Tue, 10 Jul 2012 16:58:19 -0700 (PDT)
In-Reply-To: <WC20120705150314.450045@terrafix.co.uk> (Joe Woodward's message
	of "Thu, 05 Jul 2012 16:03:14 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Joe Woodward" <jw@terrafix.co.uk> writes:

> I've got 3.5-rc5 with the following patches applied to get system suspend working on OMAP3:
>   - fix the DSS: OMAPDSS: Use PM notifiers for system suspend
>   - fix the 32KHz clock: ARM: OMAP2+: hwmod code/clockdomain data: fix 32K sync timer
>
> This has been built with the omap2plus_defconfig.
>
> However, If I disable the RTC (i.e. CONFIG_RTC_CLASS/CONFIG_RTC_DRV_TWL4030) and rebuild then when suspending the device never wakes up.
>
> That is, I can't get any wakeups to happen (either through the console, or GPIO buttons) hence I'm assuming the kernel has crashed...
>
> Any ideas?
>
> As far as I know there is no dependency on the RTC in 3.4, and with the RTC compiled in I never see a problem on 3.5-rc5.

There is definitely a bug in the EHCI driver in v3.5 that cause a hang
in suspend, but the RTC connection is very strange.

I was not able to reproduce this.

Can you try the same with my current 'pm' branch[1].  I've got a handful
of additional fixes there for various other problems where both MMC and
EHCI are preventing sucessful suspend with the default
omap2plus_defconfig.  (note the EHCI fix is simply diabling it in the
defconfig.)

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm
