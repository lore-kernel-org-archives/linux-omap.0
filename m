From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] arm: mm: allow boards to fiddle with meminfo
Date: Sun, 10 Oct 2010 20:40:38 +0300
Message-ID: <1286732440-28644-2-git-send-email-felipe.contreras@gmail.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63650 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0JJRk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 13:40:56 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so1272773bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 10 Oct 2010 10:40:56 -0700 (PDT)
In-Reply-To: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>

So that they can reserve some memory.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/include/asm/mach/arch.h |    2 +-
 arch/arm/mm/init.c               |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 8a0dd18..408e4d5 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -38,7 +38,7 @@ struct machine_desc {
 	void			(*fixup)(struct machine_desc *,
 					 struct tag *, char **,
 					 struct meminfo *);
-	void			(*reserve)(void);/* reserve mem blocks	*/
+	void			(*reserve)(struct meminfo *);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7185b00..4b5c117 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -272,8 +272,6 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 	int i;
 
 	memblock_init();
-	for (i = 0; i < mi->nr_banks; i++)
-		memblock_add(mi->bank[i].start, mi->bank[i].size);
 
 	/* Register the kernel text, kernel data and initrd with memblock. */
 #ifdef CONFIG_XIP_KERNEL
@@ -295,7 +293,10 @@ void __init arm_memblock_init(struct meminfo *mi, struct machine_desc *mdesc)
 
 	/* reserve any platform specific memblock areas */
 	if (mdesc->reserve)
-		mdesc->reserve();
+		mdesc->reserve(mi);
+
+	for (i = 0; i < mi->nr_banks; i++)
+		memblock_add(mi->bank[i].start, mi->bank[i].size);
 
 	memblock_analyze();
 	memblock_dump_all();
-- 
1.7.3.1.2.g7fe2b

