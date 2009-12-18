From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: "Flush the D-cache during copy_user_highpage" breaks compile for
 v7 on -rc1
Date: Fri, 18 Dec 2009 14:50:22 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912181448120.28241@xanadu.home>
References: <20091218031923.GA4575@atomide.com>
 <20091218081851.GB28704@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:23204 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbZLRTuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 14:50:40 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KUV00HZ65RYVN20@VL-MH-MR002.ip.videotron.ca> for
 linux-omap@vger.kernel.org; Fri, 18 Dec 2009 14:50:22 -0500 (EST)
In-reply-to: <20091218081851.GB28704@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, 18 Dec 2009, Russell King - ARM Linux wrote:

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

This is why we have a community of people reporting such issues, and a 
long -rc period to fix them.


Nicolas
