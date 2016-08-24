From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] memory: omap-gpmc: Fix build with CONFIG_OMAP_GPMC disabled
Date: Wed, 24 Aug 2016 12:19:54 +0300
Message-ID: <1472030394-11609-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Fix the following build failure if omap-gpmc.h is
used with CONFIG_OMAP_GPMC disabled.

./include/linux/omap-gpmc.h:32:1: error: unknown type name ‘gpmc_nand_ops’

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/linux/omap-gpmc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index 9e9d79e..35d0fd7 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -29,8 +29,8 @@ struct gpmc_nand_regs;
 struct gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *regs,
 					     int cs);
 #else
-static inline gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *regs,
-						    int cs)
+static inline struct gpmc_nand_ops *gpmc_omap_get_nand_ops(struct gpmc_nand_regs *regs,
+							   int cs)
 {
 	return NULL;
 }
-- 
2.7.4
