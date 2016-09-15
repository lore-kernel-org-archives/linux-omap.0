From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4/7] mfd: ab8500-debugfs: Remove ab8500_dump_all_banks_to_mem()
Date: Thu, 15 Sep 2016 11:45:18 +0100
Message-ID: <20160915104521.14286-5-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Doesn't appear to be used.  No call sites exist.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c | 54 --------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 6c913c4..b948088 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1374,60 +1374,6 @@ void ab8500_dump_all_banks(struct device *dev)
 	}
 }
 
-/* Space for 500 registers. */
-#define DUMP_MAX_REGS 700
-static struct ab8500_register_dump
-{
-	u8 bank;
-	u8 reg;
-	u8 value;
-} ab8500_complete_register_dump[DUMP_MAX_REGS];
-
-/* This shall only be called upon kernel panic! */
-void ab8500_dump_all_banks_to_mem(void)
-{
-	int i, r = 0;
-	u8 bank;
-	int err = 0;
-
-	pr_info("Saving all ABB registers for crash analysis.\n");
-
-	for (bank = 0; bank < AB8500_NUM_BANKS; bank++) {
-		for (i = 0; i < debug_ranges[bank].num_ranges; i++) {
-			u8 reg;
-
-			for (reg = debug_ranges[bank].range[i].first;
-			     reg <= debug_ranges[bank].range[i].last;
-			     reg++) {
-				u8 value;
-
-				err = prcmu_abb_read(bank, reg, &value, 1);
-
-				if (err < 0)
-					goto out;
-
-				ab8500_complete_register_dump[r].bank = bank;
-				ab8500_complete_register_dump[r].reg = reg;
-				ab8500_complete_register_dump[r].value = value;
-
-				r++;
-
-				if (r >= DUMP_MAX_REGS) {
-					pr_err("%s: too many register to dump!\n",
-						__func__);
-					err = -EINVAL;
-					goto out;
-				}
-			}
-		}
-	}
-out:
-	if (err >= 0)
-		pr_info("Saved all ABB registers.\n");
-	else
-		pr_info("Failed to save all ABB registers.\n");
-}
-
 static int ab8500_all_banks_open(struct inode *inode, struct file *file)
 {
 	struct seq_file *s;
-- 
2.9.3
