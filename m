From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/7] mfd: ab8500-debugfs: Remove 'weak' function suspend_test_wake_cause_interrupt_is_mine()
Date: Thu, 15 Sep 2016 11:45:19 +0100
Message-ID: <20160915104521.14286-6-lee.jones@linaro.org>
References: <20160915104521.14286-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

There are no other functions which can over-ride it.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-debugfs.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index b948088..acf6c00 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1522,18 +1522,10 @@ static u32 num_interrupts[AB8500_MAX_NR_IRQS];
 static u32 num_wake_interrupts[AB8500_MAX_NR_IRQS];
 static int num_interrupt_lines;
 
-bool __attribute__((weak)) suspend_test_wake_cause_interrupt_is_mine(u32 my_int)
-{
-	return false;
-}
-
 void ab8500_debug_register_interrupt(int line)
 {
-	if (line < num_interrupt_lines) {
+	if (line < num_interrupt_lines)
 		num_interrupts[line]++;
-		if (suspend_test_wake_cause_interrupt_is_mine(irq_ab8500))
-			num_wake_interrupts[line]++;
-	}
 }
 
 static int ab8500_interrupts_print(struct seq_file *s, void *p)
-- 
2.9.3
