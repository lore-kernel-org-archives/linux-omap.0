From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] cpufreq: OMAP: fix build errors: depends on ARCH_OMAP2PLUS
Date: Fri, 13 Apr 2012 13:32:30 -0700
Message-ID: <1334349150-917-1-git-send-email-khilman@ti.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

The OMAP driver needs a 'depends on ARCH_OMAP2PLUS' since it only
builds for OMAP2+ platforms.

This 'depends on' was in the original patch from Russell King, but was
erroneously removed by me when making this option user-selectable in
commit b09db45c (cpufreq: OMAP driver depends CPUfreq tables.)  This
patch remedies that.

Apologies to Russell King for breaking his originally working patch.

Also, thanks to Grazvydas Ignotas for reporting the same problem.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Linus, can you apply this for v3.4-rc?  I haven't got a response from
the CPUfreq maintainers after several weeks and a couple tries, so
hopefully you can take this simple fix.   Thanks.

 drivers/cpufreq/Kconfig.arm |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 82f1aa9..555a57b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -4,6 +4,7 @@
 
 config ARM_OMAP2PLUS_CPUFREQ
 	bool "TI OMAP2+"
+	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 	select CPU_FREQ_TABLE
 
-- 
1.7.9.2

