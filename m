From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest OMAP4 build errors
Date: Wed, 7 Mar 2012 09:10:45 -0800
Message-ID: <20120307171044.GE12083@atomide.com>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk>
 <CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com>
 <20120306165545.GB15392@n2100.arm.linux.org.uk>
 <201203061701.54141.arnd@arndb.de>
 <20120307100615.GA17404@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22555 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932307Ab2CGRKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 12:10:53 -0500
Content-Disposition: inline
In-Reply-To: <20120307100615.GA17404@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

Arnd & Olof, some urgent changes are needed, see below.

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120307 01:34]:
> On Tue, Mar 06, 2012 at 05:01:53PM +0000, Arnd Bergmann wrote:
> > On Tuesday 06 March 2012, Russell King - ARM Linux wrote:
> > > On Tue, Feb 28, 2012 at 12:11:37PM +0200, Ohad Ben-Cohen wrote:
> > > > On Tue, Feb 28, 2012 at 12:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > I think 'depends' would be better here, because selecting IOMMU_SUPPORT
> > > > > has other side-effects that a user might not want. It's just as likely
> > > > > that someone wants to disable IOMMU_SUPPORT and needs to find OMAP_REMOTEPROC
> > > > > as wanting to enable OMAP_REMOTEPROC and having to find IOMMU_SUPPORT.
> > > > >
> > > > > In most cases, the defconfig should just set both.
> > > > 
> > > > Ok, 'depends on' it is.
> > > 
> > > We're a week on, which means I now have a full set of 7 builds on the
> > > website for OMAP4430 all of which have failed in part due to this
> > > as yet unresolved problem.
> > > 
> > > What's happening to get it fixed and those fixes into whatever tree is
> > > necessary for them (presumably arm-soc)?
> > 
> > Ohad has sent a series of patches for review and there were no comments
> > on those. The fix was part of it as far as I remember. I'm still waiting
> > for a pull request from Ohad.
> 
> Given that we're coming to the end of what could be the _final_ week
> before the merge window opens, this is not good news.  Read: maybe
> three days before final.
> 
> The fact is that OMAP is - yet again - in a totally rotten state in terms
> of what's queued up in the armsoc tree.  It is - yet again - completely
> unbuildable for many configurations.  Just go and have a look at:
> 
> 	http://www.arm.linux.org.uk/developer/build/
> 
> to see what an utterly crappy state OMAP is in again.  Last nights build
> was my tree plus latest arm-soc.  Some of those issues have patches (I
> had been applying one patch manually to the build tree) but that's not
> the point - they're not in arm-soc, so the OMAP code in arm-soc is not
> yet ready for mainline.

Yes looks like there's an issue with getting urgent patches applied into
the arm-soc tree.. The patches to fix these issues are known and
other issues and warnings should be all sorted out now except for some
MMC changes that are still being discussed.
 
> So, as OMAP is soo broken, and as promised after the last merge window -
> I don't want any OMAP stuff going upstream from armsoc until we get error
> free builds from the allno and old configs on the builder.

What I got queued up in fixes-non-critical-part2 should fix all those
errors and warnings.

Arnd & Olof, I've posted one fix that should be applied to arm-soc tree
at [1]. I've also posted a request to revert one commit in arm-soc tree
at [2].

As it seems that you did not apply those to arm-soc, please apply them,
or repull the following two branches ASAP:

Re-pull fixes-non-critical containing one revert:

Revert "ARM: OMAP2+: Fix multiple randconfig errors with SOC_OMAP and SOC_OMAP_NOOP"

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical

Re-pull cleanup again containing one fix:

ARM: OMAP2+: Fix L4_EMU_34XX_BASE error after iomap changes

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap cleanup

Note that the second one I just pushed, however the patch is known to
work for the build errors after merging arm-soc with Russell's changes.

Arnd & Olof, for future, how you want to handle urgent issues like this?

Regards,

Tony


[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg64149.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg64151.html
