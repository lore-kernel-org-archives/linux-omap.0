From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [linux-pm] Issue: Runtime API usage in wake-up device irq_handler during wakeup from system-wide-suspend.
Date: Thu, 8 Sep 2011 07:58:31 +0300
Message-ID: <1315457911.2679.19.camel@sokoban>
References: <Pine.LNX.4.44L0.1108271537300.21403-100000@netrider.rowland.org> <1315410513.2679.9.camel@sokoban>  <87fwk8qllx.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44399 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754651Ab1IHE6x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 00:58:53 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <87fwk8qllx.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "Munegowda, Keshava" <keshava_mgowda@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Wed, 2011-09-07 at 19:59 +0200, Hilman, Kevin wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Hi,
> >
> > On Sat, 2011-08-27 at 21:42 +0200, Alan Stern wrote:
> >> On Sat, 27 Aug 2011, Santosh wrote:
> >> 
> >> > On Saturday 27 August 2011 07:31 PM, Alan Stern wrote:
> >> > > On Sat, 27 Aug 2011, Santosh wrote:
> >> > >
> >> > >> I might be wrong here, but after discussion with Govindraj on this
> >> > >> issue, it seems there is a flaw in the way OMAP chain handler
> >> > >> handling the child interrupts.
> >> > >>
> >> > >> On OMAP, we have special interrupt wakeup source at PRCM level and
> >> > >> many devices can trigger wakeup from low power via this common
> >> > >> interrupt source. The common interrupt source upon wakeup from low
> >> > >> power state, decodes the source of interrupt and based on that
> >> > >> source, calls the respective device ISR directly.
> >> > >>
> >> > >> The issue I see here is, the ISR on _a_ device (UART in this case)
> >> > >> is happening even before UART resume and DPM resume has been completed.
> >> > >> If this is the case, then it is surely asking for trouble. Because not
> >> > >> just clocks, but even driver state machine is already in suspend state
> >> > >> when the ISR is called.
> >> > >
> >> > > If the driver state machine is in the suspend state when the ISR is
> >> > > called, then the ISR should realize it is handling a wakeup event
> >> > > instead of a normal I/O event.  All it needs to do is turn off the
> >> > > interrupt source; the event itself will be taken care of during the
> >> > > device's resume callback.
> >> > >
> >> > Good point but the ISR is called as a function call and not real
> >> > hardware event so no need to turn-off the source in the child
> >> > ISR. Parent ISR will clear the source anyways.
> >> > 
> >> > But the intention here is to record the event for the child.
> >> 
> >> In that case the ISR only has to record the event.
> >> 
> >> > I mean for UART wakeup, the received character should be
> >> > extracted. If not done, UART will loose that character because
> >> > the event is lost. So not sure how the event will be taken
> >> > care during resume callback. Could you elaborate bit more on
> >> > last comment please?
> >> 
> >> The resume callback routine must check to see if an event was recorded.
> >> If one was, the routine must see whether a character was received while 
> >> the system was asleep and extract the character from the UART.  (It 
> >> probably won't hurt to do this even if an event wasn't recorded.)
> >> 
> >> Alan Stern
> >> 
> >
> > After thinking about this problem and looking at possible ways to fix
> > it, I am planning to change the PRCM chain handler to be a driver, which
> > gets suspended along with the rest of the system. This means the PRCM
> > interrupt would get disabled also during this time, and it would be
> > enabled in the driver->complete() call, which should happen after rest
> > of the drivers have been able to enable their PM runtime in the
> > driver->resume() call chain. Do you see any problems with this approach?
> 
> How will the system wakeup from retention or off-mode if the PRCM IRQ is
> disabled?

This is actually some sort of an issue with retention if we disable PRCM
irq completely, off works purely with wakeup signals as we come out of
reset. Anyway, I did some experimentation with this, and OMAP3 is able
to wake up if we leave WKUP irq up, but disable IO chain irq. IO chain
events seem to trigger a WKUP event also always, we just postpone the
processing of IO chain until later. I had to also split the wakeup
clearing for OMAP3 into 2 parts, one part handles wakeups and another IO
chain. Currently both IO chain and WKUP are acked by the same handler.

> Besides that, I don't like this approach because it leaves a rather long
> window during which no PRCM-triggered wakeup events can happen.  This is
> not good since we also want potential wakeup events that happen *during*
> system suspend to be able to cancel the suspend.

This should also be taken care of by the approach described above.

> 
> > The only issue I am seeing myself is if some driver decides to do
> > resume() in the complete() pm-op and potentially screwing the ordering
> > here...
> 
> Personally, I think Alan's approach is the only scalable approach.  This
> has to be handled by the drivers.
> 
> If the driver's ISR does a pm_runtime_get_sync() and it fails (in this
> case, with -EACCESS since runtime PM is disabled), the driver should
> handle that handle as Alan described above.

Yea I think this probably needs to be done anyway, at least on some
cases. The PRCM chain handler approach might be able to solve most of
the problems though. I think I will post what I have anyway for comments
hopefully later today, so you can have a look and say what you think.

-Tero



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

