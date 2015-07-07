From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 0/2] ARM: dra7: fix DCAN glitch
Date: Tue, 7 Jul 2015 17:27:55 +0300
Message-ID: <1436279277-3386-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

If "default" pins are active for CAN then there is a slight
window during boot when CAN pins are in active mode and can
affect DRA7 CAN stability. This is because device core
automatically selects "default" before probe.

These patches change "default" pins to inactive and adds
a new "active" pin state so that we don't encounter
the glitch mentioned above.

cheers,
-roger

J.D. Schroeder (1):
  net: can: c_can: Fix default pinmux glitch at init

Roger Quadros (1):
  ARM: dts: dra7x-evm: Prevent glitch on DCAN1 pinmux

 arch/arm/boot/dts/dra7-evm.dts  |  5 +++--
 arch/arm/boot/dts/dra72-evm.dts |  5 +++--
 drivers/net/can/c_can/c_can.c   | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.1.4

