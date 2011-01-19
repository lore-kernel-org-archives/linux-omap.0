From: Ari Kauppi <kauppi@papupata.org>
Subject: [PATCH] ARM: oprofile: Always allow backtraces
Date: Wed, 19 Jan 2011 22:54:33 +0200
Message-ID: <1295470473-1095-1-git-send-email-kauppi@papupata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robert.richter@amd.com
Cc: Ari Kauppi <kauppi@papupata.org>, Matt Fleming <matt@console-pimps.org>, Will Deacon <will.deacon@arm.com>, Richard Purdie <rpurdie@rpsys.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Always allow backtrace when using oprofile on ARM, even if a PMU
isn't present.

Restores functionality originally introduced in
1b7b56982fdcd9d85effd76f3928cf5d6eb26155 by Richard Purdie.

Signed-off-by: Ari Kauppi <kauppi@papupata.org>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Matt Fleming <matt@console-pimps.org>
---
 arch/arm/oprofile/common.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 8aa9744..a23e5ae 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -46,6 +46,7 @@ char *op_name_from_perf_id(void)
 		return NULL;
 	}
 }
+#endif
 
 static int report_trace(struct stackframe *frame, void *d)
 {
@@ -109,6 +110,7 @@ static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
 		tail = user_backtrace(tail);
 }
 
+#ifdef CONFIG_HW_PERF_EVENTS
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 	ops->backtrace		= arm_backtrace;
@@ -124,6 +126,8 @@ void __exit oprofile_arch_exit(void)
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 	pr_info("oprofile: hardware counters not available\n");
+	ops->backtrace		= arm_backtrace;
+
 	return -ENODEV;
 }
 void __exit oprofile_arch_exit(void) {}
-- 
1.7.4.rc2.3.g60a2e
