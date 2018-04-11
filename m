From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [Letux-kernel] [Bug]: mtd: onenand: omap2plus: kernel panic with
 OneNAND on OMAP3 (DM3730) device GTA04A5
Date: Wed, 11 Apr 2018 10:27:46 +0200
Message-ID: <20180411082746.GA20164@lenoch>
References: <5D496D5C-4E3E-47B4-9981-E8F4C348DE00@goldelico.com>
 <20180410205643.GA2228@lenoch>
 <20180411065836.7e1bfc3f@aktux>
 <20180411062607.GA9179@lenoch>
 <20180411091528.4e954c32@bbrezillon>
 <20180411073655.GA18273@lenoch>
 <20180411100806.3c09bafc@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990434AbeDKI1sw0qfO (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 1 other); Wed, 11 Apr 2018 10:27:48 +0200
Content-Disposition: inline
In-Reply-To: <20180411100806.3c09bafc@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 11, 2018 at 10:08:06AM +0200, Boris Brezillon wrote:
> On Wed, 11 Apr 2018 09:36:56 +0200
> Ladislav Michl <ladis@linux-mips.org> wrote:
> 
> > Hi Boris,
> > 
> > On Wed, Apr 11, 2018 at 09:15:28AM +0200, Boris Brezillon wrote:
[...]
> > > Not sure this approach is safe on all archs: if the cache is VIVT or
> > > VIPT, you may have several entries pointing to the same phys page, and
> > > then, when dma_map_page() does its cache maintenance operations, it's
> > > only taking one of these entries into account.  
> > 
> > Hmm, I used the same approach Samsung OneNAND driver does since commit
> > dcf08227e964a53a2cb39130b74842c7dcb6adde.
> > Both TI OMAP3630 and Samsung S5PC110 are using Cortex-A8 which
> > is VIPT. In that case samsung's driver code has the same problem.
> > 
> > > In other parts of the MTD subsystem, we tend to not do DMA on buffers
> > > that have been vmalloc-ed.
> > > 
> > > You can do something like
> > > 
> > > 		if (virt_addr_valid(buf))
> > > 			/* Use DMA */
> > > 		else
> > > 			/*
> > > 			 * Do not use DMA, or use a bounce buffer
> > > 			 * allocated with kmalloc
> > > 			 */  
> > 
> > Okay, I'll use this approach then, but first I'd like to be sure above is
> > correct. Anyone?
> 
> See this discussion [1]. The problem came up a few times already, so
> might find other threads describing why it's not safe.
> 
> [1]https://lists.linuxfoundation.org/pipermail/iommu/2016-March/016240.html

Question was more likely whenever there might exist more that one mapping
of the same page. But okay, I'll disable DMA for highmem. Patch will follow.

	ladis
