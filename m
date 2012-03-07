From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Latest OMAP4 build errors
Date: Wed, 7 Mar 2012 10:06:15 +0000
Message-ID: <20120307100615.GA17404@n2100.arm.linux.org.uk>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk> <CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com> <20120306165545.GB15392@n2100.arm.linux.org.uk> <201203061701.54141.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39197 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711Ab2CGKGa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 05:06:30 -0500
Content-Disposition: inline
In-Reply-To: <201203061701.54141.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Tue, Mar 06, 2012 at 05:01:53PM +0000, Arnd Bergmann wrote:
> On Tuesday 06 March 2012, Russell King - ARM Linux wrote:
> > On Tue, Feb 28, 2012 at 12:11:37PM +0200, Ohad Ben-Cohen wrote:
> > > On Tue, Feb 28, 2012 at 12:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > I think 'depends' would be better here, because selecting IOMMU_SUPPORT
> > > > has other side-effects that a user might not want. It's just as likely
> > > > that someone wants to disable IOMMU_SUPPORT and needs to find OMAP_REMOTEPROC
> > > > as wanting to enable OMAP_REMOTEPROC and having to find IOMMU_SUPPORT.
> > > >
> > > > In most cases, the defconfig should just set both.
> > > 
> > > Ok, 'depends on' it is.
> > 
> > We're a week on, which means I now have a full set of 7 builds on the
> > website for OMAP4430 all of which have failed in part due to this
> > as yet unresolved problem.
> > 
> > What's happening to get it fixed and those fixes into whatever tree is
> > necessary for them (presumably arm-soc)?
> 
> Ohad has sent a series of patches for review and there were no comments
> on those. The fix was part of it as far as I remember. I'm still waiting
> for a pull request from Ohad.

Given that we're coming to the end of what could be the _final_ week
before the merge window opens, this is not good news.  Read: maybe
three days before final.

The fact is that OMAP is - yet again - in a totally rotten state in terms
of what's queued up in the armsoc tree.  It is - yet again - completely
unbuildable for many configurations.  Just go and have a look at:

	http://www.arm.linux.org.uk/developer/build/

to see what an utterly crappy state OMAP is in again.  Last nights build
was my tree plus latest arm-soc.  Some of those issues have patches (I
had been applying one patch manually to the build tree) but that's not
the point - they're not in arm-soc, so the OMAP code in arm-soc is not
yet ready for mainline.

So, as OMAP is soo broken, and as promised after the last merge window -
I don't want any OMAP stuff going upstream from armsoc until we get error
free builds from the allno and old configs on the builder.
