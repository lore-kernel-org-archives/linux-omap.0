From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RESEND 0/3] mfd: twl6040: Updates for i2s speed and fix for chip deadlock
Date: Tue, 1 Apr 2014 16:44:58 +0300
Message-ID: <1396359901-32656-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39214 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbaDANpJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Apr 2014 09:45:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com, nm@ti.com

Hi,

While looking into a report by Florian Vaussard [1] I have noticed couple of most
likely unrelated issues:
- all boards using twl6040 configures the i2c bus to 400KHz while twl6040 is set
  to 100KHz as default.
- if I set the audpwron GPIO high [2] in the bootloader the i2c communication towards
  twl6040 will be broken
- got confirmation from HW design teams that twl6040 can work on a bus with
  400KHz even if after hard reset but it is optimal to swithc to 400KHz mode as
  soon as possible.

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

 drivers/mfd/twl6040.c       | 19 +++++++++++++------
 include/linux/mfd/twl6040.h |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
1.9.1

