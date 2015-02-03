From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 2/6] input: touchscreen: ti_am335x_tsc: Remove udelay
 in interrupt handler
Date: Tue, 3 Feb 2015 11:49:56 -0800
Message-ID: <20150203194956.GD20256@dtor-ws>
References: <1420609779-11156-1-git-send-email-vigneshr@ti.com>
 <1420609779-11156-3-git-send-email-vigneshr@ti.com>
 <54CB1604.9030709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54CB1604.9030709-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 30, 2015 at 10:56:28AM +0530, Vignesh R wrote:
> 
> 
> On Wednesday 07 January 2015 11:19 AM, Vignesh R wrote:
> > From: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
> > 
> > TSC interrupt handler had udelay to avoid reporting of false pen-up
> > interrupt to user space. This patch implements workaround suggesting in
> > Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay
> > and touchscreen lag. This also improves performance of touchscreen and
> > eliminates sudden jump of cursor at touch release.
> > 
> > IDLECONFIG and CHARGECONFIG registers are to be configured
> > with same values in order to eliminate false pen-up events. This
> > workaround may result in false pen-down to be detected, hence considerable
> > charge step delay needs to be added. The charge delay is set to 0xB000
> > (in terms of ADC clock cycles) by default.
> > 
> > TSC steps are disabled at the end of every sampling cycle and EOS bit is
> > set. Once the EOS bit is set, the TSC steps need to be re-enabled to begin
> > next sampling cycle.
> > 
> > Signed-off-by: Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>
> > [vigneshr-l0cyMroinI0@public.gmane.org: Ported the patch from v3.12 to v3.19rc1]
> > 
> > Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> > ---
> 
> Ping... Can somebody pick this patch series if there are no more comments??

Yes, I picked up everything but patch #3 as I assume Lee will merge it
through MFD tree.

Thanks.

-- 
Dmitry
