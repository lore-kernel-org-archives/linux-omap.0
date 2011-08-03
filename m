From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/2] I2C: OMAP: misc. PM-related cleanups
Date: Wed,  3 Aug 2011 11:09:18 -0700
Message-ID: <1312394960-21689-1-git-send-email-khilman@ti.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Do some PM-related cleanup on this driver and make the runtime PM
usage more standard.

Series applies on Andy's I2C cleanup series (for_3.1/i2c-andy-2 branch
in my tree[1]) plus the misc. i2c fixes queued for v3.1-rc
(for_3.1/i2c-fixes branch) and are available in the
for_3.2/i2c-cleanup branch of my tree.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Kevin Hilman (2):
  I2C: OMAP: remove unneccesary use of pdev
  I2C: OMAP: remove dev->idle, use usage counting provided by runtime
    PM

 drivers/i2c/busses/i2c-omap.c |   76 +++++++++++++++++++++++------------------
 1 files changed, 43 insertions(+), 33 deletions(-)

-- 
1.7.6
