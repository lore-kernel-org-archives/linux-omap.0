From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH] ARM: OMAP2PLUS: Enable HIGHMEM
Date: Wed, 2 May 2012 13:28:47 -0500
Message-ID: <1335983327-14561-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60871 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755871Ab2EBS2z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 14:28:55 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q42ISsZf016950
	for <linux-omap@vger.kernel.org>; Wed, 2 May 2012 13:28:54 -0500
Received: from DFLE70.ent.ti.com (dfle70.ent.ti.com [128.247.5.40])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q42ISsw3005315
	for <linux-omap@vger.kernel.org>; Wed, 2 May 2012 13:28:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

HIGMEM support in kernel is quite mature now and we have boards
like ZOOM, PANDA, SDP where 1 GB memories are installed. With
HIGHMEM disabled not all of the 1GB of RAM (only ~700MB) can be
accessed. Hence, enable HIGMEM to make use of the entire memory.

On the boards which doesn't have more than 768 MB memory, all
the memory is directly mapped in "lowmem" and highmem isn't
exercised. Hence, there should be no impact by enabling HIGHMEM
for boards that do not need it.

Tested on OMAP4460 Panda-ES.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Tested-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8141b76..964ee67 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select MENELAUS if ARCH_OMAP2
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
+	select HIGHMEM
 	help
 	  Compile a kernel suitable for booting most boards
 
-- 
1.7.5.4

