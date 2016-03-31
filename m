From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] ARM: OMAP: DRA7: Updates for power domain data
Date: Thu, 31 Mar 2016 16:58:32 -0500
Message-ID: <1459461515-5192-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

First level updates for power domain data, in line with the latest
AM57xx and DRA7 TRMs.

NOTE: follow on patches are pending for the following:

a) wakeupgen is somehow messedup again and mpu pd no
longer goes to low power mode. I am looking into that.
http://pastebin.ubuntu.com/15571519/ gets past that story - but I see
mpu_pwrdm stuck in ON though..

b) beagleboard-X15 does require the following patch
https://patchwork.kernel.org/patch/8718431/

c) We do have yet another major TRM update to only allow ON and OFF
for all power domains other than core and MPU (MPU still will support
CSWR) - I am still waiting for TRM update to take place before we can
actually post upstream.

BeagleBoard-X15 test log: http://pastebin.ubuntu.com/15571570/

series based on: v4.6-rc1

Nishanth Menon (3):
  ARM: OMAP: DRA7: powerdomain data: Erratum i892 workaround: Disable
    core INA
  ARM: OMAP: DRA7: powerdomain data: Fix "ON" state for memories
  ARM: OMAP: DRA7: powerdomain data: Remove wrong OSWR capability

 arch/arm/mach-omap2/powerdomains7xx_data.c | 82 +++++++++++++++---------------
 1 file changed, 41 insertions(+), 41 deletions(-)

-- 
2.8.0
