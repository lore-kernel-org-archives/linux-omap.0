From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv8 0/5] I2C driver  updates
Date: Tue, 13 Dec 2011 16:25:53 +0530
Message-ID: <1323773758-6375-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The series attempts to do the following

- The reset should not be done in the driver 
  have support for the same.
- Remove the sysc register access in the driver.


Incorporated review comments:

 - Fix the indentation of the code.
 - Restore in the error path is not needed as we are
   doing a init.
 - Combine the patch 1 and 2 as i2c-omap.h isn't a generic header
 - Making the changelogs more descriptive.
 - Add a default clockactivity field.
 - Renaming omap2_i2c_reset() to  omap_device_reset() and move it to omap_device.c
 - iterate over all of the hwmods in the omap_device and call omap_hwmod_reset() on
   each.


This is rebased on Kevin's tree  for_3.2/fixes/i2c branch.


Acknowledge Balaji ,Santosh ,Kevin , Paul and Jon for the review comments.



Shubhrajyoti D (5):
  OMAP3+: HWMOD: Add the default clockactivity for I2C
  OMAP: hwmod/device : add omap_device_reset to reset all the hwmods in
    the device
  OMAP: I2C: Reset support
  OMAP: I2C: Remove the reset in the init path
  OMAP: I2C: Remove the SYSC register definition

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    7 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |    9 ++-
 arch/arm/plat-omap/i2c.c                      |    2 +
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   22 ++++++
 drivers/i2c/busses/i2c-omap.c                 |   88 +++++++------------------
 include/linux/i2c-omap.h                      |    1 +
 7 files changed, 58 insertions(+), 72 deletions(-)
