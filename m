From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCHv2 1/2] ARM: VFP: Fixed suspend and added context save support
Date: Thu,  3 Dec 2009 15:35:52 +0200
Message-ID: <1259847353-22725-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1259847353-22725-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1259847353-22725-1-git-send-email-tero.kristo@nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

In some ARM architectures, like OMAP3, the VFP context can be lost during
dynamic sleep cycle. For this purpose, there is now a function
vfp_pm_save_context() that should be called before the VFP is assumed to
lose context. Next VFP trap will then restore context automatically.

We need to have the last_VFP_context[cpu] cleared after the save in idle,
else the restore would fail to restore when it sees that the last_VFP_context
is same as the current threads vfp_state. This happens when the same
process/thread traps an exception post idle.

This patch also fixes a potential problem with vfp_pm_suspend(), where
VFP context can be lost if the current process does not have VFP enabled.
Fixed by calling vfp_pm_save_context().

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/vfp/vfpmodule.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2d7423a..920a33b 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -329,22 +329,34 @@ static void vfp_enable(void *unused)
 #ifdef CONFIG_PM
 #include <linux/sysdev.h>
 
-static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
+void vfp_pm_save_context(void)
 {
-	struct thread_info *ti = current_thread_info();
 	u32 fpexc = fmrx(FPEXC);
+	unsigned int cpu = get_cpu();
+
+	/* Save last_VFP_context if needed */
+	if (last_VFP_context[cpu]) {
+		/* Enable vfp to save context */
+		if (!(fpexc & FPEXC_EN)) {
+			vfp_enable(NULL);
+			fmxr(FPEXC, fpexc | FPEXC_EN);
+		}
 
-	/* if vfp is on, then save state for resumption */
-	if (fpexc & FPEXC_EN) {
 		printk(KERN_DEBUG "%s: saving vfp state\n", __func__);
-		vfp_save_state(&ti->vfpstate, fpexc);
+		vfp_save_state(last_VFP_context[cpu], fpexc);
 
 		/* disable, just in case */
-		fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
+		fmxr(FPEXC, fpexc & ~FPEXC_EN);
+
+		last_VFP_context[cpu] = NULL;
 	}
 
-	/* clear any information we had about last context state */
-	memset(last_VFP_context, 0, sizeof(last_VFP_context));
+	put_cpu();
+}
+
+static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
+{
+	vfp_pm_save_context();
 
 	return 0;
 }
-- 
1.5.4.3
