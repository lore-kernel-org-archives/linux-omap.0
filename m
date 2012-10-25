From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv4 0/2] i2c: omap: cleanups
Date: Thu, 25 Oct 2012 20:09:47 +0530
Message-ID: <1351175989-6401-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Applies on Felipe's series
http://www.spinics.net/lists/linux-omap/msg79995.html

Tested with Terro sys fix + Felipe's stop sched_clock() during suspend
on omap3630 beagle both idle and suspend.

Functional testing on omap4sdp.

Todo: all the error cases may not need a reset. 

Shubhrajyoti D (2):
  i2c: omap: re-factor omap_i2c_init function
  i2c: omap: make reset a seperate function

 drivers/i2c/busses/i2c-omap.c |   97 +++++++++++++++++++++--------------------
 1 files changed, 50 insertions(+), 47 deletions(-)

-- 
1.7.5.4
