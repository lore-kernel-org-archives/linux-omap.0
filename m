From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/2] part 2 of omap soc changes for v3.19
Date: Fri, 28 Nov 2014 12:22:47 -0800
Message-ID: <20141128202246.GT2817@atomide.com>
References: <pull-1416703431-245942>
 <201411281454.28102.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23044 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbaK1UZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 15:25:13 -0500
Content-Disposition: inline
In-Reply-To: <201411281454.28102.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, arm@kernel.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [141128 05:57]:
> On Sunday 23 November 2014, Tony Lindgren wrote:
> > The following changes since commit 9889278181bcdbae882664d8cee5bb0e064397e4:
> > 
> >   Merge tag 'for-v3.19/omap-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.19/soc (2014-11-14 10:25:12 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/hwmod-and-defconfig
> > 
> > for you to fetch changes up to 374a735894fe2fb82ba07c6e6b7d326640c1c17f:
> > 
> >   ARM: omap2plus_defconfig: enable ECAP and EHRPWM (2014-11-21 16:30:28 -0800)
> > 
> > ----------------------------------------------------------------
> > SoC related changes for omaps including hwmod clean-up for
> > DSS, and hwmod data for more UARTs and ADC. Also few defconfig
> > changes to enable devices found on am335x and am437x.
> 
> Hi Tony,
> 
> We have started doing the defconfig changes in a separate branch a while ago.
> I normally don't mess with the tags I got, but this one seemed easy enough
> to redo, as the defconfig changes are all on top.
> 
> I ended up pulling in only the commits before the defconfig changes into
> next/soc, and am cherry-picking the defconfig bits onto the next/defconfig
> branch. Hope that's ok for you.

Sure that's fine with me, I only have fixes coming up after the pending
pull requests.
 
> I checked that the defconfig changes are all harmless and do not depend
> on the other changes, but I may have missed something subtle, so please
> confirm that this is ok for you.

Should be just fine thanks.

Regards,

Tony
