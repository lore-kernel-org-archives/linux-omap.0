From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/7] ARM: iop13xx: make headers more local
Date: Tue,  1 Dec 2015 00:00:55 +0100
Message-ID: <1448924458-3279040-5-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some header files are never included outside of a mach-iop13xx
directory and do not need to be made visible in include/mach,
so let's just move them all down one level.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-iop13xx/include/mach/pci.h       | 57 -------------------------
 arch/arm/mach-iop13xx/iq81340mc.c              |  2 +-
 arch/arm/mach-iop13xx/iq81340sc.c              |  2 +-
 arch/arm/mach-iop13xx/irq.c                    |  2 +-
 arch/arm/mach-iop13xx/{include/mach => }/msi.h |  0
 arch/arm/mach-iop13xx/pci.c                    |  2 +-
 arch/arm/mach-iop13xx/pci.h                    | 58 ++++++++++++++++++++++++++
 7 files changed, 62 insertions(+), 61 deletions(-)
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/pci.h
 rename arch/arm/mach-iop13xx/{include/mach => }/msi.h (100%)

diff --git a/arch/arm/mach-iop13xx/include/mach/pci.h b/arch/arm/mach-iop13xx/include/mach/pci.h
deleted file mode 100644
index 59f42b535572..000000000000
--- a/arch/arm/mach-iop13xx/include/mach/pci.h
+++ /dev/null
@@ -1,57 +0,0 @@
-#ifndef _IOP13XX_PCI_H_
-#define _IOP13XX_PCI_H_
-#include <linux/io.h>
-#include <mach/irqs.h>
-
-struct pci_sys_data;
-struct hw_pci;
-int iop13xx_pci_setup(int nr, struct pci_sys_data *sys);
-struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *);
-void iop13xx_atu_select(struct hw_pci *plat_pci);
-void iop13xx_pci_init(void);
-void iop13xx_map_pci_memory(void);
-
-#define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
-			       PCI_STATUS_SIG_TARGET_ABORT | \
-			       PCI_STATUS_REC_TARGET_ABORT | \
-			       PCI_STATUS_REC_TARGET_ABORT | \
-			       PCI_STATUS_REC_MASTER_ABORT | \
-			       PCI_STATUS_SIG_SYSTEM_ERROR | \
-	 		       PCI_STATUS_DETECTED_PARITY)
-
-#define IOP13XX_ATUE_ATUISR_ERROR (IOP13XX_ATUE_STAT_HALT_ON_ERROR |  \
-				    IOP13XX_ATUE_STAT_ROOT_SYS_ERR |   \
-				    IOP13XX_ATUE_STAT_PCI_IFACE_ERR |  \
-				    IOP13XX_ATUE_STAT_ERR_COR |	       \
-				    IOP13XX_ATUE_STAT_ERR_UNCOR |      \
-				    IOP13XX_ATUE_STAT_CRS |	       \
-				    IOP13XX_ATUE_STAT_DET_PAR_ERR |    \
-				    IOP13XX_ATUE_STAT_EXT_REC_MABORT | \
-				    IOP13XX_ATUE_STAT_SIG_TABORT |     \
-				    IOP13XX_ATUE_STAT_EXT_REC_TABORT | \
-				    IOP13XX_ATUE_STAT_MASTER_DATA_PAR)
-
-#define IOP13XX_ATUX_ATUISR_ERROR (IOP13XX_ATUX_STAT_TX_SCEM |        \
-				    IOP13XX_ATUX_STAT_REC_SCEM |       \
-				    IOP13XX_ATUX_STAT_TX_SERR |	       \
-				    IOP13XX_ATUX_STAT_DET_PAR_ERR |    \
-				    IOP13XX_ATUX_STAT_INT_REC_MABORT | \
-				    IOP13XX_ATUX_STAT_REC_SERR |       \
-				    IOP13XX_ATUX_STAT_EXT_REC_MABORT | \
-				    IOP13XX_ATUX_STAT_EXT_REC_TABORT | \
-				    IOP13XX_ATUX_STAT_EXT_SIG_TABORT | \
-				    IOP13XX_ATUX_STAT_MASTER_DATA_PAR)
-
-/* PCI interrupts
- */
-#define ATUX_INTA IRQ_IOP13XX_XINT0
-#define ATUX_INTB IRQ_IOP13XX_XINT1
-#define ATUX_INTC IRQ_IOP13XX_XINT2
-#define ATUX_INTD IRQ_IOP13XX_XINT3
-
-#define ATUE_INTA IRQ_IOP13XX_ATUE_IMA
-#define ATUE_INTB IRQ_IOP13XX_ATUE_IMB
-#define ATUE_INTC IRQ_IOP13XX_ATUE_IMC
-#define ATUE_INTD IRQ_IOP13XX_ATUE_IMD
-
-#endif /* _IOP13XX_PCI_H_ */
diff --git a/arch/arm/mach-iop13xx/iq81340mc.c b/arch/arm/mach-iop13xx/iq81340mc.c
index 9cd07d396093..d255ab5ad1a5 100644
--- a/arch/arm/mach-iop13xx/iq81340mc.c
+++ b/arch/arm/mach-iop13xx/iq81340mc.c
@@ -23,7 +23,7 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/pci.h>
+#include "pci.h"
 #include <asm/mach/time.h>
 #include <mach/time.h>
 
diff --git a/arch/arm/mach-iop13xx/iq81340sc.c b/arch/arm/mach-iop13xx/iq81340sc.c
index b3ec11cb707e..33eeaf1fa11d 100644
--- a/arch/arm/mach-iop13xx/iq81340sc.c
+++ b/arch/arm/mach-iop13xx/iq81340sc.c
@@ -23,7 +23,7 @@
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <mach/pci.h>
+#include "pci.h"
 #include <asm/mach/time.h>
 #include <mach/time.h>
 
