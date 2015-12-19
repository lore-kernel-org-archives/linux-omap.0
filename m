From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] mtd: onenand: omap2: Simplify the DMA setup for various
 paths
Date: Sat, 19 Dec 2015 15:30:49 +0200
Message-ID: <20151219133049.GA1611@darkstar.musicnaut.iki.fi>
References: <1450086572-15224-1-git-send-email-peter.ujfalusi@ti.com>
 <20151218181111.GK10460@google.com>
 <20151218183948.GO23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151218183948.GO23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Brian Norris <computersforpeace@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, kyungmin.park@samsung.com, dwmw2@infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Dec 18, 2015 at 10:39:48AM -0800, Tony Lindgren wrote:
> * Brian Norris <computersforpeace@gmail.com> [151218 10:11]:
> > On Mon, Dec 14, 2015 at 11:49:32AM +0200, Peter Ujfalusi wrote:
> > > We have 4 functions containing almost identical DMA setup code. Create one
> > > function which can set up the DMA for both read and write and use this in
> > > place for the setup code in the driver.
> > > The new function will use wait_for_completion_timeout() and it will figure
> > > out the best data_type to be used for the transfer instead of hardwiring
> > > 32 or 16 bit data.
> > > 
> > > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > Does anyone use this driver? I've seen practically zero activity on the
> > entire OneNAND codebase in the last few years, and I presumed it was
> > essentially dead.
> > 
> > If it's not dead, I'd like to know some contingency of people who are
> > willing to actually maintain (or at least review) this stuff.
> > 
> > Kyungmin, are you still out there? Or Tony, do you know of any users for
> > this?
> > 
> > Peter, are you actually using this, or are you just refactoring for the
> > fun of it?
> 
> It's used for n8x0 and n900, but mostly in read-only mode. I suggest we

It's also used on n9/n950 phones. Also write functionality is needed
for mtdoops and kernel flashing.

> remove the DMA support for it completely because of the following:
> 
> 1. The DMA support for this driver is not done correctly. The pin used
>    as GPIO should be used as external DMA request line.
> 
> 2. AFAIK the DMA for this driver is mostly disabld, probably largely
>    due to #1 above
> 
> 3. If we remove DMA support, we can then easily switch to use the
>    generic onenand driver.
> 
> I'd like to hear Aaro's comments too before doing this tough.

Probably DMA support is not that critical. Looks like with DT boot it's
not even possible to enable it at the moment.

A.
