From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP3: PM: ensure IO wakeups are properly disabled
Date: Fri, 13 Aug 2010 10:47:58 +0300
Message-ID: <20100813074757.GB12706@atomide.com>
References: <1281542626-4045-1-git-send-email-khilman@deeprootsystems.com>
 <1281609324.1861.6.camel@chotu>
 <20100812115107.GC6629@atomide.com>
 <1281614350.1861.14.camel@chotu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59521 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab0HMHsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 03:48:04 -0400
Content-Disposition: inline
In-Reply-To: <1281614350.1861.14.camel@chotu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

* Ameya Palande <ameya.palande@nokia.com> [100812 14:52]:
> On Thu, 2010-08-12 at 13:51 +0200, ext Tony Lindgren wrote:
> > * Ameya Palande <ameya.palande@nokia.com> [100812 13:28]:
> > > 
> > > On Wed, 2010-08-11 at 18:03 +0200, ext Kevin Hilman wrote:
> > > > From: Kevin Hilman <khilman@ti.com>
> > > > 
> > > > Commit 5a5f561 (convert OMAP3 PRCM macros to the _SHIFT/_MASK suffixes)
> > > > mistakenly removed the check for PER when disabling the IO chain.
> > > > ---
> > > > Tony, this should go in with fixes for -rc2
> 
> Kevin's patch seems to fix the serial port issue for sure, so we
> definitely need it. I just wanted to point out that there are more issue
> in CPUIDLE :)

Thanks for the clarification, adding to omap-fixes.

Tony
