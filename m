From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 5
Date: Thu, 13 Jun 2013 11:25:26 +0200
Message-ID: <51B99006.2060103@linutronix.de>
References: <1371056302-12714-1-git-send-email-bigeasy@linutronix.de> <20130613090719.GB7998@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130613090719.GB7998@zurbaran>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 06/13/2013 11:07 AM, Samuel Ortiz wrote:
> Hi Sebastian,

Hi Samuel,

> Pulled and pushed back to mfd-next, thanks.

Thank you.

> I fixed a couple of unused variable warnings on top of it.

I saw your patch at git.k.o and I am asking you not to taking it :)
The code is:

        of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
                 adc_channels++;
                 if (val > 7) {
                         dev_err(&pdev->dev, " PIN numbers are 0..7 (not
%d)\n",
                                         val);
                         return -EINVAL;
                 }
         }

and without CONFIG_OF of_property_for_each_u32() becomes most likely
empty. That is why I haven't seen it.
So either the macro should be changed to tell the compiler that the
variables are used (so the warning does not show up) or let the driver
depend on CONFIG_OF. I will look at the former and can prepare a patch
for the latter if you want.

> 
> Cheers,
> Samuel.
> 

Sebastian
