From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 RESEND 0/7] gpio/omap: Some more driver fixes
Date: Wed, 21 Mar 2012 14:34:37 +0000
Message-ID: <20120321143437.8AF563E0648@localhost>
References: <1332240799-6748-1-git-send-email-tarun.kanti@ti.com> <20120320143544.AA6E93E2834@localhost> <87haxj17xq.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48973 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964786Ab2CVJLd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 05:11:33 -0400
Received: by wibhj6 with SMTP id hj6so481996wib.1
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 02:11:32 -0700 (PDT)
In-Reply-To: <87haxj17xq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, 20 Mar 2012 10:46:57 -0700, Kevin Hilman <khilman@ti.com> wrote:
> Hi Grant,
> 
> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > On Tue, 20 Mar 2012 16:23:12 +0530, Tarun Kanti DebBarma <tarun.kanti@ti.com> wrote:
> >> This series excludes the cleanup patches as suggested by Kevin from
> >> the previously posted series.
> >> 
> >> The fixes include correction of _set_gpio_irqenable() implementation,
> >> missing wakeup_en register update in set_gpio_wakeup(), type mismatch
> >> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
> >> register update in set_gpio_dataout_() and few corrections in context
> >> save logic.
> >> 
> >> It is baselined on top of:
> >> git://git.secretlab.ca/git/linux-2.6.git gpio/next
> >> Commit: 81b279d80a63628e580c71a31d30a8c3b3047ad4
> >> 
> >> Series is available here for reference:
> >> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_more_fixes
> >
> > Merged; thanks
> 
> Can you hold off slightly before merging this.
> 
> I haven't been through v4 yet or tested the fixes alone now that they're
> separated from the other cleanups.
> 
> Expect a pull request from me when ready.

Okay.  It's in linux-next at the moment, but I'll pull it back out.

g.

