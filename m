From: Olof Johansson <olof@lixom.net>
Subject: Re: "Flush the D-cache during copy_user_highpage" breaks compile
	for v7 on -rc1
Date: Fri, 18 Dec 2009 09:35:12 -0600
Message-ID: <20091218153512.GA30512@lixom.net>
References: <20091218031923.GA4575@atomide.com> <20091218081851.GB28704@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:47377 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573AbZLRPbA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Dec 2009 10:31:00 -0500
Content-Disposition: inline
In-Reply-To: <20091218081851.GB28704@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Fri, Dec 18, 2009 at 08:18:52AM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 17, 2009 at 07:19:24PM -0800, Tony Lindgren wrote:
> > Hi Catalin,
> > 
> > You may have already run into this, but if not, looks like commit
> > 115b22474eb1905da2f606a057da3455833333d3 breaks compile for v7:
> > 
> > arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
> > arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
> > 
> > Undoing that makes it work again.
> 
> It's a combination of changes - my initial changes for fixing the ARMv7
> DMA support went in last night, but were based on a tree older than
> Catalin's changes, which had already been committed.
> 
> My test build didn't catch any of these - it's the usual problem that
> there is no way to adequately build-test the ARM kernel in a reasonable
> time anymore.

FWIW: I've added an omap3_defconfig, that should be a superset of the
configs used on the OMAP3 boards, to catch as much as possible affecting
those boards with one single build. Takes about 90 seconds for me to
build on a $600 PC, and Stephen builds it for every linux-next too.


-Olof
