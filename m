From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/6] omap: i2c: Add i2c support on omap4 platform
Date: Tue, 11 May 2010 11:35:04 -0700
Message-ID: <20100511183504.15596.40669.stgit@baageli.muru.com>
References: <20100511182854.15596.56293.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100511182854.15596.56293.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>

This patch is rebased version of earlier post to add I2C
driver support to OMAP4 platform. On OMAP4, all
I2C register address offsets are changed from OMAP1/2/3 I2C.
In order to not have #ifdef's at various places in code,
as well as to support multi-OMAP build, an array is created
to hold the register addresses with it's offset.

This patch was submitted, reviewed and acked on mailing list
already. For more details refer below link
http://www.mail-archive.com/linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg02281.html

This updated verion has a depedancy on "Add support for 16-bit registers"
posted on linux-omap. Below is the patch-works link for the same

http://patchwork.kernel.org/patch/72295/

Signed-off-by: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Acked-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Reviewed-by: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |  146 ++++++++++++++++++++++++++++++++---------
 1 files changed, 114 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 389ac60..46111ff 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -45,29 +45,37 @@
 /* I2C controller revisions present on specific hardware */
 #define OMAP_I2C_REV_ON_2430		0x36
 #define OMAP_I2C_REV_ON_3430		0x3C
+#define OMAP_I2C_REV_ON_4430		0x40
 
 /* timeout waiting for the controller to respond */
 #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
 
-#define OMAP_I2C_REV_REG		0x00
-#define OMAP_I2C_IE_REG			0x01
-#define OMAP_I2C_STAT_REG		0x02
-#define OMAP_I2C_IV_REG			0x03
 /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
-#define OMAP_I2C_WE_REG			0x03
-#define OMAP_I2C_SYSS_REG		0x04
-#define OMAP_I2C_BUF_REG		0x05
-#define OMAP_I2C_CNT_REG		0x06
-#define OMAP_I2C_DATA_REG		0x07
-#define OMAP_I2C_SYSC_REG		0x08
-#define OMAP_I2C_CON_REG		0x09
-#define OMAP_I2C_OA_REG			0x0a
-#define OMAP_I2C_SA_REG			0x0b
-#define OMAP_I2C_PSC_REG		0x0c
-#define OMAP_I2C_SCLL_REG		0x0d
-#define OMAP_I2C_SCLH_REG		0x0e
-#define OMAP_I2C_SYSTEST_REG		0x0f
-#define OMAP_I2C_BUFSTAT_REG		0x10
+enum {
+	OMAP_I2C_REV_REG = 0,
+	OMAP_I2C_IE_REG,
+	OMAP_I2C_STAT_REG,
+	OMAP_I2C_IV_REG,
+	OMAP_I2C_WE_REG,
+	OMAP_I2C_SYSS_REG,
+	OMAP_I2C_BUF_REG,
+	OMAP_I2C_CNT_REG,
+	OMAP_I2C_DATA_REG,
+	OMAP_I2C_SYSC_REG,
+	OMAP_I2C_CON_REG,
+	OMAP_I2C_OA_REG,
+	OMAP_I2C_SA_REG,
+	OMAP_I2C_PSC_REG,
+	OMAP_I2C_SCLL_REG,
+	OMAP_I2C_SCLH_REG,
+	OMAP_I2C_SYSTEST_REG,
+	OMAP_I2C_BUFSTAT_REG,
+	OMAP_I2C_REVNB_LO,
+	OMAP_I2C_REVNB_HI,
+	OMAP_I2C_IRQSTATUS_RAW,
+	OMAP_I2C_IRQENABLE_SET,
+	OMAP_I2C_IRQENABLE_CLR,
+};
 
 /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
 #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
