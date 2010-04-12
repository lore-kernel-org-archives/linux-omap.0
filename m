From: <viral.mehta@lntinfotech.com>
Subject: [PATCH] omap: Add I2C bus 1 initialisation
Date: Mon, 12 Apr 2010 10:01:44 +0530
Message-ID: <1271046704-10444-1-git-send-email-viral.mehta@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail142.messagelabs.com ([216.82.249.99]:41578 "EHLO
	mail142.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab0DLEbg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 00:31:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-usb@vger.kernel.org, Viral Mehta <viral.mehta@lntinfotech.com>

From: Viral Mehta <viral.mehta@lntinfotech.com>

Initialize isp1301 FS USB transceiver and
add I2C bus1 initialization code for OMAP2430 SDP

Signed-off-by: Viral Mehta <viral.mehta@lntinfotech.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 01d113f..346e1d2 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -174,9 +174,17 @@ static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] = {
        },
 };

+static struct i2c_board_info __initdata sdp2430_i2c1_boardinfo[] = {
+       {
+               I2C_BOARD_INFO("isp1301_omap", 0x2D),
+               .flags = I2C_CLIENT_WAKE,
+               .irq = OMAP_GPIO_IRQ(78),
+       },
+}
 static int __init omap2430_i2c_init(void)
 {
-       omap_register_i2c_bus(1, 400, NULL, 0);
+       omap_register_i2c_bus(1, 100, sdp2430_i2c1_boardinfo,
+                       ARRAY_SIZE(sdp2430_i2c1_boardinfo));
        omap_register_i2c_bus(2, 2600, sdp2430_i2c_boardinfo,
                        ARRAY_SIZE(sdp2430_i2c_boardinfo));
        return 0;
--
1.6.6


This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
