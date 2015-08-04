From: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [V4] [TWL4030 MADC] Correction and clean-up
Date: Tue,  4 Aug 2015 11:15:47 -0700
Message-ID: <1438712148-27004-1-git-send-email-adam.yh.lee@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The V4 of this patch addresses issues raised by Jonathan [1].

"iio_device_register" call should be the last call in the probe.
All regulators should be configured before that call.

Remove devm_regulator_put as it is not necessary. "devm_allocators"
(devm_regulator_get, in this case) does device removal as well as error
handling.

[1] http://www.spinics.net/lists/linux-omap/msg120871.html

Adam YH Lee (1):
  [TWL4030 MADC] Fix ADC[3:6] readings

 drivers/iio/adc/twl4030-madc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.1.4
