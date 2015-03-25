From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: DRA7: Enable Cortex A15 errata 798181
Date: Wed, 25 Mar 2015 17:12:24 -0500
Message-ID: <1427321544-5150-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56851 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbbCYWNC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Mar 2015 18:13:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: praneeth@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

ARM errata 798181 is applicable for DRA7 based devices. So enable
the same in the build. Errata extract and workaround information
is as below.

On Cortex-A15 (r0p0..r3p2) the TLBI*IS/DSB operations are not
adequately shooting down all use of the old entries. The
ARM_ERRATA_798181 option enables the Linux kernel workaround
for this erratum which sends an IPI to the CPUs that are running
the same ASID as the one being invalidated.

Reported-by: Praneeth Kumar Bajjuri <praneeth@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2b8e47788062..1f78709adb05 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -69,6 +69,7 @@ config SOC_DRA7XX
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select IRQ_CROSSBAR
+	select ARM_ERRATA_798181 if SMP
 
 config ARCH_OMAP2PLUS
 	bool
-- 
1.7.9.5

