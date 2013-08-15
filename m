From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v8 0/2] TWL6030, TWL6032 GPADC driver
Date: Thu, 15 Aug 2013 10:12:16 +0100
Message-ID: <20130815091216.GB28366@e106331-lin.cambridge.arm.com>
References: <1374758813-6539-1-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1374758813-6539-1-git-send-email-oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Kozaruk <oleksandr.kozaruk-l0cyMroinI0@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rnayak-l0cyMroinI0@public.gmane.org" <rnayak-l0cyMroinI0@public.gmane.org>, "peter.ujfalusi-l0cyMroinI0@public.gmane.org" <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, "kishon-l0cyMroinI0@public.gmane.org" <kishon-l0cyMroinI0@public.gmane.org>, "jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org" <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>, "milo.kim-l0cyMroinI0@public.gmane.org" <milo.kim-l0cyMroinI0@public.gmane.org>, "balajitk-l0cyMroinI0@public.gmane.org" <balajitk-l0cyMroinI0@public.gmane.org>, "gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org" <gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel@vger.>
List-Id: linux-omap@vger.kernel.org

Hi,

apologies for the late reply.

On Thu, Jul 25, 2013 at 02:26:51PM +0100, Oleksandr Kozaruk wrote:
> Hello,
> 
> v8 - removed unused test channels completely, removed die
>      temperature channels, as it is not known how to convert ADC code
>      to temperature. There if formula for twl6030, but no formula
>      for twl6032.
> v7 - addressed clean up comments, removed test channels
> v6 - addressed comments about trim bits, checkpatch clean up
> v5 - gpadc DT node renamed from "gpadc" to generic "adc", added
>      temperature channels; raw code is corracted with calibration
>      data.
> v4 - addressed comments: fixed style violation, bug in freeing memory,
>      added comments explaining calibration method, removed test network
>      channels from exposing to userspace, error handling for 
>      wait_for_complition
> v3 - fixed compiler warning
> v2 - the driver put in drivers/iio, and
> converted using iio facilities as suggested by Graeme.
> 
> TWL603[02] GPADC is used to measure battery voltage,
> battery temperature, battery presence ID, and could
> be used to measure twl603[02] die temperature.
> This is used on TI blaze, blaze tablet platforms.
> 
> The TWL6030/TWL6032 is a PMIC that has a GPADC with 17/19
> channels respectively. Some channels have current
> source and are used for measuring voltage drop
> on resistive load for detecting battery ID resistance,
> or measuring voltage drop on NTC resistors for external
> temperature measurements, other channels measure voltage,
> (i.e. battery voltage), and have inbuilt voltage dividers,
> thus, capable to scale voltage. Some channels are dedicated
> for measuring die temperature.
> 
> Some channels could be calibrated in 2 points, having
> offsets from ideal values in trim registers.
> 
> The difference between GPADC in TWL6030 and TWL6032:
> - 10 bit vs 12 bit ADC;
> - 17 vs 19 channels;
> - channels have different purpose(i. e. battery voltage
>   channel 8 vs channel 18);
> - trim values are interpreted differently.
> 
> The driver is derived from git://git.omapzoom.org/kernel/omap.git
> The original driver's authors and contributors are Balaji T K,
> Graeme Gregory, Ambresh K, Girish S Ghongdemath.
> 
> The changes to the original driver:
> - device tree adaptation;

I couldn't see a binding document in this series or in mainline. Have I
looked in the wrong places?

Mark.
