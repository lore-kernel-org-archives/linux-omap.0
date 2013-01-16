From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/11] MFD: twl-core: Cleanup part 2 for 3.9
Date: Wed, 16 Jan 2013 14:53:48 +0100
Message-ID: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello Samuel,

Changes since v1:
- Patch for zoom-display to avoid build issus with this set

I had a patch on top of this series to move the zoom board to use bl-pwm for
display backlight. Because of this I have not noticed that the zoom-display.c
still have twl related code in upstream.

Cover letter from v1:

Second part of the cleanup of twl-core which aims to make the code a bit more
readable.
It has been tested on: OMAP4 PandaBoard, OMAP4 Blaze, OMAP3 BeagleBoard, OMAP3
Zoom2.

Regards,
Peter
---
Peter Ujfalusi (11):
  ARM: OMAP: zoom-display: Remove the use of TWL4030_MODULE_PWM1
  mfd: twl-core: Clean up module id lookup and definitions
  mfd: twl-core: No need to check for invalid subchip ID
  mfd: twl-core: Use the lookup table to find the correct subchip for
    the modules
  mfd: twl-core: Allocate twl_modules dynamically
  mfd: twl-core: Do not try to call legacy mfd add_children() when
    booted with DT
  mfd: twl-core: Do not create dummy pdata when booted with DT
  mfd: twl-core: Move 'inuse' check early at probe time
  mfd: twl-core: Collect global variables behind one private structure
    (global)
  mfd: twl-core: Remove no longer valid comment regarding to write
    buffer size
  mfd: twl-core: Move twl_i2c_read/write_u8 to header as inline function
 arch/arm/mach-omap2/board-zoom-display.c |  14 +-
 drivers/mfd/twl-core.c                   | 362 ++++++++++++++-----------------
 include/linux/i2c/twl.h                  |  84 +++----
 3 files changed, 212 insertions(+), 248 deletions(-)

-- 
1.8.1
