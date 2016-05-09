From: Dave Gerlach <d-gerlach@ti.com>
Subject: [RFC PATCH 1/3] asm-generic: io: Add exec versions of ioremap
Date: Mon, 9 May 2016 16:41:49 -0500
Message-ID: <1462830111-28172-2-git-send-email-d-gerlach@ti.com>
References: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462830111-28172-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Russ Dill <russ.dill@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, Russ Dill <Russ.Dill@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Russ Dill <russ.dill@ti.com>

If code is to be copied into and area (such as SRAM) and run,
it needs to be marked as exec. Currently only an ARM version
of this exists, but a generic version will be useful for drivers.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/include/asm/io.h   |  5 +++++
 arch/arm/mm/ioremap.c       | 14 ++++++++++++++
 arch/arm/mm/nommu.c         | 14 ++++++++++++++
 include/asm-generic/iomap.h |  5 +++++
 4 files changed, 38 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 485982084fe9..7d07a02cb7bc 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -399,6 +399,11 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 #define ioremap_wc ioremap_wc
 #define ioremap_wt ioremap_wc
 
+void __iomem *ioremap_exec(resource_size_t res_cookie, size_t size);
+void __iomem *ioremap_exec_nocache(resource_size_t res_cookie, size_t size);
+#define ioremap_exec ioremap_exec
+#define ioremap_exec_nocache ioremap_exec_nocache
+
 void iounmap(volatile void __iomem *iomem_cookie);
 #define iounmap iounmap
 
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 66a978d05958..c6eef3c98074 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -400,6 +400,20 @@ EXPORT_SYMBOL(ioremap_wc);
  * clocks that would affect normal memory for example. Please see
  * CONFIG_GENERIC_ALLOCATOR for allocating external memory.
  */
+void __iomem *ioremap_exec(resource_size_t res_cookie, size_t size)
+{
+	return arch_ioremap_caller(res_cookie, size, MT_MEMORY_RWX,
+				   __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_exec);
+
+void __iomem *ioremap_exec_nocache(resource_size_t res_cookie, size_t size)
+{
+	return arch_ioremap_caller(res_cookie, size, MT_MEMORY_RWX_NONCACHED,
+				   __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_exec_nocache);
+
 void __iomem *
 __arm_ioremap_exec(phys_addr_t phys_addr, size_t size, bool cached)
 {
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 1dd10936d68d..1d1d587340e6 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -380,6 +380,20 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size)
 }
 EXPORT_SYMBOL(ioremap_wc);
 
+void __iomem *ioremap_exec(resource_size_t res_cookie, size_t size)
+{
+	return __arm_ioremap_caller(res_cookie, size, 0,
+				    __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_exec);
+
+void __iomem *ioremap_exec_nocache(resource_size_t res_cookie, size_t size)
+{
+	return __arm_ioremap_caller(res_cookie, size, 0,
+				    __builtin_return_address(0));
+}
+EXPORT_SYMBOL(ioremap_exec_nocache);
+
 void __iounmap(volatile void __iomem *addr)
 {
 }
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index d8f8622fa044..a789aad509c3 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -70,6 +70,11 @@ extern void ioport_unmap(void __iomem *);
 #define ioremap_wt ioremap_nocache
 #endif
 
+#ifndef ARCH_HAS_IOREMAP_EXEC
+#define ioremap_exec ioremap
+#define ioremap_exec_nocache ioremap_nocache
+#endif
+
 #ifdef CONFIG_PCI
 /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
 struct pci_dev;
-- 
2.7.3
