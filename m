From: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix spurious IRQs: disable/enable IRQ at
 INTC when idle
Date: Tue, 16 Oct 2012 11:47:15 +0300
Message-ID: <1350377235.2014.26.camel@kj-X230>
References: <1350067225-24589-1-git-send-email-khilman@deeprootsystems.com>
	 <CAM=Q2csm0Eh9F6d1wKhEfOOtG+aY+Fh8D-dKPC0RMbKupVQHYQ@mail.gmail.com>
	 <1350282337.17145.45.camel@kj-X230> <87zk3ntzfe.fsf@deeprootsystems.com>
	 <20121016010223.GL15569@atomide.com>
Reply-To: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121016010223.GL15569-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Huzefa Kankroliwala <huzefank-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

ma, 2012-10-15 kello 18:02 -0700, Tony Lindgren kirjoitti:
> * Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> [121015 10:32]:
> > Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org> writes:
> > >
> > > Does not work for me :(
> > >
> > > As I said, the issue occurs for me when I enter static suspend (echo mem
> > >> /sys/power/autosleep or /sys/power/state). I don't think doing this
> > > just in runtime pm will fix my issue. Or do those handlers get run in
> > > the normal suspend path as well?
> > 
> > If the I2C device is still active during the suspend path, these
> > handlers will get run by the PM domain code (in omap_device.)  However,
> > now that I think about it, the current omap_device PM domain code calls
> > these at the noirq level, not the late/early level, so it does not
> > address your original problem. :(
> > 
> > I suspect we'll need this and your original patch.
> 
> Have you checked that this is not related to flushing the posted
> write? If it is, reading back any register from the i2c controller
> after writing to it ensures the write actually reaches the i2c
> controller.

The twl4030-irq handler (handle_twl4030_pih) function just reads the PIH
irq status over the i2c and calls handle_nested_irq for each set module
(like USB, GPIO, etc) irq bit. This does not clear the interrupt
however, that is done in the nested interrupt, once it runs (by clearing
the actual interrupt inside the module).

I'm thinking now that it's actually this PIH handler that should be
postponed until resume_noirq has finished. I had another idea as well
yesterday to mark the secondary irq handlers with IRQF_EARLY_RESUME
flag. Though that did not work on the quick test I did. Anyway new patch
coming soon :)

- Kalle

> 
> Regards,
> 
> Tony
