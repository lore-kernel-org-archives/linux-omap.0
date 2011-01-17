From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 18:05:36 +0530
Message-ID: <78caabae29d28f26d5d003eeb7e75526@mail.gmail.com>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com>
 <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com> <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34254 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752007Ab1AQMfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 07:35:39 -0500
Received: by fxm12 with SMTP id 12so6002047fxm.28
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 04:35:37 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Aaro Koskinen [mailto:aaro.koskinen@nokia.com]
> Sent: Monday, January 17, 2011 5:52 PM
> To: Santosh Shilimkar
> Cc: Aaro Koskinen; Tony Lindgren; rmk+kernel@arm.linux.org.uk;
> linux-omap@vger.kernel.org
> Subject: RE: Open issues after 2.6.38 merge window
>
> Hi,
>
> On Mon, 17 Jan 2011, Santosh Shilimkar wrote:
> >> Amstrad E3 fails during the boot. Bisection points to:
> >>
> >>  	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
> >>  	Author: Russell King <rmk+kernel@arm.linux.org.uk>
> >>  	Date:   Tue Jan 11 16:23:04 2011 +0000
> >>
> >>  	    ARM: sched_clock: allow init_sched_clock() to be called
> >> early
> >>
> >> The board does not have sched_clock(), although HAVE_SCHED_CLOCK
> is
> >> defined for all OMAP.
> >>
> > I guess above is sorted out by the attached patch from Paul.
>
> I don't see how it could help? Amstrad E3 is OMAP 15xx.
>
I read patch again and omap15xx is skipped. Not sure
why 15xx is skipped.

Regards,
Santosh
