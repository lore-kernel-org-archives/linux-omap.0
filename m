From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ARM: OMAP: Add documentation for function omap_register_i2c_bus
Date: Sun,  8 Feb 2009 19:32:47 +0200
Message-ID: <1234114369-11399-2-git-send-email-jhnikula@gmail.com>
References: <1234114369-11399-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:55513 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbZBHRap (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Feb 2009 12:30:45 -0500
Received: by ewy14 with SMTP id 14so2177451ewy.13
        for <linux-omap@vger.kernel.org>; Sun, 08 Feb 2009 09:30:44 -0800 (PST)
In-Reply-To: <1234114369-11399-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

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
1.5.6.5

