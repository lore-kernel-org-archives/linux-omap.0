From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2] ARM: DRA7/OMAP5: Enable ACTLR[0] (Enable invalidates of
 BTB) for secondary cores
Date: Tue, 10 Jul 2018 14:47:25 -0500
Message-ID: <20180710194725.20339-1-nm@ti.com>
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

On GP devices OMAP5/DRA7, there is no possibility to update secure
side since "secure world" is ROM and there are no override mechanisms
possible. On HS devices, appropriate PPA should do the workarounds as
well.

However, the configuration is only done for secondary core, since it is
expected that firmware/bootloader will have enabled the required
configuration for the primary boot core (note: bootloaders typically
will NOT enable secondary processors, since it has no need to do so).

Signed-off-by: Nishanth Menon <nm@ti.com>
---

NOTE: For U-boot based platforms, please make sure you are on v2018.07 at least.

Linux kernel will complain if the workaround are not activated.

Changes since V1:
* review comments update for commit message, added incode documentation +
  renamed function to better indicate this is for secondary core.

V1: https://patchwork.kernel.org/patch/10461275/

 arch/arm/mach-omap2/omap-smp.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 69df3620eca5..1c73694c871a 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -109,6 +109,45 @@ void omap5_erratum_workaround_801819(void)
 static inline void omap5_erratum_workaround_801819(void) { }
 #endif
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+/*
+ * Configure ACR and enable ACTLR[0] (Enable invalidates of BTB with
+ * ICIALLU) to activate the workaround for secondary Core.
+ * NOTE: it is assumed that the primary core's configuration is done
+ * by the boot loader (kernel will detect a misconfiguration and complain
+ * if this is not done).
+ *
+ * In General Purpose(GP) devices, ACR bit settings can only be done
+ * by ROM code in "secure world" using the smc call and there is no
+ * option to update the "firmware" on such devices. This also works for
+ * High security(HS) devices, as a backup option in case the
+ * "update" is not done in the "security firmware".
+ */
+static void omap5_secondary_harden_predictor(void)
+{
+	u32 acr, acr_mask;
+
+	asm volatile ("mrc p15, 0, %0, c1, c0, 1" : "=r" (acr));
+
+	/*
+	 * ACTLR[0] (Enable invalidates of BTB with ICIALLU)
+	 */
+	acr_mask = BIT(0);
+
+	/* Do we already have it done.. if yes, skip expensive smc */
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
+static inline void omap5_secondary_harden_predictor(void) { }
+#endif
+
 static void omap4_secondary_init(unsigned int cpu)
 {
 	/*
@@ -131,6 +170,8 @@ static void omap4_secondary_init(unsigned int cpu)
 		set_cntfreq();
 		/* Configure ACR to disable streaming WA for 801819 */
 		omap5_erratum_workaround_801819();
+		/* Enable ACR to allow for ICUALLU workaround */
+		omap5_secondary_harden_predictor();
 	}
 
 	/*
-- 
2.15.1
