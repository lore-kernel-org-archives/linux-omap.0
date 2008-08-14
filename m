From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: Git tree updated to v2.6.26-rc3, all header files moved
Date: Thu, 14 Aug 2008 17:12:10 +0300
Message-ID: <20080814141207.GD16231@frodo>
References: <20080814101329.GA9226@atomide.com> <20080814114710.GB16231@frodo> <20080814133540.GE9226@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mojUlQ0s9EVzWg2t"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34402 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457AbYHNOM0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Aug 2008 10:12:26 -0400
Content-Disposition: inline
In-Reply-To: <20080814133540.GE9226@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 14, 2008 at 04:35:41PM +0300, Tony Lindgren wrote:
> Thanks, pushing to l-o. Your twl patch also needs to be updated
> for the include path.

Here it is

thanks

-- 
balbi

--mojUlQ0s9EVzWg2t
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-input-keypad-General-fixes-to-omap-twl4030keypad.c.diff"

>From bc91d54477fef30befd382a538526b8a963aee8d Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Thu, 14 Aug 2008 17:06:00 +0300
Subject: [PATCH] input: keypad: General fixes to omap-twl4030keypad.c

The following patch fixes some problems in T2 keypad
driver.

Basically we're passing irq number via platform_data,
moving globals to a structure and fixing a problem
while iterating over the keymap.

