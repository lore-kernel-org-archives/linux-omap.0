From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] DSP: Move code to use only one dsp_common.h
Date: Wed, 28 Nov 2007 15:35:24 -0800
Message-ID: <20071128233524.GC11825@atomide.com>
References: <20071128051811.GI11825@atomide.com>
	<20071128.115437.259803666.Hiroshi.DOYU@nokia.com>
	<20071128165745.GK11825@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x4pBfXISqBoDm8sr"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071128165745.GK11825@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [071128 08:59]:
> * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [071128 01:55]:
> > Hi Tony,
> > 
> > From: "ext Tony Lindgren" <tony@atomide.com>
> > Subject: [PATCH 1/2] DSP: Move code to use only one dsp_common.h
> > Date: Tue, 27 Nov 2007 21:18:12 -0800
> > 
> > > Hi all,
> > > 
> > > As discussed earlier, here are the patches to move dspgateway
> > > to under drivers.
> > > 
> > > Hiroshi san & Toshihiro san, can you take a quick look at these
> > > two patches and ack?
> > > 
> > > I've only compile tested on osk and n800. There should not be any
> > > functional changes. Some inline functions I had to export though.
> > 
> > Thank you for the patch, but it doesn't seem to work. I am
> > now investigating....
> 
> Oops, does the DSP get initialized?
> 
> > At least, I'd like to make sure that the code itself works fine at
> > this migration both on N8x0 and OSK.
> 
> Yes that would be great :)

No idea why it would not work, but here's one more clean-up patch in
order to send the MMU framework upstream.

Tony

--x4pBfXISqBoDm8sr
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="dsp-allocation.patch"

>From 870324f3b330e7df6e5391b1c379c029b6c9f5f3 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 28 Nov 2007 15:33:49 -0800
Subject: [PATCH] DSP: Clean up memory allocation return values

Clean up memory allocation return values

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/mmu.c b/arch/arm/mach-omap1/mmu.c
index c7cb4ff..2d05708 100644
--- a/arch/arm/mach-omap1/mmu.c
+++ b/arch/arm/mach-omap1/mmu.c
@@ -32,7 +32,6 @@
 #include <linux/err.h>
 #include "mmu.h"
 #include <asm/tlbflush.h>
-#include <asm/arch/dsp.h>
 #include <asm/arch/dsp_common.h>
 
 static void *dspvect_page;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index a17b5ae..4083cf5 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -28,8 +28,8 @@
 #include <asm/arch/dma.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/irqs.h>
-#include <asm/arch/mcbsp.h>
 #include <asm/arch/dsp_common.h>
+#include <asm/arch/mcbsp.h>
 
 #ifdef CONFIG_MCBSP_DEBUG
 #define DBG(x...)	printk(x)
