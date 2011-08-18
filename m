From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 5/7] omap: iovmm: remove unused functionality
Date: Thu, 18 Aug 2011 13:19:28 +0300 (EEST)
Message-ID: <20110818.131928.751866371806910622.Hiroshi.DOYU@nokia.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-6-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1313622608-30397-6-git-send-email-ohad@wizery.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ohad@wizery.com
Cc: arnd@arndb.de, tony@atomide.com, Joerg.Roedel@amd.com, iommu@lists.linux-foundation.org, laurent.pinchart@ideasonboard.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

From: ext Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 5/7] omap: iovmm: remove unused functionality
Date: Thu, 18 Aug 2011 02:10:06 +0300

> Remove unused functionality from OMAP's iovmm module.
> 
> The intention is to eventually completely replace iovmm with the
> generic DMA-API, so new code that'd need this iovmm functionality
> will have to extend the DMA-API instead.

Maybe it's better to remove the comments explaining unnecessary
functions too. Now the function comparison table doesn't make sense....

>From c42c675f62241099a10e4610640e6a60fb111f1f Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Thu, 18 Aug 2011 13:13:53 +0300
Subject: [PATCH 1/1] omap: iommu: remove obsolete comments

Remove ones referring to non-existing functions.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/iommu/omap-iovmm.c |   36 +-----------------------------------
 1 files changed, 1 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index 81b713a..2db655c 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -1,7 +1,7 @@
 /*
  * omap iommu: simple virtual address space management
  *
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2009, 2011 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
@@ -25,40 +25,6 @@
 
 #include <plat/iopgtable.h>
 
-/*
- * A device driver needs to create address mappings between:
- *
- * - iommu/device address
- * - physical address
- * - mpu virtual address
- *
- * There are 4 possible patterns for them:
- *
- *    |iova/			  mapping		iommu_		page
- *    | da	pa	va	(d)-(p)-(v)		function	type
- *  ---------------------------------------------------------------------------
- *  1 | c	c	c	 1 - 1 - 1	  _kmap() / _kunmap()	s
- *  2 | c	c,a	c	 1 - 1 - 1	_kmalloc()/ _kfree()	s
- *  3 | c	d	c	 1 - n - 1	  _vmap() / _vunmap()	s
- *  4 | c	d,a	c	 1 - n - 1	_vmalloc()/ _vfree()	n*
- *
- *
- *	'iova':	device iommu virtual address
- *	'da':	alias of 'iova'
- *	'pa':	physical address
- *	'va':	mpu virtual address
- *
- *	'c':	contiguous memory area
- *	'd':	discontiguous memory area
- *	'a':	anonymous memory allocation
- *	'()':	optional feature
- *
- *	'n':	a normal page(4KB) size is used.
- *	's':	multiple iommu superpage(16MB, 1MB, 64KB, 4KB) size is used.
- *
- *	'*':	not yet, but feasible.
- */
-
 static struct kmem_cache *iovm_area_cachep;
 
 /* return total bytes of sg buffers */
-- 
1.7.1
