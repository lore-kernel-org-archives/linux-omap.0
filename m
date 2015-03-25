From: Praneeth Bajjuri <praneeth@ti.com>
Subject: [PATCH] ARM: DRA7: Enable Cortex A15 errata 798181
Date: Wed, 25 Mar 2015 18:25:09 -0500
Message-ID: <1427325909-7014-1-git-send-email-praneeth@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
List-Id: linux-omap@vger.kernel.org

ARM errata 798181 is applicable for OMAP5/DRA7 based devices. So enable
the same in the build.

DRA7xx is based on Cortex-A15 r2p2 revision.

ARM Errata extract and workaround information is as below.

On Cortex-A15 (r0p0..r3p2) the TLBI*IS/DSB operations are not
adequately shooting down all use of the old entries. The
ARM_ERRATA_798181 option enables the Linux kernel workaround
for this erratum which sends an IPI to the CPUs that are running
the same ASID as the one being invalidated.

Signed-off-by: Praneeth Bajjuri <praneeth@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index c7d8d86..3e4b4ae 100644
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
