From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest OMAP4 build errors
Date: Wed, 7 Mar 2012 19:34:40 -0800
Message-ID: <20120308033439.GR12083@atomide.com>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk>
 <CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com>
 <20120306165545.GB15392@n2100.arm.linux.org.uk>
 <201203061701.54141.arnd@arndb.de>
 <20120307100615.GA17404@n2100.arm.linux.org.uk>
 <20120307171044.GE12083@atomide.com>
 <CAOesGMiNSyc9F+Wf5pXPG=hRAfnG6aMHtccLBwvekuB3HpyevQ@mail.gmail.com>
 <20120307224459.GJ12083@atomide.com>
 <20120307234308.GA20364@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14755 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab2CHDeq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 22:34:46 -0500
Content-Disposition: inline
In-Reply-To: <20120307234308.GA20364@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120307 15:11]:
> On Wed, Mar 07, 2012 at 02:44:59PM -0800, Tony Lindgren wrote:
> > OK thanks, will do that next time if there's something urgent.
> > 
> > I'll send a pull request shortly for fixes-non-critical-part2 that
> > should sort out the remaining issues.
> 
> FYI, I've just updated the build tree with what's in arm-soc (as of
> a couple of minutes ago), which contained a bunch of OMAP updates, so
> I'm hopeful that tomorrows results should show an improvement.
> 
> It'll start its run in about 2h20.

Looks like there one new section warning with omap_hsmmc_init_one
depending on the compiler. I'll post a fix for that.

Not seeing that with codesourcery/linaro compilers, but seeing
with the emdebian gcc 4.3.5.

Regards,

Tony
