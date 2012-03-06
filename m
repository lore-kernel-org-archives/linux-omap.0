From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Latest OMAP4 build errors
Date: Tue, 6 Mar 2012 17:01:53 +0000
Message-ID: <201203061701.54141.arnd@arndb.de>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk> <CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com> <20120306165545.GB15392@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61692 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab2CFRCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 12:02:01 -0500
In-Reply-To: <20120306165545.GB15392@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Tuesday 06 March 2012, Russell King - ARM Linux wrote:
> On Tue, Feb 28, 2012 at 12:11:37PM +0200, Ohad Ben-Cohen wrote:
> > On Tue, Feb 28, 2012 at 12:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > I think 'depends' would be better here, because selecting IOMMU_SUPPORT
> > > has other side-effects that a user might not want. It's just as likely
> > > that someone wants to disable IOMMU_SUPPORT and needs to find OMAP_REMOTEPROC
> > > as wanting to enable OMAP_REMOTEPROC and having to find IOMMU_SUPPORT.
> > >
> > > In most cases, the defconfig should just set both.
> > 
> > Ok, 'depends on' it is.
> 
> We're a week on, which means I now have a full set of 7 builds on the
> website for OMAP4430 all of which have failed in part due to this
> as yet unresolved problem.
> 
> What's happening to get it fixed and those fixes into whatever tree is
> necessary for them (presumably arm-soc)?

Ohad has sent a series of patches for review and there were no comments
on those. The fix was part of it as far as I remember. I'm still waiting
for a pull request from Ohad.

	Arnd
