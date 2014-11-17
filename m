From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 2/6] input: touchscreen: ti_am335x_tsc: Remove udelay
 in interrupt handler
Date: Mon, 17 Nov 2014 09:57:05 +0530
Message-ID: <54697919.5030302@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com> <1415941651-28962-3-git-send-email-vigneshr@ti.com> <20141115192739.GA18766@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141115192739.GA18766-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap@v
List-Id: linux-omap@vger.kernel.org



On Sunday 16 November 2014 12:57 AM, Richard Cochran wrote:
> On Fri, Nov 14, 2014 at 10:37:27AM +0530, Vignesh R wrote:
>> From: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
>>
>> TSC interrupt handler had udelay to avoid reporting of false pen-up
>> interrupt to user space. This patch implements workaround suggesting in
>> Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay
>> and touchscreen lag. This also improves performance of touchscreen and
>> eliminates sudden jump of cursor at touch release.
> 
> I back ported this series onto v3.15.1 in order to try this out on a
> custom, beaglebone-like board. With this series, the touch is really
> broken. (I had fixed the pen up problem in a totally different way for
> a customer, and so I wanted to try out your solution.)
> 
> I will try to port the board code to a more recent kernel to try your
> series again. With which kernel version did you test your patches?
> 
> And which board?
> 
Thanks for testing these patches.

My patches are based on v3.18rc2. I tested my patches on am335x-evm
using tslib.
If you are encountering false pen-ups, charge-delay parameter needs to
be tuned to your board. In some custom setups charge-delay of 0xB000
provided better performance.
If you are using ts_test (from tslib) for testing try
# ts_test > /dev/null
for better performance.

Please explain "touch is broken"? What is the behaviour of TSC?
Which ADC channels are being used for TSC?

Regards
Vignesh

> Thanks,
> Richard
> 
> 
