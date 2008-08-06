From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv3] TWL4030: mark init-only functions as __init
Date: Wed, 6 Aug 2008 00:43:51 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0808060043180.18201@utopia.booyaka.com>
References: <20080804205134.22691.75138.stgit@localhost.localdomain> <20080804205643.22691.41661.stgit@localhost.localdomain> <20080805084838.GD7193@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52351 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755852AbYHFGn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 02:43:59 -0400
In-Reply-To: <20080805084838.GD7193@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org


Mark many functions in twl4030-core.c as __init.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/chips/twl4030-core.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 58ac7f5..205245d 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -693,7 +693,8 @@ static void do_twl4030_irq(unsigned int irq, irq_desc_t *desc)
 }
 
 /* attach a client to the adapter */
-static int twl4030_detect_client(struct i2c_adapter *adapter, unsigned char sid)
+static int __init twl4030_detect_client(struct i2c_adapter *adapter,
+					unsigned char sid)
 {
 	int err = 0;
 	struct twl4030_client *twl;
@@ -742,7 +743,7 @@ static int twl4030_detect_client(struct i2c_adapter *adapter, unsigned char sid)
 }
 
 /* adapter callback */
-static int twl4030_attach_adapter(struct i2c_adapter *adapter)
+static int __init twl4030_attach_adapter(struct i2c_adapter *adapter)
 {
 	int i;
 	int ret = 0;
@@ -795,7 +796,7 @@ static int twl4030_detach_client(struct i2c_client *client)
 	return 0;
 }
 
-static struct task_struct *start_twl4030_irq_thread(int irq)
+static struct task_struct * __init start_twl4030_irq_thread(int irq)
 {
 	struct task_struct *thread;
 
@@ -813,7 +814,7 @@ static struct task_struct *start_twl4030_irq_thread(int irq)
  * These three functions should be part of Voltage frame work
  * added here to complete the functionality for now.
  */
-static int protect_pm_master(void)
+static int __init protect_pm_master(void)
 {
 	int e = 0;
 
@@ -822,7 +823,7 @@ static int protect_pm_master(void)
 	return e;
 }
 
-static int unprotect_pm_master(void)
+static int __init unprotect_pm_master(void)
 {
 	int e = 0;
 
@@ -833,7 +834,7 @@ static int unprotect_pm_master(void)
 	return e;
 }
 
-static int power_companion_init(void)
+static int __init power_companion_init(void)
 {
 	struct clk *osc;
 	u32 rate;
@@ -878,7 +879,7 @@ static int power_companion_init(void)
  * status register to ensure that any prior interrupts are cleared.
  * Returns the status from the I2C read operation.
  */
-static int twl4030_i2c_clear_isr(u8 mod_no, u8 reg, u8 cor)
+static int __init twl4030_i2c_clear_isr(u8 mod_no, u8 reg)
 {
 	u8 tmp;
 
