From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Sat, 06 Sep 2008 03:56:35 +0300 (EEST)
Message-ID: <20080906.035635.186133813.Hiroshi.DOYU@nokia.com>
References: <1220420188-22518-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<20080905172133.GM24202@atomide.com>
	<20080905224530.GE17156@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64454 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYIFA5Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 20:57:24 -0400
In-Reply-To: <20080905224530.GE17156@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi Russell,

From: "ext Russell King - ARM Linux" <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] Use pmd_table() MACRO for unmap_area_sections()
Date: Fri, 5 Sep 2008 23:45:30 +0100

> On Fri, Sep 05, 2008 at 10:21:33AM -0700, Tony Lindgren wrote:
> > * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080902 22:37]:
> > > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > 
> > This should be sent to linux-arm-kernel list.
> 
> Except, pmd_table() is an omap thing at the moment, so isn't relevant
> there.

Right.
Would it be possible to have "pmd_table()" definition "in pgtable.h"?

>From 0374c2c3e873a43e26cb439b891b9e319b90f83c Mon Sep 17 00:00:00 2001
From: ext Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Wed, 3 Sep 2008 08:36:28 +0300
Subject: [PATCH 1/1] Add pmd_table() MACRO

Use pmd_table() MACRO for unmap_area_sections()

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/include/asm/pgtable.h |    1 +
 arch/arm/mm/ioremap.c          |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 8e21ef1..acfac1a 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -292,6 +292,7 @@ static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define pmd_present(pmd)	(pmd_val(pmd))
 #define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+#define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index b81dbf9..7ab4301 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -161,7 +161,7 @@ static void unmap_area_sections(unsigned long virt, unsigned long size)
 			/*
 			 * Free the page table, if there was one.
 			 */
-			if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE)
+			if (pmd_table(pmd))
 				pte_free_kernel(&init_mm, pmd_page_vaddr(pmd));
 		}
 
-- 
1.5.5.1.357.g1af8b

