From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod fixes for v3.19-rc
Date: Tue, 20 Jan 2015 08:00:20 -0800
Message-ID: <20150120160020.GB7718@atomide.com>
References: <alpine.DEB.2.02.1501042334250.28771@utopia.booyaka.com>
 <20150119194305.GE18552@atomide.com>
 <alpine.DEB.2.02.1501200647540.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40451 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbbATQDq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 11:03:46 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1501200647540.5450@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [150119 22:51]:
> Hi Tony
> 
> On Mon, 19 Jan 2015, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@pwsan.com> [150104 15:38]:
> > > The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> > > 
> > >   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> > > 
> > > are available in the git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19-rc/omap-fixes-a
> > > 
> > > for you to fetch changes up to 99d076b747455449b2eec9e37f3fb0bfdf51af32:
> > > 
> > >   MAINTAINERS: add maintainer for OMAP hwmod data (2015-01-02 16:24:27 -0700)
> > > 
> > > ----------------------------------------------------------------
> > > For v3.19-rc, fix some hwmod structure details for the OMAP DSS modules
> > > for DRA7xx and AM43xx.  Also update the MAINTAINERS file to encourage
> > > folks to cc me on hwmod data patches.
> > > 
> > > Basic build, boot, and PM testlogs are available here:
> > > 
> > > http://www.pwsan.com/omap/testlogs/omap-fixes-a-for-v3.19-rc/20150103144242/
> > 
> > Paul, got any updates on this? Anyways, I'll just untag this email as
> > you asked me to wait on pulling this.
> 
> At this point I think I will just requeue the remaining two valid patches 
> for v3.20.  Thanks for the ping

OK makes sense for me if they are not critical fixes.

Regards,

Tony
