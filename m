From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
 definitions
Date: Wed, 13 Jan 2010 14:18:28 +0200 (EET)
Message-ID: <20100113.141828.59662176.Hiroshi.DOYU@nokia.com>
References: <1263195995-23244-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<A24693684029E5489D1D202277BE8944513DBE43@dlee02.ent.ti.com>
	<20100113.085252.226801492.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Jan_13_14_18_28_2010_630)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29815 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab0AMMSs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 07:18:48 -0500
In-Reply-To: <20100113.085252.226801492.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: hnagalla@ti.com, saaguirre@ti.com

----Next_Part(Wed_Jan_13_14_18_28_2010_630)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/3] omap iommu: cleanup iommu page address mask and definitions
Date: Wed, 13 Jan 2010 08:52:52 +0200 (EET)

> Hi Sergio,
> 
> From: "ext Aguirre, Sergio" <saaguirre@ti.com>
> Subject: RE: [PATCH 1/3] omap iommu: cleanup iommu page address mask and definitions
> Date: Mon, 11 Jan 2010 22:53:16 +0100
> 
>> Hi Hiroshi,
>> 
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> > owner@vger.kernel.org] On Behalf Of Hiroshi DOYU
>> > Sent: Monday, January 11, 2010 1:47 AM
>> > To: linux-omap@vger.kernel.org
>> > Cc: Nagalla, Hari; Hiroshi DOYU
>> > Subject: [PATCH 1/3] omap iommu: cleanup iommu page address mask and
>> > definitions
>> > 
>> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> 
>> Maybe a small description would help here...
>> 
>> Are you just reshuffling defines, or are you also adding new ones?
>> 
>> Is this just a cleanup or is it fixing a hidden bug?
> 
> It's just a cleanup, but added a few macros here, This patch is
> necessary for the proceeding patches which are the ones to fix a bug.
> 
> I'll add some description on them.

Here's the updates.

----Next_Part(Wed_Jan_13_14_18_28_2010_630)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-omap-iommu-cleanup-iommu-page-address-mask-and-defi.patch"

>From 73251730aff0c9d53f0100a2166501eee370578f Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 8 Jan 2010 18:49:00 +0200
Subject: [PATCH 1/3] omap iommu: cleanup iommu page address mask and definitions

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This is just a cleanup, but adds a few macros here, which can be used
in the proceeding patches.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iopgtable.h |   50 +++++++++++++++++++++++++++++++--------
 1 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-omap/iopgtable.h b/arch/arm/plat-omap/iopgtable.h
index 37dac43..ab23b6a 100644
--- a/arch/arm/plat-omap/iopgtable.h
+++ b/arch/arm/plat-omap/iopgtable.h
@@ -1,7 +1,7 @@
 /*
  * omap iommu: pagetable definitions
  *
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
@@ -13,26 +13,52 @@
 #ifndef __PLAT_OMAP_IOMMU_H
 #define __PLAT_OMAP_IOMMU_H
 
+/*
+ * "L2 table" address mask and size definitions.
+ */
 #define IOPGD_SHIFT		20
-#define IOPGD_SIZE		(1 << IOPGD_SHIFT)
+#define IOPGD_SIZE		(1UL << IOPGD_SHIFT)
 #define IOPGD_MASK		(~(IOPGD_SIZE - 1))
-#define IOSECTION_MASK		IOPGD_MASK
-#define PTRS_PER_IOPGD		(1 << (32 - IOPGD_SHIFT))
-#define IOPGD_TABLE_SIZE	(PTRS_PER_IOPGD * sizeof(u32))
 
-#define IOSUPER_SIZE		(IOPGD_SIZE << 4)
+/*
+ * "section" address mask and size definitions.
+ */
+#define IOSECTION_SHIFT		20
+#define IOSECTION_SIZE		(1UL << IOSECTION_SHIFT)
+#define IOSECTION_MASK		(~(IOSECTION_SIZE - 1))
+
+/*
+ * "supersection" address mask and size definitions.
+ */
+#define IOSUPER_SHIFT		24
+#define IOSUPER_SIZE		(1UL << IOSUPER_SHIFT)
 #define IOSUPER_MASK		(~(IOSUPER_SIZE - 1))
 
+#define PTRS_PER_IOPGD		(1UL << (32 - IOPGD_SHIFT))
+#define IOPGD_TABLE_SIZE	(PTRS_PER_IOPGD * sizeof(u32))
+
+/*
+ * "small page" address mask and size definitions.
+ */
 #define IOPTE_SHIFT		12
