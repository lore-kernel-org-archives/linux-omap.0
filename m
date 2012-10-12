From: "Kankroliwala, Huzefa" <huzefank-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume
Date: Fri, 12 Oct 2012 12:55:52 +0000
Message-ID: <2E9A81F522C511499A7C1931101F66CC0C252451@DFLE11.ent.ti.com>
References: <1349871480-25182-1-git-send-email-kalle.jokiniemi@jollamobile.com>,<87ipag90om.fsf@deeprootsystems.com>
 <902E09E6452B0E43903E4F2D568737AB2C87B0@DNCE04.ent.ti.com>
 <5077FFEC.5040407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5077FFEC.5040407-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Datta, Shubhrajyoti" <shubhrajyoti-l0cyMroinI0@public.gmane.org>, "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Kalle Jokiniemi <kalle.jokiniemi-4y2FMlU5MS8onNqTyK5kxQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Shubro,
As Grygorii pointed out we had a generic issue of arm getting interrupted for i2c accesses outside it (IPU in case of omap4/omap5) and to avoid that we would enable/disable mpu level interrupts only when required from i2c-omap driver.

Regards
Huzefa

-----Original Message-----
From: Datta, Shubhrajyoti 
Sent: Friday, October 12, 2012 6:33 AM
To: Strashko, Grygorii
Cc: Kevin Hilman; Kalle Jokiniemi; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Kankroliwala, Huzefa
Subject: Re: [PATCH v3] ARM: OMAP: i2c: fix interrupt flood during resume

On Friday 12 October 2012 03:48 PM, Strashko, Grygorii wrote:
> Hi All,
>
> Sorry, for the late reply.
> + CC Huzefa Kankroliwala - who is I2C driver owner on Android Kernel 3.4.
>
> Regarding this patch
hmm I had similar ideas however my idea was to pacify the arm interrupts
when the ip is used by another processor.(something my hw spin patch missed)

Any-ways will wait for Huzefa to comment.


>  -  from my point of view, it fixes corner case and not an issue in general.
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
>
> Grygorii
> ______________________
