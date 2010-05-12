From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Wed, 12 May 2010 11:04:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C545576B@dbde02.ent.ti.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
	<20100421065550.GL4364@core.coreip.homeip.net>
	<27F9C60D11D683428E133F85D2BB4A53043DFD5320@dlee03.ent.ti.com>
	<27F9C60D11D683428E133F85D2BB4A53043DFD5323@dlee03.ent.ti.com>
	<20100511044156.GA21299@core.coreip.homeip.net>
	<27F9C60D11D683428E133F85D2BB4A53043DFD532E@dlee03.ent.ti.com>
	<20100511054552.GA1714@core.coreip.homeip.net>
	<87sk5yebh8.fsf@deeprootsystems.com>
	<20100511164136.GA7396@core.coreip.homeip.net>
 <87632ut8wm.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <87632ut8wm.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
> Hilman
> Sent: Wednesday, May 12, 2010 3:10 AM
> To: Dmitry Torokhov
> Cc: Arce, Abraham; linux-input@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: Re: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
> 
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> 
> > On Tue, May 11, 2010 at 07:53:23AM -0700, Kevin Hilman wrote:
> >> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
> >>
> >> > On Tue, May 11, 2010 at 12:03:44AM -0500, Arce, Abraham wrote:
> >> >> Hi again Dmitry,
> >> >>
> >> >> > No worries, although at first I was surprised that Trilok spoke exactly
> >> >> > the same words I did ;)
> >> >> >
> >> >>
> >> >> :)
> >> >>
> >> >> > > > > > +
> >> >> > > > > > +/* Interrupt thread handler thread */
> >> >> > > > > > +
> >> >> > > > > > +static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
> >> >> > > > > > +{
> >> >> > > > >
> >> >> > > > > Why is iti threaded? I fo not see anything that will sleep.
> >> >> > >
> >> >> > >
> >> >> > > It was implemented based on previous comments...
> >> >> > >
> >> >> >
> >> >> > Would you point me to that comment? Like I said, I do not see anything
> >> >> > that would possibly sleep in this routine so you don't need to use
> >> >> > threaded interrupt.
> >> >>
> >> >> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26352.html
> >> >>
> >> >
> >> > Thanks.
> >> >
> >> > I think Kevin meant "use theaded IRQ, wherever possible" [if we need
> >> > to sleep in interrupt handler].
> >>
> >> Actually, even interrupts that don't sleep can use threaded IRQs.  I
> >> prefer to see threaded IRQs wherever possible.  Especially since we're
> >> moving towards a world where all interrupts are run with interrupts
> >> disabled, using threaded IRQs minimizes interrupts-off critical
> >> sections.
> >>
> >
> > I think in this case threaded IRQ would just add unnecessary overhead.
> > There are no scanning delays, just a few register reads and writes.
> > Input core will take some cycles propagating the events but it disables
> > interrupts anyway. Setting up a separate thread and scheduling does not
> > make much sense here.
> >
> > Also I am not sure if arches with large number of interrupts would want
> > to move to all threaded interrupts model.
> 
> OK, it's your call for this subsystem.
> 
Abraham initial driver has top half (ISR) and bottom half (tasklet). With Threaded 
IRQ, we can get rid-of tasklet and handle the bottom half in thread context.
IIRC this was on of the intention of this new API.

Isn't this not good enough to use the threaded IRQ in this case.

Regards,
Santosh
