From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 09/13] ARM: OMAP2+: gpmc: waitpin helper
Date: Fri, 22 Jun 2012 18:27:23 +0530
Message-ID: <f7cbee399ece42e64f9ad2205171c3c67c3f1a9e.1340367480.git.afzal@ti.com>
References: <cover.1340367480.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37182 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954Ab2FVNMn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:12:43 -0400
In-Reply-To: <cover.1340367480.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Helper for configuring waitpin. There are two parts to it;
configuring at CS level and the other at device level.
A device embedding multiple CS has been provided the
capability to use same waitpin (different waitpins has not
been supported as presently there are no GPMC peripherals
doing so)

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |  123 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    9 +++
 2 files changed, 132 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 9e3960e..15688da 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -75,6 +75,8 @@
 #define	GPMC_CONFIG6_CYCLE2CYCLEDIFFCSEN	BIT(6)
 #define	GPMC_CONFIG6_CYCLE2CYCLESAMECSEN	BIT(7)
 
+#define	GPMC_CONFIG_WAITPIN_POLARITY_SHIFT	0x8
+
 #define GPMC_CS0_OFFSET		0x60
 #define GPMC_CS_SIZE		0x30
 
@@ -99,6 +101,14 @@
  */
 #define	GPMC_NR_IRQ		2
 
+enum {
+	GPMC_WAITPIN_IDX0,
+	GPMC_WAITPIN_IDX1,
+	GPMC_WAITPIN_IDX2,
+	GPMC_WAITPIN_IDX3,
+	GPMC_MAX_NR_WAITPIN
+};
+
 struct gpmc_client_irq	{
 	unsigned		irq;
 	u32			bitmask;
@@ -146,6 +156,9 @@ struct gpmc_peripheral {
 	struct platform_device	*pdev;
 };
 
+static unsigned gpmc_waitpin_map;
+static unsigned gpmc_waitpin_nr = GPMC_MAX_NR_WAITPIN;
+
 static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
 static struct irq_chip gpmc_irq_chip;
 static unsigned gpmc_irq_start;
@@ -1160,6 +1173,62 @@ static void gpmc_print_cs_timings(int cs)
 			gpmc_get_one_timing(cs, GPMC_CS_CONFIG6, 7, 7));
 }
 
