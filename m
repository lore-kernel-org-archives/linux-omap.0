From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 01/13] OMAP2/3: DMTIMER: Clear pending interrupts when
 stopping a timer
Date: Mon, 11 Jan 2010 10:42:36 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001111022110.19988@utopia.booyaka.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com> <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com> <EAF47CD23C76F840A9E7FCE10091EFAB02C0508DA2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37345 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab0AKRmi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 12:42:38 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C0508DA2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tero Kristo <tero.kristo@nokia.com>

Hello Santosh,

On Sun, 10 Jan 2010, Shilimkar, Santosh wrote:

> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
> > Hilman
> > Sent: Friday, January 08, 2010 11:29 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Tero Kristo
> > Subject: [PATCH 01/13] OMAP2/3: DMTIMER: Clear pending interrupts when stopping a timer
> > 
> > From: Tero Kristo <tero.kristo@nokia.com>
> > 
> > OMAP GP timers keep running for a few cycles after they are stopped,
> > which can cause the timer to expire and generate an interrupt. The pending
> > interrupt will prevent e.g. OMAP from entering suspend, thus we ack it
> > manually.
> > 
> > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> > Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  arch/arm/plat-omap/dmtimer.c |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> > index 64f407e..5502ce8 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -551,6 +551,16 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
> >  	if (l & OMAP_TIMER_CTRL_ST) {
> >  		l &= ~0x1;
> >  		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
> > +		/* Readback to make sure write has completed */
> > +		omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> Hopefully compiler don't optimize your readback.

It can't - if it does, it is a gcc bug.  omap_dm_timer_read_reg() 
ultimately calls __raw_readl() which uses the 'volatile' keyword:

http://en.wikipedia.org/wiki/Volatile_variable

...

Separately from the compiler, one must also ensure that the ARM core 
itself does not cache the readback.  This is handled by mapping the 
GPTIMER memory space as MT_DEVICE in mach-omap2/io.c.  See also the 
MT_DEVICE section in arch/arm/mm/mmu.c.  Further details are in the ARMv7 
Architecture Reference Manual, section A3.5.5, "Device Memory".


- Paul