diff --git a/arch/arm/mach-iop13xx/irq.c b/arch/arm/mach-iop13xx/irq.c
index 623d85a4af2d..c702cc4092de 100644
--- a/arch/arm/mach-iop13xx/irq.c
+++ b/arch/arm/mach-iop13xx/irq.c
@@ -25,7 +25,7 @@
 #include <asm/irq.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/msi.h>
+#include "msi.h"
 
 /* INTCTL0 CP6 R0 Page 4
  */
diff --git a/arch/arm/mach-iop13xx/include/mach/msi.h b/arch/arm/mach-iop13xx/msi.h
similarity index 100%
rename from arch/arm/mach-iop13xx/include/mach/msi.h
rename to arch/arm/mach-iop13xx/msi.h
diff --git a/arch/arm/mach-iop13xx/pci.c b/arch/arm/mach-iop13xx/pci.c
index 9082b84aeebb..204eb4460271 100644
--- a/arch/arm/mach-iop13xx/pci.c
+++ b/arch/arm/mach-iop13xx/pci.c
@@ -27,7 +27,7 @@
 #include <asm/sizes.h>
 #include <asm/signal.h>
 #include <asm/mach/pci.h>
-#include <mach/pci.h>
+#include "pci.h"
 
 #define IOP13XX_PCI_DEBUG 0
 #define PRINTK(x...) ((void)(IOP13XX_PCI_DEBUG && printk(x)))
diff --git a/arch/arm/mach-iop13xx/pci.h b/arch/arm/mach-iop13xx/pci.h
index d45a80b3080e..71b9c57e1fde 100644
--- a/arch/arm/mach-iop13xx/pci.h
+++ b/arch/arm/mach-iop13xx/pci.h
@@ -1,6 +1,64 @@
+#ifndef _IOP13XX_PCI_H_
+#define _IOP13XX_PCI_H_
+#include <linux/io.h>
+#include <mach/irqs.h>
+
 #include <linux/types.h>
 
 extern void __iomem *iop13xx_atue_mem_base;
 extern void __iomem *iop13xx_atux_mem_base;
 extern size_t iop13xx_atue_mem_size;
 extern size_t iop13xx_atux_mem_size;
+
+struct pci_sys_data;
+struct hw_pci;
+int iop13xx_pci_setup(int nr, struct pci_sys_data *sys);
+struct pci_bus *iop13xx_scan_bus(int nr, struct pci_sys_data *);
+void iop13xx_atu_select(struct hw_pci *plat_pci);
+void iop13xx_pci_init(void);
+void iop13xx_map_pci_memory(void);
+
+#define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
+			       PCI_STATUS_SIG_TARGET_ABORT | \
+			       PCI_STATUS_REC_TARGET_ABORT | \
+			       PCI_STATUS_REC_TARGET_ABORT | \
+			       PCI_STATUS_REC_MASTER_ABORT | \
+			       PCI_STATUS_SIG_SYSTEM_ERROR | \
+	 		       PCI_STATUS_DETECTED_PARITY)
+
+#define IOP13XX_ATUE_ATUISR_ERROR (IOP13XX_ATUE_STAT_HALT_ON_ERROR |  \
+				    IOP13XX_ATUE_STAT_ROOT_SYS_ERR |   \
+				    IOP13XX_ATUE_STAT_PCI_IFACE_ERR |  \
+				    IOP13XX_ATUE_STAT_ERR_COR |	       \
+				    IOP13XX_ATUE_STAT_ERR_UNCOR |      \
+				    IOP13XX_ATUE_STAT_CRS |	       \
+				    IOP13XX_ATUE_STAT_DET_PAR_ERR |    \
+				    IOP13XX_ATUE_STAT_EXT_REC_MABORT | \
+				    IOP13XX_ATUE_STAT_SIG_TABORT |     \
+				    IOP13XX_ATUE_STAT_EXT_REC_TABORT | \
+				    IOP13XX_ATUE_STAT_MASTER_DATA_PAR)
+
+#define IOP13XX_ATUX_ATUISR_ERROR (IOP13XX_ATUX_STAT_TX_SCEM |        \
+				    IOP13XX_ATUX_STAT_REC_SCEM |       \
+				    IOP13XX_ATUX_STAT_TX_SERR |	       \
+				    IOP13XX_ATUX_STAT_DET_PAR_ERR |    \
+				    IOP13XX_ATUX_STAT_INT_REC_MABORT | \
+				    IOP13XX_ATUX_STAT_REC_SERR |       \
+				    IOP13XX_ATUX_STAT_EXT_REC_MABORT | \
+				    IOP13XX_ATUX_STAT_EXT_REC_TABORT | \
+				    IOP13XX_ATUX_STAT_EXT_SIG_TABORT | \
+				    IOP13XX_ATUX_STAT_MASTER_DATA_PAR)
+
+/* PCI interrupts
+ */
+#define ATUX_INTA IRQ_IOP13XX_XINT0
+#define ATUX_INTB IRQ_IOP13XX_XINT1
+#define ATUX_INTC IRQ_IOP13XX_XINT2
+#define ATUX_INTD IRQ_IOP13XX_XINT3
+
+#define ATUE_INTA IRQ_IOP13XX_ATUE_IMA
+#define ATUE_INTB IRQ_IOP13XX_ATUE_IMB
+#define ATUE_INTC IRQ_IOP13XX_ATUE_IMC
+#define ATUE_INTD IRQ_IOP13XX_ATUE_IMD
+
+#endif /* _IOP13XX_PCI_H_ */
-- 
2.1.0.rc2
