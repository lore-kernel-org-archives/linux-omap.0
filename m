From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] bus: omap: add MODULE_LICENSE tags
Date: Thu, 11 Jan 2018 10:36:51 +0100
Message-ID: <20180111093707.2615555-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: arm@kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sricharan R <sricharan@codeaurora.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

linux-4.15 warns about missing MODULE_LICENSE tags such as these

WARNING: modpost: missing MODULE_LICENSE() in drivers/bus/omap_l3_noc.o
WARNING: modpost: missing MODULE_LICENSE() in drivers/bus/omap_l3_smx.o

For completeness, I'm also adding MODULE_AUTHOR and MODULE_DESCRIPTION
tags, but I decided to leave out the email addresses, as all three
authors are working for other companies now.

Cc: Sricharan R <sricharan@codeaurora.org>
Cc: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Unless someone sees a problem here, I'd pick this up into arm-soc
directly, either the fixes or drivers branch
---
 drivers/bus/omap_l3_noc.c | 5 +++++
 drivers/bus/omap_l3_smx.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 5012e3ad1225..b040447575ad 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -375,3 +375,8 @@ static void __exit omap_l3_exit(void)
 	platform_driver_unregister(&omap_l3_driver);
 }
 module_exit(omap_l3_exit);
+
+MODULE_AUTHOR("Santosh Shilimkar");
+MODULE_AUTHOR("Sricharan R");
+MODULE_DESCRIPTION("OMAP L3 Interconnect error handling driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
index 360a5c0a4ee0..b853a729537a 100644
--- a/drivers/bus/omap_l3_smx.c
+++ b/drivers/bus/omap_l3_smx.c
@@ -309,3 +309,9 @@ static void __exit omap3_l3_exit(void)
 	platform_driver_unregister(&omap3_l3_driver);
 }
 module_exit(omap3_l3_exit);
+
+MODULE_AUTHOR("Felipe Balbi");
+MODULE_AUTHOR("Santosh Shilimkar");
+MODULE_AUTHOR("Sricharan R");
+MODULE_DESCRIPTION("OMAP3XXX L3 Interconnect Driver");
+MODULE_LICENSE("GPL");
-- 
2.9.0
