From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv2 8/13] dmtimer: OMAP: multi-platform register access
 support
Date: Wed, 1 Sep 2010 14:52:43 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03291AD32F@dbde02.ent.ti.com>
References: <1281800179-15085-1-git-send-email-tarun.kanti@ti.com>
 <87iq30q2v3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52101 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870Ab0IAJWu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 05:22:50 -0400
In-Reply-To: <87iq30q2v3.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 24, 2010 5:49 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Basak, Partha; Shilimkar, Santosh;
> Gopinath, Thara; Paul Walmsley; Tony Lindgren
> Subject: Re: [PATCHv2 8/13] dmtimer: OMAP: multi-platform register access
> support
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > This patch uses the new register structures and mappings in functions
> > in order to access register offsets thereby supporting multi-platform
> > environment.
> >
> > Signed-off-by: Partha Basak <p-basak2@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/dmtimer.c |   51 ++++++++++++++++++++++++++++++++---
> -------
> >  1 files changed, 39 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> > index 14a20e0..24ca283 100755
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -154,6 +154,7 @@ struct omap_dm_timer {
> >  	unsigned long fclk_rate;
> >  	int irq;
> >  	void __iomem *io_base;
> > +	u32	*regs;
> >  	unsigned reserved:1;
> >  	unsigned enabled:1;
> >  	unsigned posted:1;
> > @@ -174,13 +175,14 @@ static DEFINE_SPINLOCK(dm_timer_lock);
> >   * pending bit must be checked. Otherwise a read of a non completed
> write
> >   * will produce an error.
> >   **/
> > -static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer,
> u32 reg)
> > +static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer,
> int reg)
> 
> 'reg' could stay unsigned, it's a non-zero index.  If anything, you
> could change it to a u8.
I will change. Thanks.

> 
> >  {
> >  	if (timer->posted)
> > -		while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG &
> 0xff))
> > -				& (reg >> WPSHIFT))
> > +		while (readl(timer->io_base + \
> 
> '\' is not needed
> 
I will change.

thanks,
tarun

> [...]
> 
> Kevin
