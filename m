From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 7/9] ARM: OMAP: clockdomain: add support for preventing
 domain transitions
Date: Thu, 31 May 2012 16:29:00 +0300
Message-ID: <1338470942-20185-8-git-send-email-t-kristo@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Some clockdomains can't support manual domain transitions triggered by
clock framework, and must be prevented from doing so. Added clkdm flag
CLKDM_SKIP_MANUAL_TRANS for doing this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    6 ++++++
 arch/arm/mach-omap2/clockdomain.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index c665348..fa652b5 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -948,6 +948,9 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	if ((clkdm_usecount_inc(clkdm) > 1) && autodeps)
 		return 0;
 
+	if (clkdm->flags & CLKDM_SKIP_MANUAL_TRANS)
+		return 0;
+
 	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_enable(clkdm);
 	pwrdm_state_switch(clkdm->pwrdm.ptr);
@@ -973,6 +976,9 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 	if (clkdm_usecount_dec(clkdm) > 0)
 		return 0;
 
+	if (clkdm->flags & CLKDM_SKIP_MANUAL_TRANS)
+		return 0;
+
 	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_disable(clkdm);
 	pwrdm_state_switch(clkdm->pwrdm.ptr);
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 373399a..35ac7ee 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -31,12 +31,15 @@
  *
  * CLKDM_NO_AUTODEPS: Prevent "autodeps" from being added/removed from this
  *     clockdomain.  (Currently, this applies to OMAP3 clockdomains only.)
+ * CLKDM_SKIP_MANUAL_TRANS: Prevent clockdomain code from attempting to change
+ *     clockdomain state manually. Needed for PER domain on omap3.
  */
 #define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
 #define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
 #define CLKDM_CAN_ENABLE_AUTO			(1 << 2)
 #define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
 #define CLKDM_NO_AUTODEPS			(1 << 4)
+#define CLKDM_SKIP_MANUAL_TRANS		(1 << 5)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
-- 
1.7.4.1
