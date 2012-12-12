From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [RFC 1/5] ARM: CORESIGHT: Add generic lock/unlock helpers
Date: Wed, 12 Dec 2012 15:43:04 -0600
Message-ID: <1355348588-22318-2-git-send-email-jon-hunter@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1355348588-22318-1-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Ming Lei <ming.lei-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The Cross Trigger Interface (CTI) helpers in cti.h include definitions
for the Coresight Lock Access Register (LAR) and Lock Status Register
(LSR). These registers are already defined in coresight.h and so rather
than having multiple definitions, just use the definitions from
coresight.h.

Add the following coresight macros ...
- coresight_unlock() --> Unlocks coresight module
- coresight_lock()   --> Locks coresight module

Use the above macros for ETB, ETM and CTI. The do-while(0) statement
has been removed from the macro as it is not a multi-line macro.

Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
---
 arch/arm/include/asm/cti.h                |   16 +++-------------
 arch/arm/include/asm/hardware/coresight.h |   16 ++++++++--------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/cti.h b/arch/arm/include/asm/cti.h
index f2e5cad..00add00 100644
--- a/arch/arm/include/asm/cti.h
+++ b/arch/arm/include/asm/cti.h
@@ -2,6 +2,7 @@
 #define __ASMARM_CTI_H
 
 #include	<asm/io.h>
+#include	<asm/hardware/coresight.h>
 
 /* The registers' definition is from section 3.2 of
  * Embedded Cross Trigger Revision: r0p0
@@ -29,17 +30,6 @@
 #define		CTIPCELLID2		0xFF8
 #define		CTIPCELLID3		0xFFC
 
-/* The below are from section 3.6.4 of
- * CoreSight v1.0 Architecture Specification
- */
-#define		LOCKACCESS		0xFB0
-#define		LOCKSTATUS		0xFB4
-
-/* write this value to LOCKACCESS will unlock the module, and
- * other value will lock the module
- */
-#define		LOCKCODE		0xC5ACCE55
-
 /**
  * struct cti - cross trigger interface struct
  * @base: mapped virtual address for the cti base
@@ -146,7 +136,7 @@ static inline void cti_irq_ack(struct cti *cti)
  */
 static inline void cti_unlock(struct cti *cti)
 {
-	__raw_writel(LOCKCODE, cti->base + LOCKACCESS);
+	coresight_unlock(cti->base);
 }
 
 /**
@@ -158,6 +148,6 @@ static inline void cti_unlock(struct cti *cti)
  */
 static inline void cti_lock(struct cti *cti)
 {
-	__raw_writel(~LOCKCODE, cti->base + LOCKACCESS);
+	coresight_lock(cti->base);
 }
 #endif
diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
index 7ecd793..dcd0e66 100644
--- a/arch/arm/include/asm/hardware/coresight.h
+++ b/arch/arm/include/asm/hardware/coresight.h
@@ -141,17 +141,17 @@
 #define ETBFF_TRIGEVT		BIT(9)
 #define ETBFF_TRIGFL		BIT(10)
 
-#define etb_writel(t, v, x) \
-	(__raw_writel((v), (t)->etb_regs + (x)))
+#define etb_writel(t, v, x) (__raw_writel((v), (t)->etb_regs + (x)))
 #define etb_readl(t, x) (__raw_readl((t)->etb_regs + (x)))
 
-#define etm_lock(t) do { etm_writel((t), 0, CSMR_LOCKACCESS); } while (0)
-#define etm_unlock(t) \
-	do { etm_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
+#define etb_lock(t) coresight_lock((t)->etb_regs)
+#define etb_unlock(t) coresight_unlock((t)->etb_regs)
+#define etm_lock(t) coresight_lock((t)->etm_regs)
+#define etm_unlock(t) coresight_unlock((t)->etm_regs)
 
-#define etb_lock(t) do { etb_writel((t), 0, CSMR_LOCKACCESS); } while (0)
-#define etb_unlock(t) \
-	do { etb_writel((t), UNLOCK_MAGIC, CSMR_LOCKACCESS); } while (0)
+#define coresight_lock(base) (__raw_writel(0, base + CSMR_LOCKACCESS))
+#define coresight_unlock(base) \
+	(__raw_writel(UNLOCK_MAGIC, base + CSMR_LOCKACCESS))
 
 #endif /* __ASM_HARDWARE_CORESIGHT_H */
 
-- 
1.7.10.4
