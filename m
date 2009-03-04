From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] ARM: OMAP: Add documentation for function
	omap_register_i2c_bus
Date: Wed, 04 Mar 2009 13:49:48 -0800
Message-ID: <20090304214948.21101.30883.stgit@localhost>
References: <20090304214540.21101.72079.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55410 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbZCDVtv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 16:49:51 -0500
In-Reply-To: <20090304214540.21101.72079.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

