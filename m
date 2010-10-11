From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] staging: tidspbridge: remove memory consistency from TODO list
Date: Mon, 11 Oct 2010 16:02:18 +0200
Message-ID: <201010111602.18950.arnd@arndb.de>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com> <201010111240.25759.arnd@arndb.de> <AANLkTikq80dM_93k2byPXDexzz3J+g3Wiva3ieBbXmmf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53257 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab0JKOBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 10:01:45 -0400
In-Reply-To: <AANLkTikq80dM_93k2byPXDexzz3J+g3Wiva3ieBbXmmf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>

On Monday 11 October 2010, Felipe Contreras wrote:
> On Mon, Oct 11, 2010 at 1:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sunday 10 October 2010, Felipe Contreras wrote:
> >> The mempool area is not handled by the kernel any more.
> >
> > But tidspbridge still uses ioremap to set up the mapping for RAM,
> > even though it now is outside of the kernel linar mapping.
> 
> Which is what ioremap() complained about, and how Russell King
> suggested to solve the issue.

You are right that this is what Russell asked about, having a single
mapping for memory means that you avoid the problems that the warning
was put there for and you no longer risk memory corruption. That
is good and the changes you did are the important ones.

What I'm arguing is that you still don't use the interface in the
way it's designed and things might break again in the future.
For instance, I've seen platforms where readl/writel is not a pointer
dereference but a hypercall or goes through an indirect index/data
register pair. I hope we don't ever get something like this on ARM,
but it would still be good to write the code in a more robust way
that doesn't mix __iomem tokens with kernel pointers.

> > You should really only use ioremap on MMIO registers, nothing
> > else. These registers are marked as __iomem pointers and can only
> > be passed into functions that talk to the hardware like iowrite32
> > or writel, but not used like memory.
> 
> From what I can see parts of this memory are also used for readl/writel.

In that case, it's worse than I thought ;-)

If you use readl(), it needs to be an __iomem pointer, if you use it
by direct dereferences, it must not be __iomem.

Obviously, you need to use ioremap to target the device registers,
but I don't see how it could make sense for a communication area
in memory.

> > Please have a look at "sparse", which will warn about address space
> > violations among other things. The tidspbridge driver is full of them,
> > and you should fix the code that sparse warns about, which will
> > also show you all the places where ioremap is used incorrectly.
> 
> In one of my branches I moved ioremap() to arch/arm/mach-omap2/dsp.c
> and if I use sparse there, it gives no warning.

I don't see how moving the code around would get rid of an address
space warning, unless you play dirty tricks like using __force
casts or passing pointers around as integers.

> I would prefer to map the memory some other way and make it
> non-cacheable, but I don't know any other way. Then, if readl/writel
> are still needed, only ioremap() that area. And finally, and
> hopefully, do cache flushes instead of requiring consistent memory.

Yes, that sounds reasonable. Can you use a chunk of regular kernel
memory with dma_map_single/dma_sync_single_for_{cpu,device} for this,
like normal drivers do?

	Arnd
