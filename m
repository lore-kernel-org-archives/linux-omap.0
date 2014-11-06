From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/4] Touchscreen performance related fixes
Date: Thu, 6 Nov 2014 13:12:09 +0530
Message-ID: <545B2651.4090905@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com> <20141103180920.GA20779@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141103180920.GA20779-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On Monday 03 November 2014 11:39 PM, Richard Cochran wrote:
> On Mon, Oct 27, 2014 at 04:38:27PM +0530, Vignesh R wrote:
>> This series of patches fix TSC defects related to lag in touchscreen
>> performance and cursor jump at touch release. The lag was result of
>> udelay in TSC interrupt handler. Cursor jump due to false pen-up event.
>> The patches implement Advisory 1.0.31 in silicon errata of am335x-evm
>> to avoid false pen-up events and remove udelay.
> 
> That advisory has two workarounds. You have chosen the second one?

Work around one. Hence 5 wire design is not broken.

> 
> The text of the second workaround says it only works on 4 wire setups,
> so I wonder how 5 wire designs will be affected.
> 
>> The advisory says to use
>> steps 1 to 4 for ADC and 5 to 16 for TSC (assuming 4 wire TSC and 4 channel
>> ADC).
> 
> No, it doesn't say that. (sprz360f.pdf)

The pen up event detection happens immediately after charge step. Hence,
interchanging ADC and TSC steps makes sure that sampling of touch
co-ordinates and pen events are done one after the other. This
workaround was suggested by internal hardware folks. Earlier ADC steps
intervened between sampling of co-ordinates and pen event detection
which is not desirable.

> 
>> Further the X co-ordinate must be the last one to be sampled just
>> before charge step. The first two patches implement the required changes. 
> 
> FWIW, I implemented the first workaround and removed the udelay not
> too long ago. Like Sebastian, I saw the TSC unit hang after about
> 50000 interrupts when running with the workaround.
> 
> Did you test you patch for very long?

Yes, I tested for about 200000 interrupts and I didn't see any hang.
This patch series does not just implement workaround but also does some
minor changes, such as interchanging ADC and TSC steps etc, which makes
TSC driver more robust. Let me know if you encounter any issues with my
patch series.

Regards
Vignesh

> 
> Thanks,
> Richard
> 
