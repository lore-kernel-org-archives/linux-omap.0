From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHV3 0/4] The series attempts to do the following
Date: Thu, 21 Jul 2011 19:22:57 +0530
Message-ID: <1311256381-25548-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

- The reset should not be done in the driver 
  have support for the same.
- Remove the sysc register access in the driver.
- Restore the context only if the context is lost.

version 2
 - Fix the indentation.
 - Restore in the error path is not needed as we are
   doing a init.

version 3
 - Combine the patch 1 and 2 as i2c-omap.h isn't a generic header

Acknowledge Balaji and Santosh for the review comments.
Tested on sdp4430 and on omap3430

Shubhrajyoti D (4):
  OMAP: I2C: Reset support
  OMAP: I2C: Remove the reset in the init path
  OMAP: I2C: Remove the SYSC register definition
  OMAP: I2C: I2C register restore only if context is lost

 arch/arm/plat-omap/i2c.c      |   17 +++++++
 drivers/i2c/busses/i2c-omap.c |  101 ++++++++++++++++-------------------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 57 insertions(+), 62 deletions(-)
