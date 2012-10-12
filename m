From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Fri, 12 Oct 2012 07:17:42 -0700
Message-ID: <874nlz93ll.fsf@deeprootsystems.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>
	<87ipag90om.fsf@deeprootsystems.com>
	<902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <902E09E6452B0E43903E4F2D568737AB2C87B0-bXo5r3zvlxeIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
	(Grygorii Strashko's message of "Fri, 12 Oct 2012 10:18:37 +0000")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>, "linux-i2c@vger.kernel.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "w.sang@pengutronix.de" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "ben-linux@fluff.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "tony@atomide.com" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, "Kankroliwala, Huzefa" <huzefank-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org> writes:

> Hi All,
>
> Sorry, for the late reply.
> + CC Huzefa Kankroliwala - who is I2C driver owner on Android Kernel 3.4.

Hi Grygorii, thanks for reviewing.  I was hoping you would have some
ideas here as this was sounding familiar to something you had mentioned
elsewhere.

> Regarding this patch -  from my point of view, it fixes corner case and not an issue in general.
> Let take a look on resume sequence:
>    - platform resume
>    - syscore resume
>    - resume_noirq
>    - enable IRQs - resume_device_irqs()
>      |- at this point IRQ handler will be invoked if IRQ state is IRQS_PENDING.
>      |- so, the I2C device IRQ handler may be called at time when I2C adapter IRQ is still disabled and, as result, the I2C device IRQ-handler may fail. (I2C device and I2C adapter may use different physical IRQ lines)
>    - resume_late
>      |- enable I2C bus IRQ
>
> Possibly, the better way is to enable/disable I2C bus IRQ when needed - in our case in omap_i2c_xfer().
> We use such approach in Android kernel 3.4
> (http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=1445a4d3b587c164bd30d108b61760aaaa07365e)

I agree, that should work and cover the cases where I2C is used by other
processors also.  Shubhrajyoti already posted something similar[1] but
it needed some rework (comments from Russell and myself.)

Huzefa, Shubhrajyoti, who can rework this idea for the upstream driver
and submit a patch?

Wolfram, I guess for now lets hold off on $SUBJECT patch.  Seems we can
come up with a broader solution.  Thanks.

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/124427.html
