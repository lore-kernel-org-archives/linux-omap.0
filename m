From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap dss board clean-up for v3.10 merge window
Date: Fri, 19 Apr 2013 12:33:46 -0700
Message-ID: <20130419193346.GO10155@atomide.com>
References: <20130418033936.GC10155@atomide.com>
 <20130419184518.GA30836@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24638 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab3DSTdv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 15:33:51 -0400
Content-Disposition: inline
In-Reply-To: <20130419184518.GA30836@quad.lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

* Olof Johansson <olof@lixom.net> [130419 11:50]:
> Hi,
> 
> On Wed, Apr 17, 2013 at 08:39:37PM -0700, Tony Lindgren wrote:
> > The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> > 
> >   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/dss-signed
> 
> 
> Merged, but not happy about it.
> 
> As mentioned on IRC, I was going to let this one be until 3.11, but it sounds
> like it will cause regressions in DSS if we don't merge it.
> 
> This is an indication that the work wasn't done right on the DSS rework.
> Ideally the old configurations through platform_data should have been left in
> for a release to give the boards a window to convert over without regressing
> functionality. Tomi, please don't do it this way in the future since it's
> painful for everybody to deal with.

Yes sorry this should have been done already few weeks ago when these
patches hit linux next via Tomi's tree. In the future, let's plan on doing
the shared branches early on between -rc2 and -rc4 so we don't all have to
scramble just before the merge window.

> I've queued this with late/cleanup. I noticed some conflicts with the previous
> omap/fixes-non-critical and omap/boards branches that I brought in as a base so
> I could fix it up in my merge instead of having it go all the way up to Linus
> to resolve.

OK thanks.

Tony
