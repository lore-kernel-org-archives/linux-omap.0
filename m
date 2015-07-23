From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/3] ARM: update errata 430973 documentation
Date: Thu, 23 Jul 2015 02:48:02 +0200
Message-ID: <1437612483-30160-3-git-send-email-sre@kernel.org>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437612483-30160-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

The Errata 430973 workaround config option only enables the
IBE bit, which should be done by the bootloader if possible.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c50210..0e4929b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1078,6 +1078,10 @@ config ARM_ERRATA_430973
 	  and also flushes the branch target cache at every context switch.
 	  Note that setting specific bits in the ACTLR register may not be
 	  available in non-secure mode.
+	  Instead of enabling this option, it is recommended to enable the
+	  workaround by setting the IBE bit from the bootloader, since the
+	  BTB/BTAC operations are always executed for context switches on
+	  Cortex-A8.
 
 config ARM_ERRATA_458693
 	bool "ARM errata: Processor deadlock when a false hazard is created"
-- 
2.1.4
