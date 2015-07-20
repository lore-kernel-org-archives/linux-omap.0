From: Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Fix incomplete initialization of ADC[3:6]$
Date: Mon, 20 Jul 2015 11:14:17 -0700
Message-ID: <1437416058-24586-1-git-send-email-adam.yh.lee@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, Adam YH Lee <adam.yh.lee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Additionally the original discussion for this patch can be found here [5].
$
[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/83698$
[2] http://gumstix.8.x6.nabble.com/twl4030-madc-low-read-value-td4967139.html#none$
[3] https://e2e.ti.com/support/power_management/pmu/f/43/t/732$
[4] http://www.droid-developers.org/images/2/21/Tps65950_TRM.pdf$
[5] http://www.spinics.net/lists/linux-omap/msg120300.html

Adam YH Lee (1):
  [TWL4030 MADC] Fix ADC[3:6] readings

 drivers/iio/adc/twl4030-madc.c | 14 ++++++++++++++
 drivers/phy/phy-twl4030-usb.c  |  7 +++++++
 2 files changed, 21 insertions(+)

-- 
2.1.4
