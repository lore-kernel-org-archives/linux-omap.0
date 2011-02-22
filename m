From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ARM: fix build failure
Date: Tue, 22 Feb 2011 21:26:42 +0100
Message-ID: <1298406402-31572-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110222201842.GB31275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42590 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab1BVU1B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 15:27:01 -0500
In-Reply-To: <20110222201842.GB31275@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Commit

	06824ba (ARM: tlb: delay page freeing for SMP and ARMv7 CPUs)

introduced a build failure for builds with CONFIG_SWAP=3Dn:

	In file included from arch/arm/mm/init.c:27:
	arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
	arch/arm/include/asm/tlb.h:101: error: implicit declaration of functio=
n 'release_pages'
	arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
	arch/arm/include/asm/tlb.h:165: error: implicit declaration of functio=
n 'page_cache_release'

=46ix that by #including <linux/pagemap.h> in <asm/pgalloc.h> as it's d=
one
by x86.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/pgalloc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgal=
loc.h
index 9763be0..22de005 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -10,6 +10,8 @@
 #ifndef _ASMARM_PGALLOC_H
 #define _ASMARM_PGALLOC_H
=20
+#include <linux/pagemap.h>
+
 #include <asm/domain.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/processor.h>
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
