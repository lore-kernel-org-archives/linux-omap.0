From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [GIT PULL] omap iommu fixes for v3.0-rc
Date: Fri, 1 Jul 2011 09:52:00 +0300
Message-ID: <BANLkTi=vd2TE6JjueGmY=ydRQRygo8-Q1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57432 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab1GAGwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 02:52:21 -0400
Received: by wyg8 with SMTP id 8so1990025wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 23:52:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Tony,

Please pull from:

git://github.com/ohadbc/omap-iommu.git for-tony

To receive trivial iommu/iovmm fixes (iommu clk name fix, pte fix and
a fix for iovmm's erroneous
usage of sg_dma_len as reported by Russell).

All three patches were submitted to linux-omap and linux-arm-kernel for review,
and are also attached below for convenience.

Thanks,
Ohad.

The following changes since commit c017d0d1351f916c0ced3f358afc491fdcf490b4:

  Merge branch 'kvm-updates/3.0' of
git://git.kernel.org/pub/scm/virt/kvm/kvm (2011-06-29 11:07:20 -0700)

are available in the git repository at:

  git://github.com/ohadbc/omap-iommu.git for-tony

Ohad Ben-Cohen (2):
      OMAP4: iommu: fix clock name
      omap: iovmm: s/sg_dma_len(sg)/sg->length/

Suman Anna (1):
      omap: iommu: fix pte attributes for super section

 arch/arm/mach-omap2/iommu2.c     |    4 ++--
 arch/arm/mach-omap2/omap-iommu.c |    2 +-
 arch/arm/plat-omap/iovmm.c       |    6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index adb083e..f286012 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -225,8 +225,8 @@ static u32 omap2_get_pte_attr(struct iotlb_entry *e)
 	attr = e->mixed << 5;
 	attr |= e->endian;
 	attr |= e->elsz >> 3;
-	attr <<= ((e->pgsz & MMU_CAM_PGSZ_4K) ? 0 : 6);
-
+	attr <<= (((e->pgsz == MMU_CAM_PGSZ_4K) ||
+			(e->pgsz == MMU_CAM_PGSZ_64K)) ? 0 : 6);
 	return attr;
 }

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 3fc5dc7..e61fead 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -67,7 +67,7 @@ static struct iommu_device omap4_devices[] = {
 		.pdata = {
 			.name = "ducati",
 			.nr_tlb_entries = 32,
-			.clk_name = "ducati_ick",
+			.clk_name = "ipu_fck",
 			.da_start = 0x0,
 			.da_end = 0xFFFFF000,
 		},
diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 83a37c5..c60737c 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -72,7 +72,7 @@ static size_t sgtable_len(const struct sg_table *sgt)
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		size_t bytes;

-		bytes = sg_dma_len(sg);
+		bytes = sg->length;

 		if (!iopgsz_ok(bytes)) {
 			pr_err("%s: sg[%d] not iommu pagesize(%x)\n",
@@ -198,7 +198,7 @@ static void *vmap_sg(const struct sg_table *sgt)
 		int err;

 		pa = sg_phys(sg);
-		bytes = sg_dma_len(sg);
+		bytes = sg->length;

 		BUG_ON(bytes != PAGE_SIZE);

@@ -476,7 +476,7 @@ static int map_iovm_area(struct iommu *obj, struct
iovm_struct *new,
 		struct iotlb_entry e;

 		pa = sg_phys(sg);
-		bytes = sg_dma_len(sg);
+		bytes = sg->length;

 		flags &= ~IOVMF_PGSZ_MASK;
 		pgsz = bytes_to_iopgsz(bytes);
