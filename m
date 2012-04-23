From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] arm: omap: fix trivial warnings for dspbridge
Date: Mon, 23 Apr 2012 17:32:29 +0300
Message-ID: <1335191549-1047-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:41062 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753018Ab2DWOc7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 10:32:59 -0400
Received: by lahj13 with SMTP id j13so9179851lah.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 07:32:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Jiri Kosina <trivial@kernel.org>, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

arch/arm/plat-omap/devices.c: In function 'omap_dsp_reserve_sdram_memblock':
arch/arm/plat-omap/devices.c:170: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'phys_addr_t'
arch/arm/mach-omap2/dsp.c: In function 'omap_dsp_init':
arch/arm/mach-omap2/dsp.c:60: warning: format '%x' expects type 'unsigned int', but argument 3 has type 'phys_addr_t'
arch/arm/mach-omap2/dsp.c:60: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'phys_addr_t'

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/dsp.c    |    5 +++--
 arch/arm/plat-omap/devices.c |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dsp.c b/arch/arm/mach-omap2/dsp.c
index 74f18f2..3376388 100644
--- a/arch/arm/mach-omap2/dsp.c
+++ b/arch/arm/mach-omap2/dsp.c
@@ -57,8 +57,9 @@ static int __init omap_dsp_init(void)
 
 	if (pdata->phys_mempool_base) {
 		pdata->phys_mempool_size = CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE;
-		pr_info("%s: %x bytes @ %x\n", __func__,
-			pdata->phys_mempool_size, pdata->phys_mempool_base);
+		pr_info("%s: %llx bytes @ %llx\n", __func__,
+			(unsigned long long)pdata->phys_mempool_size,
+			(unsigned long long)pdata->phys_mempool_base);
 	}
 
 	pdev = platform_device_alloc("omap-dsp", -1);
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 60278f4..09b07d2 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -167,8 +167,8 @@ void __init omap_dsp_reserve_sdram_memblock(void)
 
 	paddr = arm_memblock_steal(size, SZ_1M);
 	if (!paddr) {
-		pr_err("%s: failed to reserve %x bytes\n",
-				__func__, size);
+		pr_err("%s: failed to reserve %llx bytes\n",
+				__func__, (unsigned long long)size);
 		return;
 	}
 
-- 
1.7.10

