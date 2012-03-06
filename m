From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Latest OMAP4 build errors
Date: Tue, 6 Mar 2012 16:55:45 +0000
Message-ID: <20120306165545.GB15392@n2100.arm.linux.org.uk>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk> <CAK=WgbZeeLxewPhxVpcAsNNeKYuzLojDZUm_=GmUgSh8kwvWUQ@mail.gmail.com> <201202281001.23011.arnd@arndb.de> <CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50018 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab2CFQz5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 11:55:57 -0500
Content-Disposition: inline
In-Reply-To: <CAK=WgbZEDr_fYSonBQr3XNcTx5vefsH7LJfqycaxsqg-yechWQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Tue, Feb 28, 2012 at 12:11:37PM +0200, Ohad Ben-Cohen wrote:
> On Tue, Feb 28, 2012 at 12:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I think 'depends' would be better here, because selecting IOMMU_SUPPORT
> > has other side-effects that a user might not want. It's just as likely
> > that someone wants to disable IOMMU_SUPPORT and needs to find OMAP_REMOTEPROC
> > as wanting to enable OMAP_REMOTEPROC and having to find IOMMU_SUPPORT.
> >
> > In most cases, the defconfig should just set both.
> 
> Ok, 'depends on' it is.

We're a week on, which means I now have a full set of 7 builds on the
website for OMAP4430 all of which have failed in part due to this
as yet unresolved problem.

What's happening to get it fixed and those fixes into whatever tree is
necessary for them (presumably arm-soc)?
