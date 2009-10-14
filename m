From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/27] OMAP3: PM: Restore MMU table entry
Date: Wed, 14 Oct 2009 14:57:52 -0700
Message-ID: <1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

During the MMU restoration on the restore path from MPU OFF, the page
table entry for the page consisting of the code being executed is
modified to make MMU return VA=PA.

The MMU is then enabled and the original entry is being stored in
scratchpad.  This patch reads the original values stored in
scratchpad, and restores them back.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7eab539..8c9a036 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -29,6 +29,8 @@
 #include <mach/control.h>
 #include <mach/serial.h>
 
+#include <asm/tlbflush.h>
+
 #include "cm.h"
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
@@ -164,6 +166,35 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void restore_control_register(u32 val)
+{
+	__asm__ __volatile__ ("mcr p15, 0, %0, c1, c0, 0" : : "r" (val));
+}
+
+/* Function to restore the table entry that was modified for enabling MMU */
+static void restore_table_entry(void)
+{
+	u32 *scratchpad_address;
+	u32 previous_value, control_reg_value;
+	u32 *address;
+
+	scratchpad_address = OMAP2_IO_ADDRESS(OMAP343X_SCRATCHPAD);
+
+	/* Get address of entry that was modified */
+	address = (u32 *)__raw_readl(scratchpad_address +
+				     OMAP343X_TABLE_ADDRESS_OFFSET);
+	/* Get the previous value which needs to be restored */
+	previous_value = __raw_readl(scratchpad_address +
+				     OMAP343X_TABLE_VALUE_OFFSET);
+	address = __va(address);
+	*address = previous_value;
+	flush_tlb_all();
+	control_reg_value = __raw_readl(scratchpad_address
+					+ OMAP343X_CONTROL_REG_VALUE_OFFSET);
+	/* This will enable caches and prediction */
+	restore_control_register(control_reg_value);
+}
+
 static void omap_sram_idle(void)
 {
 	/* Variable to tell what needs to be saved and restored
@@ -220,6 +251,10 @@ static void omap_sram_idle(void)
 	_omap_sram_idle(NULL, save_state);
 	cpu_init();
 
+	/* Restore table entry modified during MMU restoration */
+	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
+		restore_table_entry();
+
 	if (core_next_state < PWRDM_POWER_ON) {
 		if (per_next_state < PWRDM_POWER_ON)
 			omap_uart_resume_idle(2);
-- 
1.6.4.3
