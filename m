From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: OMAP baseline test results for v3.9-rc1
Date: Thu, 14 Mar 2013 11:29:12 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC281B4@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1303121634080.2723@utopia.booyaka.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, March 12, 2013 10:10 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Subject: OMAP baseline test results for v3.9-rc1
> 
> 
> Here are some basic OMAP test results for Linux v3.9-rc1.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc1/20130312100243/
> 
> 
> Test summary
> ------------
> 
> Build:
>     FAIL ( 4/16): am33xx_only, omap1_defconfig,
This requires some cleanup in Makefile and Kconfig handling,

Either you disable SMP support for non-SMP devices like AM33xx 

OR

Fix the Makefile to resolve the build dependencies (may not be trivial)

OR

Make functions __weak so that build will go through.



I have created below patch, if it is ok with you then I can
Submit patch for the same (build tested with am33xx_only and omap2plus_defconfig).




diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 0a6b9c7..cb0d55d 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -233,9 +233,9 @@ extern void omap_do_wfi(void);
 /* Needed for secondary core boot */
 extern void omap_secondary_startup(void);
 extern void omap_secondary_startup_4460(void);
-extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
-extern void omap_auxcoreboot_addr(u32 cpu_addr);
-extern u32 omap_read_auxcoreboot0(void);
+extern u32 __weak omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
+extern void __weak omap_auxcoreboot_addr(u32 cpu_addr);
+extern u32 __weak omap_read_auxcoreboot0(void);

 extern void omap4_cpu_die(unsigned int cpu);

@@ -249,7 +249,7 @@ extern int omap4_mpuss_init(void);
 extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
 extern int omap4_finish_suspend(unsigned long cpu_state);
 extern void omap4_cpu_resume(void);
-extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
+extern int __weak omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
 extern u32 omap4_mpuss_read_prev_context_state(void);
 #else
 static inline int omap4_enter_lowpower(unsigned int cpu,
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.h b/arch/arm/mach-omap2/omap-wakeupgen.h
index b0fd16f..94f5281 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.h
+++ b/arch/arm/mach-omap2/omap-wakeupgen.h
@@ -33,6 +33,6 @@
 #define OMAP_TIMESTAMPCYCLEHI                  0xc0c

 extern int __init omap_wakeupgen_init(void);
-extern void __iomem *omap_get_wakeupgen_base(void);
-extern int omap_secure_apis_support(void);
+extern void __weak __iomem *omap_get_wakeupgen_base(void);
+extern int __weak omap_secure_apis_support(void);
 #endif



Thanks,
Vaibhav
