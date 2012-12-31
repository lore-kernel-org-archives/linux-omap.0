From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 00/10] MFD: twl-core: Cleanup part 2 for 3.9
Date: Mon, 31 Dec 2012 12:09:21 +0100
Message-ID: <1356952171-6109-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello,

Second part of the cleanup of twl-core which aims to make the code a bit more
readable.
It has been tested on: OMAP4 PandaBoard, OMAP4 Blaze, OMAP3 BeagleBoard, OMAP3
Zoom2.

Regards,
Peter
---
Peter Ujfalusi (10):
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
 drivers/mfd/twl-core.c  | 362 +++++++++++++++++++++---------------------------
 include/linux/i2c/twl.h |  84 +++++------
 2 files changed, 205 insertions(+), 241 deletions(-)

-- 
1.8.0.2
