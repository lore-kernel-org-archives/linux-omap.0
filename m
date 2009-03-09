From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.29-rc7][take #2][PATCH 1/3] ARM: OMAP: Add documentation for function omap_register_i2c_bus
Date: Mon,  9 Mar 2009 15:45:57 +0200
Message-ID: <1236606359-20362-2-git-send-email-jarkko.nikula@nokia.com>
References: <1236606359-20362-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37235 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbZCINqN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2009 09:46:13 -0400
In-Reply-To: <1236606359-20362-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/i2c.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 467531e..3e95954 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -119,6 +119,15 @@ static void __init omap_i2c_mux_pins(int bus)
 	omap_cfg_reg(scl);
 }
 
+/**
+ * omap_register_i2c_bus - register I2C bus with device descriptors
+ * @bus_id: bus id counting from number 1
+ * @clkrate: clock rate of the bus in kHz
+ * @info: pointer into I2C device descriptor table or NULL
+ * @len: number of descriptors in the table
+ *
+ * Returns 0 on success or an error code.
+ */
 int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
 			  unsigned len)
-- 
1.6.1.3

