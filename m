From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] ARM: OMAP: Fix i2c cmdline initcall for multiplatform
Date: Wed, 19 Dec 2012 11:26:20 -0800
Message-ID: <20121219192620.22098.41783.stgit@muffinssi.local>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:62030 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753699Ab2LST0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 14:26:22 -0500
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We only want this initcall to run when the kernel is
booted on omap SoCs. Fix the issue by initializing the
the initcall from separately for omap1 and omap2+.

This fixes the issue for omap2+ multiplatform configs
as we are using omap_subsys_initcall there.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/i2c.c             |    6 ++++++
 arch/arm/mach-omap2/i2c.c             |    5 +++++
 arch/arm/plat-omap/i2c.c              |    3 +--
 arch/arm/plat-omap/include/plat/i2c.h |    6 ++++++
 4 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index faca808..7f5761c 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -91,3 +91,9 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
 
 	return platform_device_register(pdev);
 }
+
+static  int __init omap_i2c_cmdline(void)
+{
+	return omap_register_i2c_bus_cmdline();
+}
+subsys_initcall(omap_i2c_cmdline);
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index fbb9b15..9eb146f 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -165,3 +165,8 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
 	return PTR_RET(pdev);
 }
 
+static  int __init omap_i2c_cmdline(void)
+{
+	return omap_register_i2c_bus_cmdline();
+}
+omap_subsys_initcall(omap_i2c_cmdline);
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index f9df624..58213d9 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -68,7 +68,7 @@ __setup("i2c_bus=", omap_i2c_bus_setup);
  * Register busses defined in command line but that are not registered with
  * omap_register_i2c_bus from board initialization code.
  */
-static int __init omap_register_i2c_bus_cmdline(void)
+int __init omap_register_i2c_bus_cmdline(void)
 {
 	int i, err = 0;
 
@@ -83,7 +83,6 @@ static int __init omap_register_i2c_bus_cmdline(void)
 out:
 	return err;
 }
-subsys_initcall(omap_register_i2c_bus_cmdline);
 
 /**
  * omap_register_i2c_bus - register I2C bus with device descriptors
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 7a9028c..810629d 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -32,6 +32,7 @@ int omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
 				 unsigned len);
+extern int omap_register_i2c_bus_cmdline(void);
 #else
 static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
@@ -39,6 +40,11 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 {
 	return 0;
 }
+
+static inline int omap_register_i2c_bus_cmdline(void)
+{
+	return 0;
+}
 #endif
 
 struct omap_hwmod;

