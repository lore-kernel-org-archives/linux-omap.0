From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/6] twl4030: Various fixes for charing-from-USB
Date: Wed, 25 Apr 2012 17:33:10 +1000
Message-ID: <20120425072931.20124.56635.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Following are a collection of patches that I've need using for a while
to make sure the charge-from-usb on my GTA04 works.
Hopefully I've included the right people in the recipient list :-)

The issues are:
 - charge the backup battery as well as the main battery
 - charge from a charger which ties ID to ground via a resistor
 - charge while device is suspended, or when no gadget module is
   loaded (i.e. when the USB side thinks the phy should be powered
   down).

Questions and comments more welcome.

Thanks,
NeilBrown


---

NeilBrown (6):
      twl4030-usb: Don't report EVENT_ID when there is VBUS.
      twl4030-usb: Don't power down phy when it is in-use by charger.
      twl4030_charger: Allow charger to control the regulator that feeds it.
      twl4030_charger: allow charging whenever VBUS is present.
      twl4030_charger: add backup-battery charging.
      twl4030_charger: Fix some typos


 drivers/mfd/twl-core.c          |    9 ++--
 drivers/power/twl4030_charger.c |   86 +++++++++++++++++++++++++++++++++++----
 drivers/usb/otg/twl4030-usb.c   |   27 ++++++++----
 include/linux/i2c/twl.h         |    2 +
 4 files changed, 102 insertions(+), 22 deletions(-)

-- 
Signature
