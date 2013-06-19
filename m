From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: OMAP5: Enable Cortex A15 errata 798181
Date: Wed, 19 Jun 2013 15:52:12 -0400
Message-ID: <1371671532-27071-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47921 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935105Ab3FSTwi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 15:52:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

ARM errata 798181 is applicable for OMAP5 based devices. So enable
the same in the build. Errata extract and workaround information
is as below.

On Cortex-A15 (r0p0..r3p2) the TLBI*IS/DSB operations are not
adequately shooting down all use of the old entries. The
ARM_ERRATA_798181 option enables the Linux kernel workaround
for this erratum which sends an IPI to the CPUs that are running
the same ASID as the one being invalidated.

Cc: Tony Lindgren <tony@atomide.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..fbd2b9f 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -112,6 +112,7 @@ config SOC_OMAP5
 	select HAVE_SMP
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
+	select ARM_ERRATA_798181
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
-- 
1.7.9.5

