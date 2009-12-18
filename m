From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: "Flush the D-cache during copy_user_highpage" breaks compile
	for v7 on -rc1
Date: Fri, 18 Dec 2009 15:43:59 +0000
Message-ID: <20091218154359.GA5527@n2100.arm.linux.org.uk>
References: <20091218031923.GA4575@atomide.com> <20091218081851.GB28704@n2100.arm.linux.org.uk> <20091218153512.GA30512@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45583 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbZLRPoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 10:44:25 -0500
Content-Disposition: inline
In-Reply-To: <20091218153512.GA30512@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Dec 18, 2009 at 09:35:12AM -0600, Olof Johansson wrote:
> Hi,
> 
> On Fri, Dec 18, 2009 at 08:18:52AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 17, 2009 at 07:19:24PM -0800, Tony Lindgren wrote:
> > > Hi Catalin,
> > > 
> > > You may have already run into this, but if not, looks like commit
> > > 115b22474eb1905da2f606a057da3455833333d3 breaks compile for v7:
> > > 
> > > arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
> > > arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
> > > 
> > > Undoing that makes it work again.
> > 
> > It's a combination of changes - my initial changes for fixing the ARMv7
> > DMA support went in last night, but were based on a tree older than
> > Catalin's changes, which had already been committed.
> > 
> > My test build didn't catch any of these - it's the usual problem that
> > there is no way to adequately build-test the ARM kernel in a reasonable
> > time anymore.
> 
> FWIW: I've added an omap3_defconfig, that should be a superset of the
> configs used on the OMAP3 boards, to catch as much as possible affecting
> those boards with one single build. Takes about 90 seconds for me to
> build on a $600 PC, and Stephen builds it for every linux-next too.

linux-next is fine if you're prepared to wait a minimum of 36-48 hours
between committing and seeing the results - that's unfortunately how
it works out if you're in the UK due to time zone differences.

The big problem is not so much how long a single build takes, but
all builds to get the required converage.  We have soo many combinations
and configurations that its now impossible to properly build-test changes.
It's become soo bad that for most of the changes I do, I hardly ever
bother doing in-depth build tests anymore.  And that applies inspite of
having a nice new Lenovo T500.

That's something I've repeatedly warned about, and been faced "but why
do we want to support a single kernel running on multiple platforms"
arguments...

My method of working now is based around doing my own build tests,
merging them into mainline and checking (next morning) the results from
kautobuild.  I really don't bother checking linux-next, because 36-48
hours is just far too long - by the time the results become available
I've moved already on.

Plus, lets not forget that kautobuild runs through every single ARM
configuration.  linux-next only does a subset.
