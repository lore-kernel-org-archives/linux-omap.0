From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.24-rc3-omap1] i2c init section fixes
Date: Fri, 23 Nov 2007 23:20:05 -0800
Message-ID: <200711232320.05916.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Fix init section warnings in the new i2c init code.  It's
wrong to call "__init" functions from non-__init ones.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -80,7 +80,7 @@ #if	defined(CONFIG_ARCH_OMAP34XX)
 #endif
 };
 
-static void omap_i2c_mux_pins(int bus_id)
+static void __init omap_i2c_mux_pins(int bus_id)
 {
 	/* TODO: Muxing for OMAP3 */
 	switch (bus_id) {
@@ -102,7 +102,7 @@ static void omap_i2c_mux_pins(int bus_id
 	}
 }
 
-int omap_register_i2c_bus(int bus_id, u32 clkrate,
+int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			  struct i2c_board_info const *info,
 			  unsigned len)
 {
