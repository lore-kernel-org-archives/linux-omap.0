From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 04/97] ARM: l2c: omap2: remove ES1.0 support
Date: Mon, 28 Apr 2014 20:26:15 +0100
Message-ID: <E1WerBv-0007VC-SE@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.ifradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Santosh says:
> But we should kill all of that since we long back decided to remove
> ES1.0 related code. The mach-omap code alreasy has removed the ES1.0
> compatibility so feel free to remove any specific ES1.0
> related stuff. That silicon is long dead.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 95e171a055f3..48cf74d284ec 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -182,7 +182,7 @@ static void omap4_l2x0_set_debug(unsigned long val)
 
 static int __init omap_l2_cache_init(void)
 {
-	u32 aux_ctrl = 0;
+	u32 aux_ctrl;
 
 	/*
 	 * To avoid code running on other OMAPs in
@@ -196,27 +196,18 @@ static int __init omap_l2_cache_init(void)
 	if (WARN_ON(!l2cache_base))
 		return -ENOMEM;
 
-	/*
-	 * 16-way associativity, parity disabled
-	 * Way size - 32KB (es1.0)
-	 * Way size - 64KB (es2.0 +)
-	 */
-	aux_ctrl = ((1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
+	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
+	aux_ctrl = (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT) |
 			(0x1 << 25) |
 			(0x1 << L2X0_AUX_CTRL_NS_LOCKDOWN_SHIFT) |
-			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT));
-
-	if (omap_rev() == OMAP4430_REV_ES1_0) {
-		aux_ctrl |= 0x2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
-	} else {
-		aux_ctrl |= ((0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
+			(0x1 << L2X0_AUX_CTRL_NS_INT_CTRL_SHIFT)) |
+			(0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
 			(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
 			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
 			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT) |
-			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT));
-	}
-	if (omap_rev() != OMAP4430_REV_ES1_0)
-		omap_smc1(0x109, aux_ctrl);
+			(1 << L2X0_AUX_CTRL_EARLY_BRESP_SHIFT);
+
+	omap_smc1(0x109, aux_ctrl);
 
 	/* Enable PL310 L2 Cache controller */
 	omap_smc1(0x102, 0x1);
-- 
1.8.3.1
