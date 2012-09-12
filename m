From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH V2] ARM: OMAP2+: Round of the carve out memory requested to section_size
Date: Wed, 12 Sep 2012 12:44:13 +0530
Message-ID: <1347434053-11431-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36464 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751883Ab2ILHOY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 03:14:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: r.sricharan@ti.com, santosh.shilimkar@ti.com

memblock_steal tries to reserve physical memory during boot.
When the requested size is not aligned on the section size
then, the remaining memory available for lowmem becomes
unaligned on the section boundary. There is a issue with this,
which is discussed in the thread below.

https://lkml.org/lkml/2012/6/28/112

The final conclusion from the thread seems to
be align the memblock_steal calls on the SECTION boundary.
The issue comes out when LPAE is enabled, where the
section size is 2MB.

Boot tested this on OMAP5 evm with and without LPAE.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 [V2] Corrected the subject and added one more description line.

 arch/arm/mach-omap2/omap-secure.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index d9ae4a5..26edfec 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -61,8 +61,8 @@ int __init omap_secure_ram_reserve_memblock(void)
 {
 	u32 size = OMAP_SECURE_RAM_STORAGE;
 
-	size = ALIGN(size, SZ_1M);
-	omap_secure_memblock_base = arm_memblock_steal(size, SZ_1M);
+	size = ALIGN(size, SECTION_SIZE);
+	omap_secure_memblock_base = arm_memblock_steal(size, SECTION_SIZE);
 
 	return 0;
 }
-- 
1.7.9.5

