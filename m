From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 10/10] Input: ams_delta_serio: Get FIQ buffer from platform_data
Date: Sat,  9 Jun 2018 16:02:24 +0200
Message-ID: <20180609140224.32606-10-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Instead of exporting the FIQ buffer symbol to be used in
ams-delta-serio driver, pass it to the driver as platform_data.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq.c         |  6 +++---
 arch/arm/mach-omap1/board-ams-delta.c       |  8 ++++++++
 drivers/input/serio/ams_delta_serio.c       | 20 +++++++++++++-------
 include/linux/platform_data/ams-delta-fiq.h |  4 ----
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index e9d350117240..983638994bd4 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -40,8 +40,7 @@ static struct fiq_handler fh = {
  * keystrokes received from the qwerty keyboard.  See
  * <linux/platform_data/ams-delta-fiq.h> for details of offsets.
  */
-unsigned int fiq_buffer[1024];
-EXPORT_SYMBOL(fiq_buffer);
+static unsigned int fiq_buffer[1024];
 
 static struct irq_chip *irq_chip;
 static struct irq_data *irq_data[16];
@@ -203,9 +202,10 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip,
 	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
 	omap_writel(val, OMAP_IH1_BASE + offset);
 
-	/* Initialize serio device IRQ resource */
+	/* Initialize serio device IRQ resource and platform_data */
 	serio->resource[0].start = gpiod_to_irq(clk);
 	serio->resource[0].end = serio->resource[0].start;
+	serio->dev.platform_data = fiq_buffer;
 
 	return;
 
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 84177ba3e39a..772892487827 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -520,6 +520,14 @@ static struct resource ams_delta_serio_resources[] = {
 static struct platform_device ams_delta_serio_device = {
 	.name		= "ams-delta-serio",
 	.id		= PLATFORM_DEVID_NONE,
+	.dev		= {
+		/*
+		 * Initialize .platform_data explicitly with NULL to
+		 * indicate it is going to be used.  It will be replaced
+		 * with FIQ buffer address as soon as FIQ is initialized.
+		 */
+		.platform_data = NULL,
+	},
 	.num_resources	= ARRAY_SIZE(ams_delta_serio_resources),
 	.resource	= ams_delta_serio_resources,
 };
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 03640b171516..ee38c5140f43 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
 struct ams_delta_serio {
 	struct serio *serio;
 	struct regulator *vcc;
+	unsigned int *fiq_buffer;
 };
 
 static int check_data(struct serio *serio, int data)
@@ -66,22 +67,23 @@ static int check_data(struct serio *serio, int data)
 static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 {
 	struct ams_delta_serio *priv = dev_id;
-	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
+	int *circ_buff = &priv->fiq_buffer[FIQ_CIRC_BUFF];
 	int data, dfl;
 	u8 scancode;
 
-	fiq_buffer[FIQ_IRQ_PEND] = 0;
+	priv->fiq_buffer[FIQ_IRQ_PEND] = 0;
 
 	/*
 	 * Read data from the circular buffer, check it
 	 * and then pass it on the serio
 	 */
-	while (fiq_buffer[FIQ_KEYS_CNT] > 0) {
+	while (priv->fiq_buffer[FIQ_KEYS_CNT] > 0) {
 
-		data = circ_buff[fiq_buffer[FIQ_HEAD_OFFSET]++];
-		fiq_buffer[FIQ_KEYS_CNT]--;
-		if (fiq_buffer[FIQ_HEAD_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
-			fiq_buffer[FIQ_HEAD_OFFSET] = 0;
+		data = circ_buff[priv->fiq_buffer[FIQ_HEAD_OFFSET]++];
+		priv->fiq_buffer[FIQ_KEYS_CNT]--;
+		if (priv->fiq_buffer[FIQ_HEAD_OFFSET] ==
+		    priv->fiq_buffer[FIQ_BUF_LEN])
+			priv->fiq_buffer[FIQ_HEAD_OFFSET] = 0;
 
 		dfl = check_data(priv->serio, data);
 		scancode = (u8) (data >> 1) & 0xFF;
@@ -116,6 +118,10 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->fiq_buffer = pdev->dev.platform_data;
+	if (!priv->fiq_buffer)
+		return -EINVAL;
+
 	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
 	if (IS_ERR(priv->vcc)) {
 		err = PTR_ERR(priv->vcc);
diff --git a/include/linux/platform_data/ams-delta-fiq.h b/include/linux/platform_data/ams-delta-fiq.h
index dc0f835ea918..cf4589ccb720 100644
--- a/include/linux/platform_data/ams-delta-fiq.h
+++ b/include/linux/platform_data/ams-delta-fiq.h
@@ -55,8 +55,4 @@
 
 #define FIQ_CIRC_BUFF		30      /*Start of circular buffer */
 
-#ifndef __ASSEMBLER__
-extern unsigned int fiq_buffer[];
-#endif
-
 #endif
-- 
2.16.1