+static int gpmc_setup_cs_waitpin(struct gpmc_peripheral *g_per, unsigned cs,
+							unsigned conf)
+{
+	unsigned idx;
+	bool polarity = 0;
+	u32 l = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+	switch (conf & GPMC_WAITPIN_MASK) {
+	case GPMC_WAITPIN_0:
+		idx =  GPMC_WAITPIN_IDX0;
+		break;
+	case GPMC_WAITPIN_1:
+		idx =  GPMC_WAITPIN_IDX1;
+		break;
+	case GPMC_WAITPIN_2:
+		idx =  GPMC_WAITPIN_IDX2;
+		break;
+	case GPMC_WAITPIN_3:
+		idx =  GPMC_WAITPIN_IDX3;
+		break;
+	/* no waitpin */
+	case 0:
+		return 0;
+		break;
+	default:
+		dev_err(gpmc_dev, "multiple waitpins selected on CS:%u\n", cs);
+		return -EINVAL;
+		break;
+	}
+
+	polarity = !!(conf & GPMC_WAITPIN_ACTIVE_HIGH);
+
+	if (g_per->have_waitpin) {
+		if (g_per->waitpin != idx ||
+				g_per->waitpin_high != polarity) {
+			dev_err(gpmc_dev, "error: conflict: waitpin %u with polarity %d on device %s.%d\n",
+				g_per->waitpin, g_per->waitpin_high,
+				g_per->name, g_per->id);
+			return -EBUSY;
+		}
+	} else {
+		g_per->have_waitpin = true;
+		g_per->waitpin = idx;
+		g_per->waitpin_high = polarity;
+	}
+
+	l |= conf & GPMC_CONFIG1_WAIT_WRITE_MON;
+	l |= conf & GPMC_CONFIG1_WAIT_READ_MON;
+	l &= ~GPMC_CONFIG1_WAIT_PIN_SEL_MASK;
+	l |= GPMC_CONFIG1_WAIT_PIN_SEL(idx);
+
+	gpmc_cs_write_reg(cs, GPMC_CS_CONFIG1, l);
+
+	return 0;
+}
+
 static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
 						struct resource *res)
 {
@@ -1183,6 +1252,55 @@ static __devinit int gpmc_setup_cs_irq(struct gpmc_cs_data *cs,
 	return n;
 }
 
+static inline int gpmc_waitpin_is_reserved(unsigned waitpin)
+{
+	return gpmc_waitpin_map & (0x1 << waitpin);
+}
+
+static inline void gpmc_reserve_waitpin(unsigned waitpin)
+{
+	gpmc_waitpin_map &= ~(0x1 << waitpin);
+	gpmc_waitpin_map |= (0x1 << waitpin);
+}
+
+static int gpmc_waitpin_request(unsigned waitpin)
+{
+	if (!(waitpin < gpmc_waitpin_nr))
+		return -ENODEV;
+
+	if (gpmc_waitpin_is_reserved(waitpin))
+		return -EBUSY;
+	else
+		gpmc_reserve_waitpin(waitpin);
+
+	return 0;
+}
+
+static int gpmc_setup_waitpin(struct gpmc_peripheral *g_per)
+{
+	int ret;
+	u32 l, shift;
+
+	if (!g_per->have_waitpin)
+		return 0;
+
+	ret = gpmc_waitpin_request(g_per->waitpin);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(gpmc_dev, "waitpin %u reserved\n", g_per->waitpin);
+		return ret;
+	}
+
+	l = gpmc_read_reg(GPMC_CONFIG);
+	shift = g_per->waitpin + GPMC_CONFIG_WAITPIN_POLARITY_SHIFT;
+	if (g_per->waitpin_high)
+		l |= 1 << shift;
+	else
+		l &= ~(1 << shift);
+	gpmc_write_reg(GPMC_CONFIG, l);
+
+	return 0;
+}
+
 static __devinit int gpmc_probe(struct platform_device *pdev)
 {
 	u32 l;
@@ -1221,11 +1339,16 @@ static __devinit int gpmc_probe(struct platform_device *pdev)
 	if (IS_ERR_VALUE(gpmc_setup_irq()))
 		dev_warn(gpmc_dev, "gpmc_setup_irq failed\n");
 
+	/* waitpin default 4, update if platform passed available waitpin no. */
+	if (gp->waitpin_nr)
+		gpmc_waitpin_nr = gp->waitpin_nr;
+
 	return 0;
 }
 
 static __exit int gpmc_remove(struct platform_device *pdev)
 {
+	gpmc_waitpin_nr = GPMC_MAX_NR_WAITPIN;
 	gpmc_free_irq();
 	gpmc_mem_exit();
 	gpmc_dev = NULL;
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 7187445..1185490 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -64,6 +64,7 @@
 #define GPMC_CONFIG1_WAIT_WRITE_MON     (1 << 21)
 #define GPMC_CONFIG1_WAIT_MON_IIME(val) ((val & 3) << 18)
 #define GPMC_CONFIG1_WAIT_PIN_SEL(val)  ((val & 3) << 16)
+#define	GPMC_CONFIG1_WAIT_PIN_SEL_MASK	GPMC_CONFIG1_WAIT_PIN_SEL(3)
 #define GPMC_CONFIG1_DEVICESIZE(val)    ((val & 3) << 12)
 #define	GPMC_CONFIG1_DEVICESIZE_8	GPMC_CONFIG1_DEVICESIZE(0)
 #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
@@ -78,6 +79,14 @@
 #define GPMC_CONFIG1_FCLK_DIV4          (GPMC_CONFIG1_FCLK_DIV(3))
 #define GPMC_CONFIG7_CSVALID		(1 << 6)
 
+#define	GPMC_WAITPIN_ACTIVE_HIGH	(1 << 4)
+#define	GPMC_WAITPIN_ACTIVE_LOW		(0 << 4)
+#define	GPMC_WAITPIN_0			(1 << 0)
+#define	GPMC_WAITPIN_1			(1 << 1)
+#define	GPMC_WAITPIN_2			(1 << 2)
+#define	GPMC_WAITPIN_3			(1 << 3)
+#define	GPMC_WAITPIN_MASK		(GPMC_WAITPIN_0 | GPMC_WAITPIN_1 | \
+					GPMC_WAITPIN_2 | GPMC_WAITPIN_3)
 #define GPMC_DEVICETYPE_NOR		0
 #define GPMC_DEVICETYPE_NAND		2
 #define GPMC_CONFIG_WRITEPROTECT	0x00000010
-- 
1.7.10.2

