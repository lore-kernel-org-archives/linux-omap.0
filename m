From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of BTB)
 for secondary cores
Date: Tue, 12 Jun 2018 16:36:11 -0500
Message-ID: <20180612213611.2484-1-nm@ti.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Call secure services to enable ACTLR[0] (Enable invalidates of BTB with
ICIALLU) when branch hardening is enabled for kernel.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Based on: next-20180612 +
Uboot series posted:  https://marc.info/?l=u-boot&m=152883522011042&w=2

With Just u-boot changes alone: OMAP5-uevm: https://pastebin.ubuntu.com/p/9yDM22bJ6n/
with kernel changes added on: https://pastebin.ubuntu.com/p/gXPBGGYRPX/

 arch/arm/mach-omap2/omap-smp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 69df3620eca5..28fc80ea675b 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -109,6 +109,32 @@ void omap5_erratum_workaround_801819(void)
 static inline void omap5_erratum_workaround_801819(void) { }
 #endif
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+static void omap5_harden_predictor(void)
+{
+	u32 acr, acr_mask;
+
+	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
+
+	/*
+	 * BIT(0) - Disables streaming. All write-allocate lines allocate in
+	 */
+	acr_mask = BIT(0);
+
+	/* do we already have it done.. if yes, skip expensive smc */
+	if ((acr & acr_mask) == acr_mask)
+		return;
+
+	acr |= acr_mask;
+	omap_smc1(OMAP5_DRA7_MON_SET_ACR_INDEX, acr);
+
+	pr_debug("%s: ARM ACR setup for CVE_2017_5715 applied on CPU%d\n",
+		 __func__, smp_processor_id());
+}
+#else
+static inline void omap5_harden_predictor(void) { }
+#endif
+
 static void omap4_secondary_init(unsigned int cpu)
 {
 	/*
@@ -131,6 +157,8 @@ static void omap4_secondary_init(unsigned int cpu)
 		set_cntfreq();
 		/* Configure ACR to disable streaming WA for 801819 */
 		omap5_erratum_workaround_801819();
+		/* Enable ACR to allow for ICUALLU workaround */
+		omap5_harden_predictor();
 	}
 
 	/*
-- 
2.15.1