It might be that we still have a few locking issues
that might be solved on a later version of this same
patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c         |    5 +-
 arch/arm/mach-omap2/board-3430sdp.c         |    5 +-
 arch/arm/plat-omap/include/mach/keypad.h    |    1 +
 drivers/input/keyboard/omap-twl4030keypad.c |  204 ++++++++++++++++-----------
 4 files changed, 129 insertions(+), 86 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index cb38fc2..64e76e8 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -176,9 +176,10 @@ static int sdp2430_keymap[] = {
 static struct omap_kp_platform_data sdp2430_kp_data = {
 	.rows		= 5,
 	.cols		= 6,
-	.keymap 	= sdp2430_keymap,
-	.keymapsize 	= ARRAY_SIZE(sdp2430_keymap),
+	.keymap		= sdp2430_keymap,
+	.keymapsize	= ARRAY_SIZE(sdp2430_keymap),
 	.rep		= 1,
+	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
 static struct platform_device sdp2430_kp_device = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 637f1c8..d27158e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -113,9 +113,10 @@ static int sdp3430_keymap[] = {
 static struct omap_kp_platform_data sdp3430_kp_data = {
 	.rows		= 5,
 	.cols		= 6,
-	.keymap 	= sdp3430_keymap,
-	.keymapsize 	= ARRAY_SIZE(sdp3430_keymap),
+	.keymap		= sdp3430_keymap,
+	.keymapsize	= ARRAY_SIZE(sdp3430_keymap),
 	.rep		= 1,
+	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
 static struct platform_device sdp3430_kp_device = {
diff --git a/arch/arm/plat-omap/include/mach/keypad.h b/arch/arm/plat-omap/include/mach/keypad.h
index 232923a..ba1c95c 100644
--- a/arch/arm/plat-omap/include/mach/keypad.h
+++ b/arch/arm/plat-omap/include/mach/keypad.h
@@ -14,6 +14,7 @@ struct omap_kp_platform_data {
 	int rows;
 	int cols;
 	int *keymap;
+	int irq;
 	unsigned int keymapsize;
 	unsigned int rep:1;
 	unsigned long delay;
diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 5dbb80f..3893d63 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -31,6 +31,7 @@
 #include <linux/types.h>
 #include <linux/input.h>
 #include <linux/kernel.h>
+#include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
@@ -47,52 +48,65 @@
 #define KEYNUM_MASK		0x00FFFFFF
 
 /* Global variables */
-static int *keymap;
-static u16 kp_state[MAX_ROWS];
-static int n_rows, n_cols;
 
-static struct device *dbg_dev;
-static struct input_dev *omap_twl4030kp;
+struct omap_keypad {
+	int		*keymap;
+	unsigned int	keymapsize;
+	u16		kp_state[MAX_ROWS];
+	int		n_rows;
+	int		n_cols;
+	int		irq;
 
-static int twl4030_kpread(u32 module, u8 *data, u32 reg, u8 num_bytes)
+	struct device	*dbg_dev;
+	struct input_dev *omap_twl4030kp;
+
+	/* sync read/write */
+	struct mutex	mutex;
+};
+
+static int twl4030_kpread(struct omap_keypad *kp,
+		u32 module, u8 *data, u32 reg, u8 num_bytes)
 {
 	int ret;
 
 	ret = twl4030_i2c_read(module, data, reg, num_bytes);
 	if (ret < 0) {
-		dev_warn(dbg_dev, "Couldn't read TWL4030: %X - ret %d[%x]\n",
+		dev_warn(kp->dbg_dev,
+			"Couldn't read TWL4030: %X - ret %d[%x]\n",
 			 reg, ret, ret);
 		return ret;
 	}
 	return ret;
 }
 
-static int twl4030_kpwrite_u8(u32 module, u8 data, u32 reg)
+static int twl4030_kpwrite_u8(struct omap_keypad *kp,
+		u32 module, u8 data, u32 reg)
 {
 	int ret;
 
 	ret = twl4030_i2c_write_u8(module, data, reg);
 	if (ret < 0) {
-		dev_warn(dbg_dev, "Could not write TWL4030: %X - ret %d[%x]\n",
+		dev_warn(kp->dbg_dev,
+			"Could not write TWL4030: %X - ret %d[%x]\n",
 			 reg, ret, ret);
 		return ret;
 	}
 	return ret;
 }
 
-static int omap_kp_find_key(int col, int row)
+static int omap_kp_find_key(struct omap_keypad *kp, int col, int row)
 {
 	int i, rc;
 
 	rc = KEY(col, row, 0);
-	for (i = 0; keymap[i] != 0; i++)
-		if ((keymap[i] & ROWCOL_MASK) == rc)
-			return keymap[i] & KEYNUM_MASK;
+	for (i = 0; i < kp->keymapsize; i++)
+		if ((kp->keymap[i] & ROWCOL_MASK) == rc)
+			return kp->keymap[i] & KEYNUM_MASK;
 
 	return -EINVAL;
 }
 
-static inline u16 omap_kp_col_xlate(u8 col)
+static inline u16 omap_kp_col_xlate(struct omap_keypad *kp, u8 col)
 {
 	/* If all bits in a row are active for all coloumns then
 	 * we have that row line connected to gnd. Mark this
@@ -100,30 +114,30 @@ static inline u16 omap_kp_col_xlate(u8 col)
 	 * one higher than the size of the matrix).
 	 */
 	if (col == 0xFF)
-		return (1 << n_cols);
+		return 1 << kp->n_cols;
 	else
-		return col & ((1 << n_cols) - 1);
+		return col & ((1 << kp->n_cols) - 1);
 }
 
-static int omap_kp_read_kp_matrix_state(u16 *state)
+static int omap_kp_read_kp_matrix_state(struct omap_keypad *kp, u16 *state)
 {
 	u8 new_state[MAX_ROWS];
 	int row;
-	int ret = twl4030_kpread(TWL4030_MODULE_KEYPAD,
-				 new_state, KEYP_FULL_CODE_7_0, n_rows);
+	int ret = twl4030_kpread(kp, TWL4030_MODULE_KEYPAD,
+				 new_state, KEYP_FULL_CODE_7_0, kp->n_rows);
 	if (ret >= 0) {
-		for (row = 0; row < n_rows; row++)
-			state[row] = omap_kp_col_xlate(new_state[row]);
+		for (row = 0; row < kp->n_rows; row++)
+			state[row] = omap_kp_col_xlate(kp, new_state[row]);
 	}
 	return ret;
 }
 
-static int omap_kp_is_in_ghost_state(u16 *key_state)
+static int omap_kp_is_in_ghost_state(struct omap_keypad *kp, u16 *key_state)
 {
 	int i;
 	u16 check = 0;
 
-	for (i = 0; i < n_rows; i++) {
+	for (i = 0; i < kp->n_rows; i++) {
 		u16 col = key_state[i];
 
 		if ((col & check) && hweight16(col) > 1)
@@ -134,7 +148,7 @@ static int omap_kp_is_in_ghost_state(u16 *key_state)
 	return 0;
 }
 
-static void twl4030_kp_scan(int release_all)
+static void twl4030_kp_scan(struct omap_keypad *kp, int release_all)
 {
 	u16 new_state[MAX_ROWS];
 	int col, row;
@@ -143,60 +157,66 @@ static void twl4030_kp_scan(int release_all)
 		memset(new_state, 0, sizeof(new_state));
 	else {
 		/* check for any changes */
-		int ret = omap_kp_read_kp_matrix_state(new_state);
+		int ret = omap_kp_read_kp_matrix_state(kp, new_state);
 		if (ret < 0)	/* panic ... */
 			return;
 
-		if (omap_kp_is_in_ghost_state(new_state))
+		if (omap_kp_is_in_ghost_state(kp, new_state))
 			return;
 	}
 
+	mutex_lock(&kp->mutex);
+
 	/* check for changes and print those */
-	for (row = 0; row < n_rows; row++) {
-		int changed = new_state[row] ^ kp_state[row];
+	for (row = 0; row < kp->n_rows; row++) {
+		int changed = new_state[row] ^ kp->kp_state[row];
 
 		if (!changed)
 			continue;
 
-		for (col = 0; col < n_cols; col++) {
+		for (col = 0; col < kp->n_cols + 1; col++) {
 			int key;
 
 			if (!(changed & (1 << col)))
 				continue;
 
-			dev_dbg(dbg_dev, "key [%d:%d] %s\n", row, col,
+			dev_dbg(kp->dbg_dev, "key [%d:%d] %s\n", row, col,
 				(new_state[row] & (1 << col)) ?
 				"press" : "release");
 
-			key = omap_kp_find_key(col, row);
+			key = omap_kp_find_key(kp, col, row);
 			if (key < 0)
-				dev_warn(dbg_dev, "Spurious key event %d-%d\n",
+				dev_warn(kp->dbg_dev,
+					"Spurious key event %d-%d\n",
 					 col, row);
 			else
-				input_report_key(omap_twl4030kp, key,
+				input_report_key(kp->omap_twl4030kp, key,
 						 new_state[row] & (1 << col));
 		}
-		kp_state[row] = new_state[row];
+		kp->kp_state[row] = new_state[row];
 	}
+
+	mutex_unlock(&kp->mutex);
 }
 
 /*
  * Keypad interrupt handler
  */
-static irqreturn_t do_kp_irq(int irq, void *dev_id)
+static irqreturn_t do_kp_irq(int irq, void *_kp)
 {
+	struct omap_keypad *kp = _kp;
 	u8 reg;
 	int ret;
 
 	/* Read & Clear TWL4030 pending interrupt */
-	ret = twl4030_kpread(TWL4030_MODULE_KEYPAD, &reg, KEYP_ISR1, 1);
+	ret = twl4030_kpread(kp, TWL4030_MODULE_KEYPAD, &reg, KEYP_ISR1, 1);
 
 	/* Release all keys if I2C has gone bad or
 	 * the KEYP has gone to idle state */
 	if ((ret >= 0) && (reg & KEYP_IMR1_KP))
-		twl4030_kp_scan(0);
+		twl4030_kp_scan(kp, 0);
 	else
-		twl4030_kp_scan(1);
+		twl4030_kp_scan(kp, 1);
 
 	return IRQ_HANDLED;
 }
@@ -210,92 +230,108 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 	u8 reg;
 	int i;
 	int ret = 0;
+	struct omap_keypad *kp;
 	struct omap_kp_platform_data *pdata = pdev->dev.platform_data;
 
-	/* Get the debug Device */
-	dbg_dev = &(pdev->dev);
+	kp = kzalloc(sizeof(*kp), GFP_KERNEL);
+	if (!kp)
+		return -ENOMEM;
 
 	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
-		dev_err(dbg_dev, "No rows, cols or keymap from pdata\n");
+		dev_err(kp->dbg_dev, "No rows, cols or keymap from pdata\n");
+		kfree(kp);
 		return -EINVAL;
 	}
 
-	omap_twl4030kp = input_allocate_device();
-	if (omap_twl4030kp == NULL)
+	dev_set_drvdata(&pdev->dev, kp);
+
+	/* Get the debug Device */
+	kp->dbg_dev = &pdev->dev;
+
+	kp->omap_twl4030kp = input_allocate_device();
+	if (!kp->omap_twl4030kp) {
+		kfree(kp);
 		return -ENOMEM;
+	}
 
-	keymap = pdata->keymap;
-	n_rows = pdata->rows;
-	n_cols = pdata->cols;
+	mutex_init(&kp->mutex);
+
+	kp->keymap = pdata->keymap;
+	kp->keymapsize = pdata->keymapsize;
+	kp->n_rows = pdata->rows;
+	kp->n_cols = pdata->cols;
+	kp->irq = pdata->irq;
 
 	/* setup input device */
-	set_bit(EV_KEY, omap_twl4030kp->evbit);
+	set_bit(EV_KEY, kp->omap_twl4030kp->evbit);
 
 	/* Enable auto repeat feature of Linux input subsystem */
 	if (pdata->rep)
-		set_bit(EV_REP, omap_twl4030kp->evbit);
+		set_bit(EV_REP, kp->omap_twl4030kp->evbit);
 
-	for (i = 0; keymap[i] != 0; i++)
-		set_bit(keymap[i] & KEYNUM_MASK, omap_twl4030kp->keybit);
+	for (i = 0; i < kp->keymapsize; i++)
+		set_bit(kp->keymap[i] & KEYNUM_MASK,
+				kp->omap_twl4030kp->keybit);
 
-	omap_twl4030kp->name		= "omap_twl4030keypad";
-	omap_twl4030kp->phys		= "omap_twl4030keypad/input0";
-	omap_twl4030kp->dev.parent	= &pdev->dev;
+	kp->omap_twl4030kp->name	= "omap_twl4030keypad";
+	kp->omap_twl4030kp->phys	= "omap_twl4030keypad/input0";
+	kp->omap_twl4030kp->dev.parent	= &pdev->dev;
 
-	omap_twl4030kp->id.bustype	= BUS_HOST;
-	omap_twl4030kp->id.vendor	= 0x0001;
-	omap_twl4030kp->id.product	= 0x0001;
-	omap_twl4030kp->id.version	= 0x0003;
+	kp->omap_twl4030kp->id.bustype	= BUS_HOST;
+	kp->omap_twl4030kp->id.vendor	= 0x0001;
+	kp->omap_twl4030kp->id.product	= 0x0001;
+	kp->omap_twl4030kp->id.version	= 0x0003;
 
-	omap_twl4030kp->keycode		= keymap;
-	omap_twl4030kp->keycodesize	= sizeof(unsigned int);
-	omap_twl4030kp->keycodemax	= pdata->keymapsize;
+	kp->omap_twl4030kp->keycode	= kp->keymap;
+	kp->omap_twl4030kp->keycodesize	= sizeof(unsigned int);
+	kp->omap_twl4030kp->keycodemax	= kp->keymapsize;
 
-	ret = input_register_device(omap_twl4030kp);
+	ret = input_register_device(kp->omap_twl4030kp);
 	if (ret < 0) {
-		dev_err(dbg_dev, "Unable to register twl4030 keypad device\n");
+		dev_err(kp->dbg_dev,
+			"Unable to register twl4030 keypad device\n");
 		goto err2;
 	}
 
 	/* Disable auto-repeat */
 	reg = KEYP_CTRL_NOAUTORPT;
-	ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, KEYP_CTRL);
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_CTRL);
 	if (ret < 0)
 		goto err3;
 
 	/* Enable TO rising and KP rising and falling edge detection */
 	reg = KEYP_EDR_KP_BOTH | KEYP_EDR_TO_RISING;
-	ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, KEYP_EDR);
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_EDR);
 	if (ret < 0)
 		goto err3;
 
 	/* Set PTV prescaler Field */
 	reg = (PTV_PRESCALER << KEYP_LK_PTV_PTV_SHIFT);
-	ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, reg, KEYP_LK_PTV);
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, reg, KEYP_LK_PTV);
 	if (ret < 0)
 		goto err3;
 
 	/* Set key debounce time to 20 ms */
 	i = KEYP_PERIOD_US(20000, PTV_PRESCALER);
-	ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, i, KEYP_DEB);
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, i, KEYP_DEB);
 	if (ret < 0)
 		goto err3;
 
 	/* Set timeout period to 100 ms */
 	i = KEYP_PERIOD_US(200000, PTV_PRESCALER);
-	ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD,
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
 				 (i & 0xFF), KEYP_TIMEOUT_L);
 	if (ret < 0)
 		goto err3;
 
-	ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD,
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
 				 (i >> 8), KEYP_TIMEOUT_H);
 	if (ret < 0)
 		goto err3;
 
 	/* Enable Clear-on-Read */
 	reg = KEYP_SIH_CTRL_COR | KEYP_SIH_CTRL_PEND_DIS;
-	ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD,
+	ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
 				 reg, KEYP_SIH_CTRL);
 	if (ret < 0)
 		goto err3;
@@ -304,50 +340,54 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 	 * This ISR will always execute in kernel thread context because of
 	 * the need to access the TWL4030 over the I2C bus.
 	 */
-	ret = request_irq(TWL4030_MODIRQ_KEYPAD, do_kp_irq,
-		IRQF_DISABLED, "TWL4030 Keypad", omap_twl4030kp);
+	ret = request_irq(kp->irq, do_kp_irq, IRQF_DISABLED,
+			"TWL4030 Keypad", kp);
 	if (ret < 0) {
-		dev_info(dbg_dev, "request_irq failed for irq no=%d\n",
-			TWL4030_MODIRQ_KEYPAD);
+		dev_info(kp->dbg_dev, "request_irq failed for irq no=%d\n",
+			kp->irq);
 		goto err3;
 	} else {
 		/* Enable KP and TO interrupts now. */
 		reg = ~(KEYP_IMR1_KP | KEYP_IMR1_TO);
-		ret = twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD,
+		ret = twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD,
 					 reg, KEYP_IMR1);
 		if (ret < 0)
 			goto err5;
 	}
 
-	ret = omap_kp_read_kp_matrix_state(kp_state);
+	ret = omap_kp_read_kp_matrix_state(kp, kp->kp_state);
 	if (ret < 0)
 		goto err4;
 
 	return ret;
 err5:
 	/* mask all events - we don't care about the result */
-	(void) twl4030_kpwrite_u8(TWL4030_MODULE_KEYPAD, 0xff, KEYP_IMR1);
+	(void) twl4030_kpwrite_u8(kp, TWL4030_MODULE_KEYPAD, 0xff, KEYP_IMR1);
 err4:
-	free_irq(TWL4030_MODIRQ_KEYPAD, NULL);
+	free_irq(kp->irq, NULL);
 err3:
-	input_unregister_device(omap_twl4030kp);
+	input_unregister_device(kp->omap_twl4030kp);
 err2:
-	input_free_device(omap_twl4030kp);
+	input_free_device(kp->omap_twl4030kp);
+
 	return -ENODEV;
 }
 
 static int omap_kp_remove(struct platform_device *pdev)
 {
-	free_irq(TWL4030_MODIRQ_KEYPAD, NULL);
+	struct omap_keypad *kp = dev_get_drvdata(&pdev->dev);
+
+	free_irq(kp->irq, kp);
+	input_unregister_device(kp->omap_twl4030kp);
+	kfree(kp);
 
-	input_unregister_device(omap_twl4030kp);
 	return 0;
 }
 
 
 static struct platform_driver omap_kp_driver = {
 	.probe		= omap_kp_probe,
-	.remove		= omap_kp_remove,
+	.remove		= __devexit_p(omap_kp_remove),
 	.driver		= {
 		.name	= "omap_twl4030keypad",
 		.owner	= THIS_MODULE,
-- 
1.6.0.rc3.6.ga0653


--mojUlQ0s9EVzWg2t--
