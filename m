From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] i2c: omap: revision register updates
Date: Fri, 2 Nov 2012 16:09:43 +0530
Message-ID: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Does the followiing
- Make the revision a 32- bit consisting of rev_lo amd rev_hi each
of 16 bits.

- Also use the revision register for the erratum i207.

Also more cleanup is possible will check on that subsequently.


Tested on OMAP4430sdp  ,4460 ,omap3630 and 3430.

todo: omap2 testing.

Shubhrajyoti D (2):
  i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
  i2c: omap: Fix the revision register read

 drivers/i2c/busses/i2c-omap.c |   62 +++++++++++++++++++++++++++++++---------
 1 files changed, 48 insertions(+), 14 deletions(-)

-- 
1.7.5.4
