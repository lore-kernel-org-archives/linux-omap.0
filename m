From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
 changes
Date: Thu, 12 Jan 2012 11:59:51 -0800
Message-ID: <20120112195951.GB2287@atomide.com>
References: <20120112184256.GA2287@atomide.com>
 <alpine.LFD.2.02.1201121441580.2722@xanadu.home>
 <alpine.LFD.2.02.1201121447270.2722@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1201121447270.2722@xanadu.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Nicolas Pitre <nico@fluxnic.net> [120112 11:15]:
> On Thu, 12 Jan 2012, Nicolas Pitre wrote:
> > 
> > Do you really need that return code?
> > 
> > It was initially hooked to core_initcall() which requires a return code.  
> > Now that you call it directly you could get rid of it.
> 
> s/rid of it/rid of the return code/

Well memblock_alloc could fail there, but omap_barries_init
can be made void as there's already "failed to reserve 4Kbytes"
error there. So let's make it void. Updated patch below.

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 12 Jan 2012 10:28:26 -0800
Subject: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap changes

Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
(Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux
into devel-stable) merged generic ioremap changes.

Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
(ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
added a workaround for omap4.

In order for the errata to work, we now need the following
patch or else we'll get:

kernel BUG at mm/vmalloc.c:1134!

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -132,6 +132,7 @@ void omap3_map_io(void);
 void am33xx_map_io(void);
 void omap4_map_io(void);
 void ti81xx_map_io(void);
+void omap_barriers_init(void);
 
 /**
  * omap_test_timeout - busy-loop, testing a condition
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -307,6 +307,7 @@ void __init omapam33xx_map_common_io(void)
 void __init omap44xx_map_common_io(void)
 {
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
+	omap_barriers_init();
 }
 #endif
 
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -51,20 +51,20 @@ void omap_bus_sync(void)
 	}
 }
 
-static int __init omap_barriers_init(void)
+void __init omap_barriers_init(void)
 {
 	struct map_desc dram_io_desc[1];
 	phys_addr_t paddr;
 	u32 size;
 
 	if (!cpu_is_omap44xx())
-		return -ENODEV;
+		return;
 
 	size = ALIGN(PAGE_SIZE, SZ_1M);
 	paddr = memblock_alloc(size, SZ_1M);
 	if (!paddr) {
 		pr_err("%s: failed to reserve 4 Kbytes\n", __func__);
-		return -ENOMEM;
+		return;
 	}
 	memblock_free(paddr, size);
 	memblock_remove(paddr, size);
@@ -78,10 +78,11 @@ static int __init omap_barriers_init(void)
 
 	pr_info("OMAP4: Map 0x%08llx to 0x%08lx for dram barrier\n",
 		(long long) paddr, dram_io_desc[0].virtual);
-
-	return 0;
 }
-core_initcall(omap_barriers_init);
+#else
+void __init omap_barriers_init(void)
+{
+}
 #endif
 
 void __init gic_init_irq(void)