@@ -197,7 +197,14 @@ static int omap_mcbsp_check(unsigned int id)
 static void omap_mcbsp_dsp_request(void)
 {
 	if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
-		omap_dsp_request_mem();
+		int ret;
+
+		ret = omap_dsp_request_mem();
+		if (ret < 0) {
+			printk(KERN_ERR "Could not get dsp memory: %i\n", ret);
+			return;
+		}
+
 		clk_enable(mcbsp_dsp_ck);
 		clk_enable(mcbsp_api_ck);
 
diff --git a/arch/arm/plat-omap/mmu.c b/arch/arm/plat-omap/mmu.c
index c92afd6..c80d411 100644
--- a/arch/arm/plat-omap/mmu.c
+++ b/arch/arm/plat-omap/mmu.c
@@ -588,9 +588,12 @@ int omap_mmu_load_tlb_entry(struct omap_mmu *mmu,
 {
 	struct omap_mmu_tlb_lock lock;
 	struct cam_ram_regset *cr;
+	int ret;
 
 	clk_enable(mmu->clk);
-	omap_dsp_request_mem();
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
 
 	omap_mmu_get_tlb_lock(mmu, &lock);
 	for (lock.victim = 0; lock.victim < lock.base; lock.victim++) {
@@ -624,6 +627,7 @@ found_victim:
 	omap_mmu_set_tlb_lock(mmu, &lock);
 
 	omap_dsp_release_mem();
+out:
 	clk_disable(mmu->clk);
 	return 0;
 }
@@ -638,11 +642,13 @@ omap_mmu_cam_va(struct omap_mmu *mmu, struct cam_ram_regset *cr)
 int omap_mmu_clear_tlb_entry(struct omap_mmu *mmu, unsigned long vadr)
 {
 	struct omap_mmu_tlb_lock lock;
-	int i;
+	int i, ret = 0;
 	int max_valid = 0;
 
 	clk_enable(mmu->clk);
-	omap_dsp_request_mem();
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
 
 	omap_mmu_get_tlb_lock(mmu, &lock);
 	for (i = 0; i < lock.base; i++) {
@@ -666,23 +672,28 @@ int omap_mmu_clear_tlb_entry(struct omap_mmu *mmu, unsigned long vadr)
 	omap_mmu_set_tlb_lock(mmu, &lock);
 
 	omap_dsp_release_mem();
+out:
 	clk_disable(mmu->clk);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(omap_mmu_clear_tlb_entry);
 
 static void omap_mmu_gflush(struct omap_mmu *mmu)
 {
 	struct omap_mmu_tlb_lock lock;
+	int ret;
 
 	clk_enable(mmu->clk);
-	omap_dsp_request_mem();
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
 
 	omap_mmu_write_reg(mmu, 0x1, OMAP_MMU_GFLUSH);
 	lock.base = lock.victim = mmu->nr_exmap_preserved;
 	omap_mmu_set_tlb_lock(mmu, &lock);
 
 	omap_dsp_release_mem();
+out:
 	clk_disable(mmu->clk);
 }
 
@@ -1073,7 +1084,10 @@ static int omap_mmu_init(struct omap_mmu *mmu)
 	int ret = 0;
 
 	clk_enable(mmu->clk);
-	omap_dsp_request_mem();
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
+
 	down_write(&mmu->exmap_sem);
 
 	ret = request_irq(mmu->irq, omap_mmu_interrupt, IRQF_DISABLED,
@@ -1093,9 +1107,10 @@ static int omap_mmu_init(struct omap_mmu *mmu)
 
 	if (unlikely(mmu->ops->startup))
 		ret = mmu->ops->startup(mmu);
- fail:
+fail:
 	up_write(&mmu->exmap_sem);
 	omap_dsp_release_mem();
+out:
 	clk_disable(mmu->clk);
 
 	return ret;
@@ -1309,15 +1324,18 @@ static ssize_t omap_mmu_show(struct device *dev, struct device_attribute *attr,
 {
 	struct omap_mmu *mmu = dev_get_drvdata(dev);
 	struct omap_mmu_tlb_lock tlb_lock;
-	int ret = -EIO;
+	int ret;
 
 	clk_enable(mmu->clk);
-	omap_dsp_request_mem();
+	ret = omap_dsp_request_mem();
+	if (ret < 0)
+		goto out;
 
 	down_read(&mmu->exmap_sem);
 
 	omap_mmu_get_tlb_lock(mmu, &tlb_lock);
 
+	ret = -EIO;
 	if (likely(mmu->ops->show))
 		ret = mmu->ops->show(mmu, buf, &tlb_lock);
 
@@ -1326,6 +1344,7 @@ static ssize_t omap_mmu_show(struct device *dev, struct device_attribute *attr,
 
 	up_read(&mmu->exmap_sem);
 	omap_dsp_release_mem();
+out:
 	clk_disable(mmu->clk);
 
 	return ret;
diff --git a/include/asm-arm/arch-omap/dsp_common.h b/include/asm-arm/arch-omap/dsp_common.h
index a11deed..c52b6c6 100644
--- a/include/asm-arm/arch-omap/dsp_common.h
+++ b/include/asm-arm/arch-omap/dsp_common.h
@@ -66,8 +66,11 @@ extern void omap_dsp_release_mpui(void);
 extern int omap_dsp_request_mem(void);
 extern int omap_dsp_release_mem(void);
 #elif defined(CONFIG_ARCH_OMAP2)
-#define omap_dsp_request_mem()	do { } while (0)
-#define omap_dsp_release_mem()	do { } while (0)
+static inline int omap_dsp_request_mem(void)
+{
+	return 0;
+}
+#define omap_dsp_release_mem()	do {} while (0)
 #endif
 
 #endif /* ASM_ARCH_DSP_COMMON_H */

--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--x4pBfXISqBoDm8sr--
