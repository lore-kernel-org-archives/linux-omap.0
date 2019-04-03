From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 10/12] i2c: stu300: use xfer_atomic callback to bail out early
Date: Wed,  3 Apr 2019 14:40:17 +0200
Message-ID: <20190403124019.8947-11-wsa+renesas@sang-engineering.com>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-omap@vger.kernel.org

Use the new callback to reject atomic transfers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-stu300.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 5503fa171df0..743c161b22c5 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -328,12 +328,6 @@ static int stu300_start_and_await_event(struct stu300_dev *dev,
 {
 	int ret;
 
-	if (unlikely(irqs_disabled())) {
-		/* TODO: implement polling for this case if need be. */
-		WARN(1, "irqs are disabled, cannot poll for event\n");
-		return -EIO;
-	}
-
 	/* Lock command issue, fill in an event we wait for */
 	spin_lock_irq(&dev->cmd_issue_lock);
 	init_completion(&dev->cmd_complete);
@@ -380,13 +374,6 @@ static int stu300_await_event(struct stu300_dev *dev,
 {
 	int ret;
 
-	if (unlikely(irqs_disabled())) {
-		/* TODO: implement polling for this case if need be. */
-		dev_err(&dev->pdev->dev, "irqs are disabled on this "
-			"system!\n");
-		return -EIO;
-	}
-
 	/* Is it already here? */
 	spin_lock_irq(&dev->cmd_issue_lock);
 	dev->cmd_err = STU300_ERROR_NONE;
@@ -846,6 +833,13 @@ static int stu300_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	return num;
 }
 
+static int stu300_xfer_todo(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+{
+	/* TODO: implement polling for this case if need be. */
+	WARN(1, "%s: atomic transfers not implemented\n", dev_name(&adap->dev));
+	return -EOPNOTSUPP;
+}
+
 static u32 stu300_func(struct i2c_adapter *adap)
 {
 	/* This is the simplest thing you can think of... */
@@ -853,8 +847,9 @@ static u32 stu300_func(struct i2c_adapter *adap)
 }
 
 static const struct i2c_algorithm stu300_algo = {
-	.master_xfer	= stu300_xfer,
-	.functionality	= stu300_func,
+	.master_xfer = stu300_xfer,
+	.master_xfer_atomic = stu300_xfer_todo,
+	.functionality = stu300_func,
 };
 
 static const struct i2c_adapter_quirks stu300_quirks = {
-- 
2.11.0