@@ -170,6 +178,7 @@ struct omap_i2c_dev {
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
+	u8			*regs;
 	size_t			buf_len;
 	struct i2c_adapter	adapter;
 	u8			fifo_size;	/* use as flag and value
@@ -188,15 +197,64 @@ struct omap_i2c_dev {
 	u16			westate;
 };
 
+const static u8 reg_map[] = {
+	[OMAP_I2C_REV_REG] = 0x00,
+	[OMAP_I2C_IE_REG] = 0x01,
+	[OMAP_I2C_STAT_REG] = 0x02,
+	[OMAP_I2C_IV_REG] = 0x03,
+	[OMAP_I2C_WE_REG] = 0x03,
+	[OMAP_I2C_SYSS_REG] = 0x04,
+	[OMAP_I2C_BUF_REG] = 0x05,
+	[OMAP_I2C_CNT_REG] = 0x06,
+	[OMAP_I2C_DATA_REG] = 0x07,
+	[OMAP_I2C_SYSC_REG] = 0x08,
+	[OMAP_I2C_CON_REG] = 0x09,
+	[OMAP_I2C_OA_REG] = 0x0a,
+	[OMAP_I2C_SA_REG] = 0x0b,
+	[OMAP_I2C_PSC_REG] = 0x0c,
+	[OMAP_I2C_SCLL_REG] = 0x0d,
+	[OMAP_I2C_SCLH_REG] = 0x0e,
+	[OMAP_I2C_SYSTEST_REG] = 0x0f,
+	[OMAP_I2C_BUFSTAT_REG] = 0x10,
+};
+
+const static u8 omap4_reg_map[] = {
+	[OMAP_I2C_REV_REG] = 0x04,
+	[OMAP_I2C_IE_REG] = 0x2c,
+	[OMAP_I2C_STAT_REG] = 0x28,
+	[OMAP_I2C_IV_REG] = 0x34,
+	[OMAP_I2C_WE_REG] = 0x34,
+	[OMAP_I2C_SYSS_REG] = 0x90,
+	[OMAP_I2C_BUF_REG] = 0x94,
+	[OMAP_I2C_CNT_REG] = 0x98,
+	[OMAP_I2C_DATA_REG] = 0x9c,
+	[OMAP_I2C_SYSC_REG] = 0x20,
+	[OMAP_I2C_CON_REG] = 0xa4,
+	[OMAP_I2C_OA_REG] = 0xa8,
+	[OMAP_I2C_SA_REG] = 0xac,
+	[OMAP_I2C_PSC_REG] = 0xb0,
+	[OMAP_I2C_SCLL_REG] = 0xb4,
+	[OMAP_I2C_SCLH_REG] = 0xb8,
+	[OMAP_I2C_SYSTEST_REG] = 0xbC,
+	[OMAP_I2C_BUFSTAT_REG] = 0xc0,
+	[OMAP_I2C_REVNB_LO] = 0x00,
+	[OMAP_I2C_REVNB_HI] = 0x04,
+	[OMAP_I2C_IRQSTATUS_RAW] = 0x24,
+	[OMAP_I2C_IRQENABLE_SET] = 0x2c,
+	[OMAP_I2C_IRQENABLE_CLR] = 0x30,
+};
+
 static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 				      int reg, u16 val)
 {
-	__raw_writew(val, i2c_dev->base + (reg << i2c_dev->reg_shift));
+	__raw_writew(val, i2c_dev->base +
+			(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base + (reg << i2c_dev->reg_shift));
+	return __raw_readw(i2c_dev->base +
+				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
 static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
@@ -265,7 +323,11 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	WARN_ON(dev->idle);
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+	if (dev->rev >= OMAP_I2C_REV_ON_4430)
+		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
+	else
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+
 	if (dev->rev < OMAP_I2C_REV_2) {
 		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
 	} else {
@@ -330,7 +392,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			 * REVISIT: Some wkup sources might not be needed.
 			 */
 			dev->westate = OMAP_I2C_WE_ALL;
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+			if (dev->rev < OMAP_I2C_REV_ON_4430)
+				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
+								dev->westate);
 		}
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
@@ -357,7 +421,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 			psc = fclk_rate / 12000000;
 	}
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (!(cpu_class_is_omap1() || cpu_is_omap2420())) {
 
 		/*
 		 * HSI2C controller internal clk rate should be 19.2 Mhz for
@@ -747,9 +811,12 @@ complete:
 				if (dev->buf_len) {
 					*dev->buf++ = w;
 					dev->buf_len--;
-					/* Data reg from 2430 is 8 bit wide */
-					if (!cpu_is_omap2430() &&
-							!cpu_is_omap34xx()) {
+					/*
+					 * Data reg in 2430, omap3 and
+					 * omap4 is 8 bit wide
+					 */
+					if (cpu_class_is_omap1() ||
+							cpu_is_omap2420()) {
 						if (dev->buf_len) {
 							*dev->buf++ = w >> 8;
 							dev->buf_len--;
@@ -787,9 +854,12 @@ complete:
 				if (dev->buf_len) {
 					w = *dev->buf++;
 					dev->buf_len--;
-					/* Data reg from  2430 is 8 bit wide */
-					if (!cpu_is_omap2430() &&
-							!cpu_is_omap34xx()) {
+					/*
+					 * Data reg in 2430, omap3 and
+					 * omap4 is 8 bit wide
+					 */
+					if (cpu_class_is_omap1() ||
+							cpu_is_omap2420()) {
 						if (dev->buf_len) {
 							w |= *dev->buf++ << 8;
 							dev->buf_len--;
@@ -905,17 +975,24 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	if (cpu_is_omap7xx())
 		dev->reg_shift = 1;
+	else if (cpu_is_omap44xx())
+		dev->reg_shift = 0;
 	else
 		dev->reg_shift = 2;
 
 	if ((r = omap_i2c_get_clocks(dev)) != 0)
 		goto err_iounmap;
 
+	if (cpu_is_omap44xx())
+		dev->regs = (u8 *) omap4_reg_map;
+	else
+		dev->regs = (u8 *) reg_map;
+
 	omap_i2c_unidle(dev);
 
 	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
 
-	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+	if (!(cpu_class_is_omap1() || cpu_is_omap2420())) {
 		u16 s;
 
 		/* Set up the fifo size - Get total size */
@@ -927,8 +1004,13 @@ omap_i2c_probe(struct platform_device *pdev)
 		 * size. This is to ensure that we can handle the status on int
 		 * call back latencies.
 		 */
-		dev->fifo_size = (dev->fifo_size / 2);
-		dev->b_hw = 1; /* Enable hardware fixes */
+		if (dev->rev >= OMAP_I2C_REV_ON_4430) {
+			dev->fifo_size = 0;
+			dev->b_hw = 0; /* Disable hardware fixes */
+		} else {
+			dev->fifo_size = (dev->fifo_size / 2);
+			dev->b_hw = 1; /* Enable hardware fixes */
+		}
 	}
 
 	/* reset ASAP, clearing any IRQs */
