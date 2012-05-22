From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: [PATCH 1/2] ARM: pgtable: add pgprot_writethrough() macro
Date: Tue, 22 May 2012 22:54:03 +0300
Message-ID: <1337716444-30139-2-git-send-email-siarhei.siamashka@gmail.com>
References: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64910 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198Ab2EVTy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 May 2012 15:54:28 -0400
In-Reply-To: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux@arm.linux.org.uk, tomi.valkeinen@ti.com, Siarhei Siamashka <siarhei.siamashka@gmail.com>

Needed for remapping pages with write-through cacheable
attribute. May be useful for framebuffers.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 arch/arm/include/asm/pgtable.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index f66626d..04297fa 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -103,6 +103,9 @@ extern pgprot_t		pgprot_kernel;
 #define pgprot_stronglyordered(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED)
 
+#define pgprot_writethrough(prot) \
+	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_WRITETHROUGH)
+
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 #define pgprot_dmacoherent(prot) \
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE | L_PTE_XN)
-- 
1.7.3.4

