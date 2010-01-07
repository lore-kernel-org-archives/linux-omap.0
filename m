From: Sriramakrishnan <srk@ti.com>
Subject: [PATCH] ARCH OMAP : enable ARCH_HAS_HOLES_MEMORYMODEL for OMAP
Date: Thu,  7 Jan 2010 18:00:08 +0530
Message-ID: <1262867408-9895-1-git-send-email-srk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56415 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab0AGMaO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 07:30:14 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o07CUAgR008588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 06:30:13 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khasim@ti.com, nsekhar@ti.com, Sriram <srk@ti.com>

From: Sriram <srk@ti.com>

OMAP platforms(like OMAP3530) include DSP or other co-processors
for media acceleration. when carving out memory for the
accelerators we can end up creating a hole in the memory map
of sort:
<kernel memory><hole(memory for accelerator)><kernel memory>

To handle such a memory configuration ARCH_HAS_HOLES_MEMORYMODEL
has to be enabled. For further information refer discussion at:
http://www.mail-archive.com/linux-omap@vger.kernl.org/msg15262.html.

Signed-off-by: Sriramakrishnan <srk@ti.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5e0bcc5..88f628b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -699,6 +699,7 @@ config ARCH_OMAP
 	select ARCH_HAS_CPUFREQ
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
+	select ARCH_HAS_HOLES_MEMORYMODEL
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
-- 
1.6.2.4

