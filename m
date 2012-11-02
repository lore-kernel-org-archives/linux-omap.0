From: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix spurious IRQs: disable/enable IRQ at
 INTC when idle
Date: Fri, 02 Nov 2012 08:17:57 +0200
Message-ID: <1351837077.16513.24.camel@kj-X230>
References: <1350067225-24589-1-git-send-email-khilman@deeprootsystems.com>
	 <CAM=Q2csm0Eh9F6d1wKhEfOOtG+aY+Fh8D-dKPC0RMbKupVQHYQ@mail.gmail.com>
	 <1350282337.17145.45.camel@kj-X230> <87zk3ntzfe.fsf@deeprootsystems.com>
	 <20121016010223.GL15569@atomide.com> <1350377235.2014.26.camel@kj-X230>
	 <20121101224921.GE22956@pengutronix.de>
Reply-To: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121101224921.GE22956-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Huzefa Kankroliwala <huzefank-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

to, 2012-11-01 kello 23:49 +0100, Wolfram Sang kirjoitti:
> Hi,
> 
> >  Anyway new patch coming soon :)
> 
> Was there one? I have skimmed a number of threads discussing spurious
> interrupts or interrupt floods but AFAICS all discussions ended up in
> trying another approach later or fixing the issue somewhere else than
> I2C. Is this correct? Or is there a bugfix patch left for 3.7 that I
> missed?

The problem was not actually in the i2c driver itself, the twl4030
Primary/Secondary interrupt handler irq wake up order was the problem.
The fix was this:
https://patchwork.kernel.org/patch/1601271/

Actually, Samuel, did you pick up my patch? I never got any response
after Kevin acked it.

- Kalle

> 
> Thanks,
> 
>    Wolfram
> 
