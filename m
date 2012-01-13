From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv9 0/2] I2C driver updates
Date: Fri, 13 Jan 2012 12:27:04 +0530
Message-ID: <1326437826-7408-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The patch series does the following 

- Removes the reset from probe and inplements a seperate 
  function.
- Removes the reset from init as hwmod does it.
- The second patch inplements the recovery from bus busy condition

Tested on omap4sdp and omap3430

applies to Kevin's  for_3.3/i2c/misc

Shubhrajyoti D (1):
  OMAP : I2C : Remove reset at init

Vikram Pandita (1):
  I2C: OMAP: Recover from bus busy condition

 drivers/i2c/busses/i2c-omap.c |   53 +++++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 10 deletions(-)
