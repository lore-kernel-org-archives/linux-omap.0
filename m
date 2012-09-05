From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 0/4] can: c_can: Add suspend/resume and pinctrl support
Date: Wed, 5 Sep 2012 16:42:40 +0530
Message-ID: <1346843564-25343-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Sender: linux-can-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>
List-Id: linux-omap@vger.kernel.org

Adds suspend/resume functionality of d_can driver along with d_can
raminit support which is required to initialize RAM while data
transmission.

This patch series also adds pinctrl support to c_can driver. These
patches were tested on AM335x-EVM.

This patch-series is based ontop of runtimePM patch submitted
earlier - https://patchwork.kernel.org/patch/1348081/

Changes from v1:
	- Incorporated Marc's comments on v1
	  * Changed marco name with units in it
	  * Used ndev->flags for link status instead of new member
	  * Added BUG_ON inside *_power_down and *_power_up APIs
	  * Added new member "type" in c_can_priv struct for keeping
	    dev id details/name.

AnilKumar Ch (4):
  can: c_can: Adopt pinctrl support
  can: c_can: Add d_can raminit support
  ARM: AM33XX: board-generic: Add of_dev_auxdata to pass d_can raminit
  can: c_can: Add d_can suspend resume support

 arch/arm/mach-omap2/board-generic.c    |   40 +++++++++++++-
 arch/arm/mach-omap2/control.h          |    4 ++
 drivers/net/can/c_can/c_can.c          |   95 ++++++++++++++++++++++++++++++++
 drivers/net/can/c_can/c_can.h          |   10 ++++
 drivers/net/can/c_can/c_can_platform.c |   79 ++++++++++++++++++++++++++
 include/linux/can/platform/c_can.h     |   36 ++++++++++++
 6 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/can/platform/c_can.h

-- 
1.7.9.5

