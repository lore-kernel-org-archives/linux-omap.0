From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod
 dependency
Date: Thu, 14 Feb 2013 21:40:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302142124370.11016@utopia.booyaka.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com> <1360840554-26901-2-git-send-email-balbi@ti.com> <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi> <20130214181217.GA11806@atomide.com> <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com> <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58050 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932601Ab3BNVka (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 16:40:30 -0500
In-Reply-To: <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, 14 Feb 2013, Paul Walmsley wrote:

> So instead of something bus-specific like that, a better way would be to 
> use something like:
> 
> va = dev->bus->ioremap( ... );
> va = dev->bus->iounmap( ... );

Something like this is what I was thinking.  Obviously there would be more
patches needed, for the various arches, etc.; and I'm not convinced that
the function pointer init is done at the right time yet. Comments welcome.


- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 14 Feb 2013 13:49:58 -0700
Subject: [PATCH] EXPERIMENTAL: device/ARM: allow buses to override ioremap*()
 and iounmap()

On some hardware, such as OMAP, the bus abstraction code needs to call
ioremap(), since some SoC-integration registers are located in the
device address space.  But generic device drivers should be able to
call ioremap() from driver code, for the majority of situations where
this isn't necessary.  This experimental patch allows Linux bus abstraction
code to override all of the ioremap*() and iounmap() functions.  In the OMAP
case, this would be used to return the previously-mapped address range from
the bus code, when called for the device's register area.  This would avoid
a duplicate TLB mapping for that space.

This might also be useful as a generic replacement for pci_ioremap_bar().

Compile-tested only.

---
 arch/arm/include/asm/io.h |   10 +++++-----
 arch/arm/mm/ioremap.c     |   30 ++++++++++++++++++++++++++++++
 arch/arm/mm/mmu.c         |    8 ++++++++
 include/linux/device.h    |   26 ++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 652b560..22cc085 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -325,11 +325,11 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * Documentation/io-mapping.txt.
  *
  */
-#define ioremap(cookie,size)		__arm_ioremap((cookie), (size), MT_DEVICE)
-#define ioremap_nocache(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE)
-#define ioremap_cached(cookie,size)	__arm_ioremap((cookie), (size), MT_DEVICE_CACHED)
-#define ioremap_wc(cookie,size)		__arm_ioremap((cookie), (size), MT_DEVICE_WC)
-#define iounmap				__arm_iounmap
+extern void __iomem *ioremap(unsigned long cookie, size_t size);
+extern void __iomem *ioremap_nocache(unsigned long cookie, size_t size);
+extern void __iomem *ioremap_cached(unsigned long cookie, size_t size);
+extern void __iomem *ioremap_wc(unsigned long cookie, size_t size);
+extern void iounmap(volatile void __iomem *va);
 
 /*
  * io{read,write}{8,16,32} macros
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 88fd86c..6507e69 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -398,3 +398,33 @@ int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_io);
 #endif
+
+void __iomem *ioremap(unsigned long cookie, size_t size)
+{
+	return __arm_ioremap(cookie, size, MT_DEVICE);
+}
+EXPORT_SYMBOL(ioremap);
+
+void __iomem *ioremap_nocache(unsigned long cookie, size_t size)
+{
+	return __arm_ioremap(cookie, size, MT_DEVICE);
+}
+EXPORT_SYMBOL(ioremap_nocache);
+
+void __iomem *ioremap_cached(unsigned long cookie, size_t size)
+{
+	return __arm_ioremap(cookie, size, MT_DEVICE_CACHED);
+}
+EXPORT_SYMBOL(ioremap_cached);
+
+void __iomem *ioremap_wc(unsigned long cookie, size_t size)
+{
+	return __arm_ioremap(cookie, size, MT_DEVICE_WC);
+}
+EXPORT_SYMBOL(ioremap_wc);
+
+void iounmap(volatile void __iomem *va)
+{
+	return __arm_iounmap(va);
+}
+EXPORT_SYMBOL(iounmap);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ce328c7..303dba0 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/platform_device.h>
 
 #include <asm/cp15.h>
 #include <asm/cputype.h>
@@ -28,6 +29,7 @@
 #include <asm/highmem.h>
 #include <asm/system_info.h>
 #include <asm/traps.h>
+#include <asm/io.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -1246,4 +1248,10 @@ void __init paging_init(struct machine_desc *mdesc)
 
 	empty_zero_page = virt_to_page(zero_page);
 	__flush_dcache_page(NULL, empty_zero_page);
+
+	platform_bus_type.ioremap = ioremap;
+	platform_bus_type.ioremap_nocache = ioremap_nocache;
+	platform_bus_type.ioremap_cached = ioremap_cached;
+	platform_bus_type.ioremap_wc = ioremap_wc;
+	platform_bus_type.iounmap = iounmap;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 43dcda9..48c35e2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -71,6 +71,26 @@ extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
  * @shutdown:	Called at shut-down time to quiesce the device.
  * @suspend:	Called when a device on this bus wants to go to sleep mode.
  * @resume:	Called to bring a device on this bus out of sleep mode.
+ * @ioremap:	Function pointer returning a virtual address used to
+ *		interact with a device on this bus.  Generally
+ *		implemented via @ioremap_nocache.
+ * @ioremap_nocache: Function pointer returning a virtual address used to
+ *		interact with a device on this bus.  Reads and writes
+ *		to the returned address space are not cached by the
+ *		CPU, so are suitable for memory-mapped I/O regions.
+ * @ioremap_cached: Function pointer returning a virtual address used to
+ *		interact with private memory located on this bus.  Reads and
+ *		writes to the returned address space may be cached by the
+ *		CPU, so this is suitable for I/O-mapped memory where all
+ *		accesses are via the same cache.
+ * @ioremap_wc: Function pointer returning a virtual address used to
+ *		interact with memory located on this bus.  Writes to
+ *		the returned address space may be combined by the CPU,
+ *		so this is suitable for I/O-mapped memory such as
+ *		framebuffers.
+ * @iounmap:	Function pointer called to indicate that a caller is done
+ *		with the virtual address mapping returned by @ioremap,
+ *		@ioremap_nocache, @ioremap_cached, or @ioremap_wc.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
@@ -105,6 +125,12 @@ struct bus_type {
 	int (*suspend)(struct device *dev, pm_message_t state);
 	int (*resume)(struct device *dev);
 
+	void __iomem *(*ioremap)(unsigned long phys_addr, size_t size);
+	void __iomem *(*ioremap_nocache)(unsigned long phys_addr, size_t size);
+	void __iomem *(*ioremap_cached)(unsigned long phys_addr, size_t size);
+	void __iomem *(*ioremap_wc)(unsigned long phys_addr, size_t size);
+	void (*iounmap)(volatile void __iomem *va);
+
 	const struct dev_pm_ops *pm;
 
 	struct iommu_ops *iommu_ops;
-- 
1.7.10.4

