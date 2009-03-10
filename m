From: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [2.6.29-rc7][take #2][PATCH 1/3] ARM: OMAP: Add documentation for function omap_register_i2c_bus
Date: Tue, 10 Mar 2009 10:47:09 +0200
Message-ID: <1236674831-3637-2-git-send-email-jarkko.nikula@nokia.com>
References: <20090306161349.GC32353@atomide.com>
 <1236674831-3637-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1236674831-3637-1-git-send-email-jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Jarkko Nikula <jarkko.nikula-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
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
