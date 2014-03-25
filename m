From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] serial: omap: Fix missing pm_runtime_resume handling by
 simplifying code
Date: Tue, 25 Mar 2014 12:28:42 -0700
Message-ID: <20140325192841.GC31906@atomide.com>
References: <20140325184846.GB31906@atomide.com>
 <20140325185237.GB7216@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbaCYT2r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Mar 2014 15:28:47 -0400
Content-Disposition: inline
In-Reply-To: <20140325185237.GB7216@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Kevin Hilman <khilman@linaro.org>

* Felipe Balbi <balbi@ti.com> [140325 11:57]:
> On Tue, Mar 25, 2014 at 11:48:47AM -0700, Tony Lindgren wrote:
> > The lack of pm_runtime_resume handling for the device state leads into
> > device wake-up interrupts not working after a while for runtime PM.
> > 
> > Also, serial-omap is confused about the use of device_may_wakeup.
> > The checks for device_may_wakeup should only be done for suspend and
> > resume, not for pm_runtime_suspend and pm_runtime_resume. The wake-up
> > events for PM runtime should always be enabled.
> > 
> > The lack of pm_runtime_resume handling leads into device wake-up
> > interrupts not working after a while for runtime PM.
> > 
> > Rather than try to patch over the issue of adding complex tests to
> > the pm_runtime_resume, let's fix the issues properly:
> > 
> > 1. Make serial_omap_enable_wakeup deal with all internal PM state
> >    handling so we don't need to test for up->wakeups_enabled elsewhere.
> > 
> >    Later on once omap3 boots in device tree only mode we can also
> >    remove the up->wakeups_enabled flag and rely on the wake-up
> >    interrupt enable/disable state alone.
> > 
> > 2. Do the device_may_wakeup checks in suspend and resume only,
> >    for runtime PM the wake-up events need to be always enabled.
> > 
> > 3. Finally just call serial_omap_enable_wakeup and make sure we
> >    call it also in pm_runtime_resume.
> > 
> > 4. Note that we also have to use disable_irq_nosync as serial_omap_irq
> >    calls pm_runtime_get_sync.
> > 
> > Fixes: 2a0b965cfb6e (serial: omap: Add support for optional wake-up)
> > Cc: stable@vger.kernel.org # v3.13+
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > --- a/drivers/tty/serial/omap-serial.c
> > +++ b/drivers/tty/serial/omap-serial.c
> > @@ -225,14 +225,19 @@ static inline void serial_omap_enable_wakeirq(struct uart_omap_port *up,
> >  	if (enable)
> >  		enable_irq(up->wakeirq);
> >  	else
> > -		disable_irq(up->wakeirq);
> > +		disable_irq_nosync(up->wakeirq);
> 
> looks to me liket his should be a separate fix of its own...

I don't think fixing disable_irq_nosync here is not needed without
fixing the rest. We're currently never calling serial_omap_enable_wakeup
from the runtime PM resume path.

So serial_omap_enable_wakeirq(up, 0) would only get called in the case
of device_may_wakeup disabled from serial_omap_runtime_suspend, which is
not called from the interrupt context.
 
> >  static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
> >  {
> >  	struct omap_uart_port_info *pdata = dev_get_platdata(up->dev);
> >  
> > +	if (enable == up->wakeups_enabled)
> > +		return;
> 
> is there any case where you would call this function twice with the same
> argument ?

Yes at least when serial-omap is runtime PM enabled and doing a suspend
without device_may_wakeup being set.

I'd like to get rid of the wakeups_enabled, but it's probably safest to do
that when ripping out the remaining context_loos_cnt stuff after we've made
omap3 to boot also in device tree only mode.

Regards,

Tony