-#define IOPTE_SIZE		(1 << IOPTE_SHIFT)
+#define IOPTE_SIZE		(1UL << IOPTE_SHIFT)
 #define IOPTE_MASK		(~(IOPTE_SIZE - 1))
-#define IOPAGE_MASK		IOPTE_MASK
-#define PTRS_PER_IOPTE		(1 << (IOPGD_SHIFT - IOPTE_SHIFT))
-#define IOPTE_TABLE_SIZE	(PTRS_PER_IOPTE * sizeof(u32))
 
-#define IOLARGE_SIZE		(IOPTE_SIZE << 4)
+/*
+ * "large page" address mask and size definitions.
+ */
+#define IOLARGE_SHIFT		16
+#define IOLARGE_SIZE		(1UL << IOLARGE_SHIFT)
 #define IOLARGE_MASK		(~(IOLARGE_SIZE - 1))
 
+#define PTRS_PER_IOPTE		(1UL << (IOPGD_SHIFT - IOPTE_SHIFT))
+#define IOPTE_TABLE_SIZE	(PTRS_PER_IOPTE * sizeof(u32))
+
+#define IOPAGE_MASK		IOPTE_MASK
+
+/*
+ * some descriptor attributes.
+ */
 #define IOPGD_TABLE		(1 << 0)
 #define IOPGD_SECTION		(2 << 0)
 #define IOPGD_SUPER		(1 << 18 | 2 << 0)
@@ -40,12 +66,14 @@
 #define IOPTE_SMALL		(2 << 0)
 #define IOPTE_LARGE		(1 << 0)
 
+/* to find an entry in a page-table-directory */
 #define iopgd_index(da)		(((da) >> IOPGD_SHIFT) & (PTRS_PER_IOPGD - 1))
 #define iopgd_offset(obj, da)	((obj)->iopgd + iopgd_index(da))
 
 #define iopte_paddr(iopgd)	(*iopgd & ~((1 << 10) - 1))
 #define iopte_vaddr(iopgd)	((u32 *)phys_to_virt(iopte_paddr(iopgd)))
 
+/* to find an entry in the second-level page table. */
 #define iopte_index(da)		(((da) >> IOPTE_SHIFT) & (PTRS_PER_IOPTE - 1))
 #define iopte_offset(iopgd, da)	(iopte_vaddr(iopgd) + iopte_index(da))
 
-- 
1.6.0.4


----Next_Part(Wed_Jan_13_14_18_28_2010_630)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-omap-iommu-fix-incorrect-address-for-large-page-1st.patch"

>From a3db27c46ec02b48d4fb3bac8b37be652a1d392c Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 8 Jan 2010 18:52:05 +0200
Subject: [PATCH 2/3] omap iommu: fix incorrect address for largepage 1st entry

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There was a potential risk that the following "memset" could override
its range if a given address was not the 1st entry of a
largepage. This is not the case for "iovmm".

Reported-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm/plat-omap/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index c0ff1e3..ccf25b3 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -1,7 +1,7 @@
 /*
  * omap iommu: tlb and pagetable primitives
  *
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
  *		Paul Mundt and Toshihiro Kobayashi
@@ -646,7 +646,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 		if (*iopte & IOPTE_LARGE) {
 			nent *= 16;
 			/* rewind to the 1st entry */
-			iopte = (u32 *)((u32)iopte & IOLARGE_MASK);
+			iopte = iopte_offset(iopgd, (da & IOLARGE_MASK));
 		}
 		bytes *= nent;
 		memset(iopte, 0, nent * sizeof(*iopte));
-- 
1.6.0.4


----Next_Part(Wed_Jan_13_14_18_28_2010_630)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003-omap-iommu-fix-incorrect-address-for-supersection-1.patch"

>From 0f299c722404f367733da07125b6e4b6c722432b Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 8 Jan 2010 18:54:25 +0200
Subject: [PATCH 3/3] omap iommu: fix incorrect address for supersection 1st entry

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There was a potential risk that the following "memset" could override
its range if a given address was not the 1st entry of a
supersection. This is not the case for "iovmm".

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm/plat-omap/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index ccf25b3..ce0072a 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -667,7 +667,7 @@ static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 		if ((*iopgd & IOPGD_SUPER) == IOPGD_SUPER) {
 			nent *= 16;
 			/* rewind to the 1st entry */
-			iopgd = (u32 *)((u32)iopgd & IOSUPER_MASK);
+			iopgd = iopgd_offset(obj, (da & IOSUPER_MASK));
 		}
 		bytes *= nent;
 	}
-- 
1.6.0.4


----Next_Part(Wed_Jan_13_14_18_28_2010_630)----
