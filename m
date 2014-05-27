From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 0/6] mfd: twl4030-power: Enable off-idle configuration when booted with device tree
Date: Tue, 27 May 2014 11:08:54 -0700
Message-ID: <1401214140-9828-1-git-send-email-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Lee,

Here are these patches for you again as you requested.
I left out the last patch in the series containing the
related .dts changes to enable these features as
that I can apply separately.

Regards,

Tony


Tony Lindgren (6):
  mfd: twl4030-power: Fix hang on reboot if sleep configuration was
    loaded earlier
  mfd: twl4030-power: Fix some defines for SW_EVENTS
  mfd: twl4030-power: Add generic reset configuration
  mfd: twl4030-power: Add recommended idle configuration
  mfd: twl4030-power: Add support for board specific configuration
  mfd: twl4030-power: Add a configuration to turn off oscillator during
    off-idle

 .../devicetree/bindings/mfd/twl4030-power.txt      |  17 +-
 drivers/mfd/twl4030-power.c                        | 286 +++++++++++++++++++--
 include/linux/i2c/twl.h                            |   4 +
 3 files changed, 281 insertions(+), 26 deletions(-)

-- 
1.8.1.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
