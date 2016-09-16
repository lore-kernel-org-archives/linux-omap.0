From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: Allow longer flag masks for read and write" to the regmap tree
Date: Fri, 16 Sep 2016 18:39:52 +0100
Message-ID: <E1bkx7A-00040t-Lp@debutante>
References: <20160915205611.14046-2-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915205611.14046-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The patch

   regmap: Allow longer flag masks for read and write

has been applied to the regmap tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f50e38c9966076465bc8d9dd0bc582c268a0031e Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 15 Sep 2016 13:56:10 -0700
Subject: [PATCH] regmap: Allow longer flag masks for read and write

We currently only support masking the top bit for read and write
flags. Let's make the mask unsigned long and mask the bytes based
on the configured register length to make things more generic.

This allows using regmap for more exotic combinations like SPI
devices that need little endian addressing.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/internal.h |  4 ++--
 drivers/base/regmap/regmap.c   | 32 +++++++++++++++++++-------------
 include/linux/regmap.h         |  8 ++++----
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index a0380338946a..6636f03ac2da 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -105,8 +105,8 @@ struct regmap {
 
 	bool defer_caching;
 
-	u8 read_flag_mask;
-	u8 write_flag_mask;
+	unsigned long read_flag_mask;
+	unsigned long write_flag_mask;
 
 	/* number of bits to (left) shift the reg value when formatting*/
 	int reg_shift;
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 51fa7d66a393..a6a5236b6c8d 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1296,12 +1296,26 @@ static int _regmap_select_page(struct regmap *map, unsigned int *reg,
 	return 0;
 }
 
+static void regmap_set_work_buf_flag_mask(struct regmap *map, int max_bytes,
+					  unsigned long mask)
+{
+	u8 *buf;
+	int i;
+
+	if (!mask || !map->work_buf)
+		return;
+
+	buf = map->work_buf;
+
+	for (i = 0; i < max_bytes; i++)
+		buf[i] |= (mask >> (8 * i)) & 0xff;
+}
+
 int _regmap_raw_write(struct regmap *map, unsigned int reg,
 		      const void *val, size_t val_len)
 {
 	struct regmap_range_node *range;
 	unsigned long flags;
-	u8 *u8 = map->work_buf;
 	void *work_val = map->work_buf + map->format.reg_bytes +
 		map->format.pad_bytes;
 	void *buf;
@@ -1370,8 +1384,8 @@ int _regmap_raw_write(struct regmap *map, unsigned int reg,
 	}
 
 	map->format.format_reg(map->work_buf, reg, map->reg_shift);
-
-	u8[0] |= map->write_flag_mask;
+	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
+				      map->write_flag_mask);
 
 	/*
 	 * Essentially all I/O mechanisms will be faster with a single
@@ -2245,7 +2259,6 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 			    unsigned int val_len)
 {
 	struct regmap_range_node *range;
-	u8 *u8 = map->work_buf;
 	int ret;
 
 	WARN_ON(!map->bus);
@@ -2262,15 +2275,8 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 	}
 
 	map->format.format_reg(map->work_buf, reg, map->reg_shift);
-
-	/*
-	 * Some buses or devices flag reads by setting the high bits in the
-	 * register address; since it's always the high bits for all
-	 * current formats we can do this here rather than in
-	 * formatting.  This may break if we get interesting formats.
-	 */
-	u8[0] |= map->read_flag_mask;
-
+	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
+				      map->read_flag_mask);
 	trace_regmap_hw_read_start(map, reg, val_len / map->format.val_bytes);
 
 	ret = map->bus->read(map->bus_context, map->work_buf,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 2c12cc5af744..9adc7b21903d 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -241,9 +241,9 @@ typedef void (*regmap_unlock)(void *);
  *                register cache support).
  * @num_reg_defaults: Number of elements in reg_defaults.
  *
- * @read_flag_mask: Mask to be set in the top byte of the register when doing
+ * @read_flag_mask: Mask to be set in the top bytes of the register when doing
  *                  a read.
- * @write_flag_mask: Mask to be set in the top byte of the register when doing
+ * @write_flag_mask: Mask to be set in the top bytes of the register when doing
  *                   a write. If both read_flag_mask and write_flag_mask are
  *                   empty the regmap_bus default masks are used.
  * @use_single_rw: If set, converts the bulk read and write operations into
@@ -299,8 +299,8 @@ struct regmap_config {
 	const void *reg_defaults_raw;
 	unsigned int num_reg_defaults_raw;
 
-	u8 read_flag_mask;
-	u8 write_flag_mask;
+	unsigned long read_flag_mask;
+	unsigned long write_flag_mask;
 
 	bool use_single_rw;
 	bool can_multi_write;
-- 
2.8.1
