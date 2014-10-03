From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] CLK: TI: Remove unused includes of linux/clk-private.h
Date: Fri,  3 Oct 2014 17:51:59 +0200
Message-ID: <1412351519-29214-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/clk/ti/clk-44xx.c | 1 -
 drivers/clk/ti/clk-54xx.c | 1 -
 drivers/clk/ti/clk-7xx.c  | 1 -
 include/linux/clk/ti.h    | 1 +
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index 02517a8..8ea705e 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/clk-private.h>
 #include <linux/clkdev.h>
 #include <linux/clk/ti.h>
 
diff --git a/drivers/clk/ti/clk-54xx.c b/drivers/clk/ti/clk-54xx.c
index 5e18399..e823d0b 100644
--- a/drivers/clk/ti/clk-54xx.c
+++ b/drivers/clk/ti/clk-54xx.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/clk-private.h>
 #include <linux/clkdev.h>
 #include <linux/io.h>
 #include <linux/clk/ti.h>
diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 62ac8f6..afd61a6 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -12,7 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/clk-private.h>
 #include <linux/clkdev.h>
 #include <linux/clk/ti.h>
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index e8d8a35..ced953a 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -16,6 +16,7 @@
 #define __LINUX_CLK_TI_H__
 
 #include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 
 /**
  * struct dpll_data - DPLL registers and integration data
-- 
1.9.3
