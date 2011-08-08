From: "Maxin B. John" <maxin.john@gmail.com>
Subject: [PATCH] arch:arm:plat-omap:iovmm: remove unused variable 'va'
Date: Mon, 8 Aug 2011 13:15:46 +0300
Message-ID: <20110808101546.GA25572@maxin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The pointer "va" returned from "phys_to_virt(pa)" is never used in
"sgtable_fill_kmalloc()".So,it is safe to remove this set-but-unused variable.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index c60737c..79e7fed 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -423,9 +423,6 @@ static void sgtable_fill_kmalloc(struct sg_table *sgt, u32 pa, u32 da,
 {
 	unsigned int i;
 	struct scatterlist *sg;
-	void *va;
-
-	va = phys_to_virt(pa);
 
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		unsigned bytes;
