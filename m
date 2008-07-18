From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] TWL4030: mark init-only functions as __init
Date: Thu, 17 Jul 2008 20:15:50 -0600
Message-ID: <20080718021547.31884.19561.stgit@localhost.localdomain>
References: <20080718021356.31884.9848.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44361 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbYGRCQh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 22:16:37 -0400
In-Reply-To: <20080718021356.31884.9848.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Mark many functions in twl4030-core.c as __init.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/chips/twl4030-core.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 47d547d..54e392b 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -681,7 +681,8 @@ static void do_twl4030_irq(unsigned int irq, irq_desc_t *desc)
 }
 
 /* attach a client to the adapter */
-static int twl4030_detect_client(struct i2c_adapter *adapter, unsigned char sid)
+static int __init twl4030_detect_client(struct i2c_adapter *adapter,
+					unsigned char sid)
 {
 	int err = 0;
 	struct twl4030_client *twl;
@@ -730,7 +731,7 @@ static int twl4030_detect_client(struct i2c_adapter *adapter, unsigned char sid)
 }
 
 /* adapter callback */
-static int twl4030_attach_adapter(struct i2c_adapter *adapter)
+static int __init twl4030_attach_adapter(struct i2c_adapter *adapter)
 {
 	int i;
 	int ret = 0;
@@ -783,7 +784,7 @@ static int twl4030_detach_client(struct i2c_client *client)
 	return 0;
 }
 
-static struct task_struct *start_twl4030_irq_thread(int irq)
+static struct task_struct * __init start_twl4030_irq_thread(int irq)
 {
 	struct task_struct *thread;
 
@@ -801,7 +802,7 @@ static struct task_struct *start_twl4030_irq_thread(int irq)
  * These three functions should be part of Voltage frame work
  * added here to complete the functionality for now.
  */
-static int protect_pm_master(void)
+static int __init protect_pm_master(void)
 {
 	int e = 0;
 
@@ -810,7 +811,7 @@ static int protect_pm_master(void)
 	return e;
 }
 
-static int unprotect_pm_master(void)
+static int __init unprotect_pm_master(void)
 {
 	int e = 0;
 
@@ -821,7 +822,7 @@ static int unprotect_pm_master(void)
 	return e;
 }
 
-static int power_companion_init(void)
+static int __init power_companion_init(void)
 {
 	struct clk *osc;
 	u32 rate;
@@ -866,7 +867,7 @@ static int power_companion_init(void)
  * don't know whether the COR bit is set in <module>_SIH_CTRL.  Returns
  * the status from the I2C read operation.
  */
-static int twl4030_i2c_clear_isr(u8 mod_no, u8 reg)
+static int __init twl4030_i2c_clear_isr(u8 mod_no, u8 reg)
 {
 	int res;
 	u8 tmp;
@@ -878,7 +879,7 @@ static int twl4030_i2c_clear_isr(u8 mod_no, u8 reg)
 	return twl4030_i2c_write_u8(mod_no, 0xff, reg);
 }
 
-static void twl_init_irq(void)
+static void __init twl_init_irq(void)
 {
 	int	i, j;
 	int	res = 0;


