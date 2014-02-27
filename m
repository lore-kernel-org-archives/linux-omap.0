From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] mfd: twl6040: Updates for i2s speed and fix for chip deadlock
Date: Thu, 27 Feb 2014 15:56:47 +0200
Message-ID: <1393509410-1640-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: florian.vaussard@epfl.ch, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi,

While looking into a report by Florian Vaussard [1] I have noticed couple of most
likely unrelated issues:
- all boards using twl6040 configures the i2c bus to 400KHz while twl6040 is set
  to 100KHz as default.
- if I set the audpwron GPIO high [2] in the bootloader the i2c communication towards
  twl6040 will be broken

The solution or these are:
set the twl6040 to i2c fast mode with regmap patch
Clear the INTID register right after we request the audpwron GPIO and set it to
low.

Generated on top of:
git://git.linaro.org/people/lee.jones/mfd.git for-mfd-next

Tested on PandaBoard, PandaBoardES, OMAP4-blaze (SDP)

[1] http://www.spinics.net/lists/arm-kernel/msg310725.html
[2] Command in u-boot to enable the audpwron on PandaBoards: gpio set 127

Regards,
Peter
---
Peter Ujfalusi (3):
  mfd: twl6040: Select i2c fast mode as default with regmap patch
  mfd: twl6040: Move register patching earlier in probe
  mfd: twl6040: Clear the interrupt ID register before requesting IRQ

 drivers/mfd/twl6040.c       | 20 ++++++++++++++------
 include/linux/mfd/twl6040.h |  1 +
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
1.9.0
