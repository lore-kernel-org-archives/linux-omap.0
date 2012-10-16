From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix spurious IRQs: disable/enable IRQ at
 INTC when idle
Date: Mon, 15 Oct 2012 18:02:24 -0700
Message-ID: <20121016010223.GL15569@atomide.com>
References: <1350067225-24589-1-git-send-email-khilman@deeprootsystems.com>
 <CAM=Q2csm0Eh9F6d1wKhEfOOtG+aY+Fh8D-dKPC0RMbKupVQHYQ@mail.gmail.com>
 <1350282337.17145.45.camel@kj-X230>
 <87zk3ntzfe.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87zk3ntzfe.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Huzefa Kankroliwala <huzefank-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> [121015 10:32]:
> Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org> writes:
> >
> > Does not work for me :(
> >
> > As I said, the issue occurs for me when I enter static suspend (echo mem
> >> /sys/power/autosleep or /sys/power/state). I don't think doing this
> > just in runtime pm will fix my issue. Or do those handlers get run in
> > the normal suspend path as well?
> 
> If the I2C device is still active during the suspend path, these
> handlers will get run by the PM domain code (in omap_device.)  However,
> now that I think about it, the current omap_device PM domain code calls
> these at the noirq level, not the late/early level, so it does not
> address your original problem. :(
> 
> I suspect we'll need this and your original patch.

Have you checked that this is not related to flushing the posted
write? If it is, reading back any register from the i2c controller
after writing to it ensures the write actually reaches the i2c
controller.

Regards,

Tony
