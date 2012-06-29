From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 0/3] I2C: Report the actual transferred bytes
Date: Fri, 29 Jun 2012 16:35:24 +0530
Message-ID: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Currently the I2C core reports only a negative number on errors.
However some of the users in case of errors want to re-transfer only
the remaining bytes.

The patch series tries to add a actual field to the msg which
can be checked by the user.

Also a patch to implement the actual bytes transferred in case of
i2c-omap.


Felipe Balbi (1):
  i2c: omap: implement handling for 'actual' bytes transferred

Shubhrajyoti D (2):
  i2c: add 'actual' field to struct i2c_msg
  i2c: inititalise the actual transferred to zero

 drivers/i2c/busses/i2c-omap.c |    5 +++++
 drivers/i2c/i2c-core.c        |    4 ++--
 include/linux/i2c.h           |    1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.7.5.4
