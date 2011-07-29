From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv5 0/3] I2C driver updates
Date: Fri, 29 Jul 2011 16:06:50 +0530
Message-ID: <1311935813-8481-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The series attempts to do the following

- The reset should not be done in the driver 
  have support for the same.
- Remove the sysc register access in the driver.

version 2
 - Fix the indentation.
 - Restore in the error path is not needed as we are
   doing a init.

version 3
 - Combine the patch 1 and 2 as i2c-omap.h isn't a generic header

version 4/5
 - Making the changelogs more descriptive.
 - Rebasing to the wip/i2c branch

Acknowledge Balaji ,Santosh and Kevin for the review comments.
Tested on sdp4430 and on omap3430

Has dependency on the following patch
https://patchwork.kernel.org/patch/904582/


Shubhrajyoti D (3):
  OMAP: I2C: Reset support
  OMAP: I2C: Remove the reset in the init path
  OMAP: I2C: Remove the SYSC register definition

 arch/arm/plat-omap/i2c.c      |   18 ++++++++
 drivers/i2c/busses/i2c-omap.c |   88 ++++++++++------------------------------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 41 insertions(+), 66 deletions(-)
