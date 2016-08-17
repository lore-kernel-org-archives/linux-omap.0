From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/2] ti_am335x_adc: Fix bugs related to oneshot read
Date: Wed, 17 Aug 2016 17:42:59 +0530
Message-ID: <20160817121301.21785-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This series fixes a couple of bugs related to simultaneous read of
multiple ADC channels in oneshot mode. Since, all channels share FIFO1,
it has to be protected using a mutex, implemented by patch 1. Patch 2
increases the timeout waiting for a ADC sample.

Vignesh R (2):
  iio: adc: ti_am335x_adc: Protect FIFO1 from concurrent access
  iio: adc: ti_am335x_adc: Increase timeout value waiting for ADC sample

 drivers/iio/adc/ti_am335x_adc.c      | 16 ++++++++++++----
 include/linux/mfd/ti_am335x_tscadc.h |  8 ++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.9.2
