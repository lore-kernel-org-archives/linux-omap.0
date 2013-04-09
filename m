From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/5] omap pm clean-up for v3.10 merge window
Date: Tue, 9 Apr 2013 09:56:33 -0700
Message-ID: <20130409165633.GN10155@atomide.com>
References: <0MarPy-1U9XGk2D8s-00Ks1o@mx.kundenserver.de>
 <201304091652.28385.arnd@arndb.de>
 <87vc7virqz.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13196 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763142Ab3DIQ4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 12:56:40 -0400
Content-Disposition: inline
In-Reply-To: <87vc7virqz.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@linaro.org> [130409 09:43]:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Tuesday 09 April 2013, Tony Lindgren wrote:
> >> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> >> 
> >>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> >> 
> >> are available in the git repository at:
> >> 
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/cleanup-pm-signed
> >> 
> >> for you to fetch changes up to ca8cdff548da76da01f3783548ceb917139a5ddc:
> >> 
> >>   Merge tag 'omap-pm-v3.10/cleanup/cpuidle' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm
> >> into omap-for-v3.10/cleanup-pm (2013-04-08 09:51:00 -0700)
> >> 
> >> ----------------------------------------------------------------
> >> 
> >> PM cleanup to prepare for omap5 PM via Kevin Hilman <khilman@linaro.org>:
> >> 
> >> OMAP3/4 CPUidle cleanups for v3.10
> >
> > Adding Daniel and Rafael to Cc.
> >
> > Is this series coordinated with the other cpuidle changes? Please tell me if this
> > is good to go into arm-soc.
> 
> Hmm, looks like it's not ready.  There are some minor conflicts with
> what Rafael has queued up from Daniel.
> 
> I will work this out with Daniel to figure out how we should proceed.

OK it seems that this branch can also be queued by Rafael after
updating it if there's a dependency. So far it's not conflicting
with anything else we have queued up for arm soc tree.

Regards,

Tony
