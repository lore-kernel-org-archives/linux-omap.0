From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Clean-up for twl4030-usb
Date: Wed, 27 Aug 2014 16:28:06 -0700
Message-ID: <1409182091-31191-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com
Cc: balbi@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Here are few more patches for v3.18 to clean up twl4030-usb.

These are based on the two regression fixes I sent earlier:

[PATCH] usb: phy: twl4030-usb: Fix regressions to runtime PM on omaps
[PATCH] usb: phy: twl4030-usb: Fix lost interrupts after ID pin goes down

For testing with v3.17-rc2, you probably also want to revert
commit a9232076374334ca2bc2a448dfde96d38a54349a until that
hits the mainline tree. And you may also want to apply the
following patch if testing with PM:

[PATCH] mfd: twl4030-power: Fix PM idle pin configuration to not conflict with regulators

I've also pushed these patches with the optional patches
into a temporary testing branch at [1].

Regards,

Tony

[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git omap-for-v3.17/testing-pending-usb

Tony Lindgren (5):
  usb: phy: twl4030-usb: Remove unused irq_enabled
  usb: phy: twl4030-usb: Simplify phy init to use runtime PM
  usb: phy: twl4030-usb: Move code from twl4030_phy_power to the runtime
    PM calls
  usb: phy: twl4030-usb: Remove asleep and rely on runtime PM
  usb: phy: twl4030-usb: Use mutex instead of spinlock for protecting
    the data

 drivers/phy/phy-twl4030-usb.c     | 124 ++++++++++++++------------------------
 drivers/usb/phy/phy-twl6030-usb.c |   2 -
 2 files changed, 46 insertions(+), 80 deletions(-)

-- 
1.8.1.1
