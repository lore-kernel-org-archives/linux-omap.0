From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: onenand: omap2: Simplify the DMA setup for various
 paths
Date: Fri, 18 Dec 2015 14:39:29 -0800
Message-ID: <20151218223929.GS10460@google.com>
References: <1450086572-15224-1-git-send-email-peter.ujfalusi@ti.com>
 <20151218181111.GK10460@google.com>
 <567462F9.1010703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <567462F9.1010703@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: kyungmin.park@samsung.com, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 18, 2015 at 09:48:09PM +0200, Peter Ujfalusi wrote:
> On 12/18/2015 08:11 PM, Brian Norris wrote:
> > Peter, are you actually using this, or are you just refactoring for the
> > fun of it?
> 
> Not really for fun, but I want to get rid of all legacy/direct sDMA use so at
> the end we will have omap_start_dma() visible in two files:
> arch/arm/plat-omap/dma.c
> drivers/dma/omap-dma.c
> 
> from there it will be possible to get rid of the plat-omap code. This onenand
> driver was the first in the 'git grep omap_start_dma' result ;)

OK, well killing broken DMA support altogether might make more sense,
and deleting an entire driver would be even better. Of course, having a
real tester would be nice too. I'll wait on Tony/Aaro.

Brian
