From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
Date: Fri, 14 Nov 2014 10:37:25 +0530
Message-ID: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Brad Griffis <bgriffis-l0cyMroinI0@public.gmane.org>, Sanjeev Sharma <sanjeev_sharma-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Jan Kardell <jan.kardell-KSZdJiTw9mzQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series of patches fix TSC defects related to lag in touchscreen
performance and cursor jump at touch release. The lag was result of
udelay in TSC interrupt handler. Cursor jump due to false pen-up event.
The patches implement Advisory 1.0.31 in silicon errata of am335x-evm
to avoid false pen-up events and remove udelay. The advisory says to use
steps 1 to 4 for ADC and 5 to 16 for TSC (assuming 4 wire TSC and 4 channel
ADC). Further the X co-ordinate must be the last one to be sampled just
before charge step. The first two patches implement the required changes.

A DT parameter to configure the duration of tsc charge step. It represents
number of ADC clock cycles to wait between applying the step configuration
registers and going back to the IDLE state. The charge delay value can vary
across boards. Configuring correct value of charge delay is important to avoid
false pen-up events. Hence it is necessary to expose charge-delay value as
DT parameter. The pen-up detection happens immediately after the charge step
so this does in fact function as a hardware knob for adjusting the amount of
settling time.

After applying these changes false pen-up events have not be observed and
smooth circles can be drawn on touch screen. The performance is much better
in recognizing quick movement across the screen. No lag or cursor jump is
observed.

Change log:

v3:
 - Replace delta filtering logic in TSC driver with median filtering
   as suggested by Richard.
 - Addressed Lee Jones comments.

v2:
 - Addressed comments by Hartmut Knaack
 - patch 2 was split into two as per Lee Jones comment

Brad Griffis (2):
  input: touchscreen: ti_am335x_tsc Interchange touchscreen and ADC
    steps
  input: touchscreen: ti_am335x_tsc: Remove udelay in interrupt handler

Vignesh R (4):
  mfd: ti_am335x_tscadc: Remove unwanted reg_se_cache save
  ARM: dts: AM335x: Make charge delay a DT parameter for TSC
  input: touchscreen: ti_am335x_tsc: Use charge delay DT parameter
  input: touchscreen: ti_am335x_tsc: Replace delta filtering with median
    filtering

 .../bindings/input/touchscreen/ti-tsc-adc.txt      |  15 ++
 arch/arm/boot/dts/am335x-evm.dts                   |   1 +
 drivers/iio/adc/ti_am335x_adc.c                    |   5 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          | 186 +++++++++++----------
 drivers/mfd/ti_am335x_tscadc.c                     |   7 +-
 include/linux/mfd/ti_am335x_tscadc.h               |   4 +-
 6 files changed, 127 insertions(+), 91 deletions(-)

-- 
1.9.1
