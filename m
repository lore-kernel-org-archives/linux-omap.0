From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/3] ARM: memremap: implement arch_memremap_exec/exec_nocache
Date: Thu, 27 Oct 2016 13:56:10 -0500
Message-ID: <20161027185612.22362-2-d-gerlach@ti.com>
References: <20161027185612.22362-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161027185612.22362-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Introduce arch_memremap_exec and arch_memremap_exec_nocache for ARM to
allow mapping of memory as executable. Some platforms have a requirement
to map on-chip memory, such as SRAM, to hold and run code that cannot be
executed in DRAM, such as low-level PM code or code to reconfigure the
DRAM controller itself.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/include/asm/io.h |  5 +++++
 arch/arm/mm/ioremap.c     | 16 ++++++++++++++++
 arch/arm/mm/nommu.c       | 12 ++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 021692c64de3..67476a5add20 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -411,6 +411,11 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 void iounmap(volatile void __iomem *iomem_cookie);
 #define iounmap iounmap
 
+void *arch_memremap_exec(phys_addr_t phys_addr, size_t size);
+void *arch_memremap_exec_nocache(phys_addr_t phys_addr, size_t size);
+#define arch_memremap_exec arch_memremap_exec
+#define arch_memremap_exec_nocache arch_memremap_exec_nocache
+
 void *arch_memremap_wb(phys_addr_t phys_addr, size_t size);
 #define arch_memremap_wb arch_memremap_wb
 
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ff0eed23ddf1..5c22a7a0b349 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -419,6 +419,22 @@ __arm_ioremap_exec(phys_addr_t phys_addr, size_t size, bool cached)
 			__builtin_return_address(0));
 }
 
+void *arch_memremap_exec(phys_addr_t phys_addr, size_t size)
+{
+	return (__force void *)arch_ioremap_caller(phys_addr, size,
+						   MT_MEMORY_RWX,
+						   __builtin_return_address(0));
+}
+EXPORT_SYMBOL(arch_memremap_exec);
+
+void *arch_memremap_exec_nocache(phys_addr_t phys_addr, size_t size)
+{
+	return (__force void *)arch_ioremap_caller(phys_addr, size,
+						   MT_MEMORY_RWX_NONCACHED,
+						   __builtin_return_address(0));
+}
+EXPORT_SYMBOL(arch_memremap_exec_nocache);
+
 void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
 {
 	return (__force void *)arch_ioremap_caller(phys_addr, size,
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 2740967727e2..038922133ec4 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -390,6 +390,18 @@ void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
 	return (void *)phys_addr;
 }
 
+void *arch_memremap_exec(phys_addr_t phys_addr, size_t size)
+{
+	return (void *)phys_addr;
+}
+EXPORT_SYMBOL(arch_memremap_exec);
+
+void *arch_memremap_exec_nocache(phys_addr_t phys_addr, size_t size)
+{
+	return (void *)phys_addr;
+}
+EXPORT_SYMBOL(arch_memremap_exec_nocache);
+
 void __iounmap(volatile void __iomem *addr)
 {
 }
-- 
2.9.3
