From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix spurious IRQs: disable/enable IRQ at INTC when idle
Date: Mon, 15 Oct 2012 10:31:17 -0700
Message-ID: <87zk3ntzfe.fsf@deeprootsystems.com>
References: <1350067225-24589-1-git-send-email-khilman@deeprootsystems.com>
	<CAM=Q2csm0Eh9F6d1wKhEfOOtG+aY+Fh8D-dKPC0RMbKupVQHYQ@mail.gmail.com>
	<1350282337.17145.45.camel@kj-X230>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1350282337.17145.45.camel@kj-X230> (Kalle Jokiniemi's message of
	"Mon, 15 Oct 2012 09:25:37 +0300")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kalle.jokiniemi-ieSKYCWCyXoAvxtiuMwx3w@public.gmane.org
Cc: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Huzefa Kankroliwala <huzefank-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org> writes:

> Hi,
>
> la, 2012-10-13 kello 01:00 +0530, Shubhrajyoti Datta kirjoitti:
>> On Sat, Oct 13, 2012 at 12:10 AM, Kevin Hilman
>> <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:
>> > From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
>> >
>> > Currently, runtime PM is used to keep the device enabled only during
>> > active transfers and for a configurable runtime PM autosuspend timout
>> > after an xfer.
>> >
>> > In addition to idling the device, driver's ->runtime_suspend() method
>> > currently disables device interrupts when idle.  However, on some SoCs
>> > (notably OMAP4+), the I2C hardware may shared with other coprocessors.
>> > This means that the MPU will still recieve interrupts if a coprocessor
>> > is using the I2C device.  To avoid this, also disable interrupts at
>> > the MPU INTC when idling the device in ->runtime_suspend() (and
>> > re-enable them in ->runtime_resume().)  This part based on an original
>> > patch from Shubhrajyoti Datta.  NOTE: for proper sharing the I2C with
>> > a coprocessor, this driver still needs hwspinlock support added.
>> >
>> > This change is also meant to address an issue reported by Kalle
>> > Jokiniemi where I2C bus interrupt may be enabled before an I2C device
>> > interrupt handler (e.g. just after noirq resume phase) causing an
>
> It is actually in middle of resume_noirq.
>
>> > interrupt flood on the I2C bus interrupt before the device interrupt
>> > is enabled (e.g. interrupts coming from devices on I2C connected PMIC
>> > before the PMIC chained hanlder is enabled.)  This problem is addresed
>> > by ensuring that the I2C bus interrupt left disabled until an I2C xfer
>> > is requested.
>> 
>> Looks good to me.
>> Will wait for Kalle though.
>
> Does not work for me :(
>
> As I said, the issue occurs for me when I enter static suspend (echo mem
>> /sys/power/autosleep or /sys/power/state). I don't think doing this
> just in runtime pm will fix my issue. Or do those handlers get run in
> the normal suspend path as well?

If the I2C device is still active during the suspend path, these
handlers will get run by the PM domain code (in omap_device.)  However,
now that I think about it, the current omap_device PM domain code calls
these at the noirq level, not the late/early level, so it does not
address your original problem. :(

I suspect we'll need this and your original patch.


Kevin
