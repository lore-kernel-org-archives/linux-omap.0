From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC] [PATCH 1/3] OMAP4: Keyboard Controller Support
Date: Tue, 11 May 2010 07:53:23 -0700
Message-ID: <87sk5yebh8.fsf@deeprootsystems.com>
References: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F5@dlee03.ent.ti.com>
	<20100421065550.GL4364@core.coreip.homeip.net>
	<27F9C60D11D683428E133F85D2BB4A53043DFD5320@dlee03.ent.ti.com>
	<27F9C60D11D683428E133F85D2BB4A53043DFD5323@dlee03.ent.ti.com>
	<20100511044156.GA21299@core.coreip.homeip.net>
	<27F9C60D11D683428E133F85D2BB4A53043DFD532E@dlee03.ent.ti.com>
	<20100511054552.GA1714@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20100511054552.GA1714@core.coreip.homeip.net> (Dmitry Torokhov's message of "Mon\, 10 May 2010 22\:45\:52 -0700")
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Arce, Abraham" <x0066660@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:

> On Tue, May 11, 2010 at 12:03:44AM -0500, Arce, Abraham wrote:
>> Hi again Dmitry,
>> 
>> > No worries, although at first I was surprised that Trilok spoke exactly
>> > the same words I did ;)
>> > 
>> 
>> :)
>> 
>> > > > > > +
>> > > > > > +/* Interrupt thread handler thread */
>> > > > > > +
>> > > > > > +static irqreturn_t omap_keypad_threaded(int irq, void *dev_id)
>> > > > > > +{
>> > > > >
>> > > > > Why is iti threaded? I fo not see anything that will sleep.
>> > >
>> > >
>> > > It was implemented based on previous comments...
>> > >
>> > 
>> > Would you point me to that comment? Like I said, I do not see anything
>> > that would possibly sleep in this routine so you don't need to use
>> > threaded interrupt.
>> 
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26352.html
>> 
>
> Thanks.
>
> I think Kevin meant "use theaded IRQ, wherever possible" [if we need
> to sleep in interrupt handler].

Actually, even interrupts that don't sleep can use threaded IRQs.  I
prefer to see threaded IRQs wherever possible.  Especially since we're
moving towards a world where all interrupts are run with interrupts
disabled, using threaded IRQs minimizes interrupts-off critical
sections.

Kevin

