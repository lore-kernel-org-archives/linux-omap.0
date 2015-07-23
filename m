From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/3] ARM: errata 430973: move !ARCH_MULTIPLATFORM to Kconfig
Date: Thu, 23 Jul 2015 02:48:03 +0200
Message-ID: <1437612483-30160-4-git-send-email-sre@kernel.org>
References: <1437612483-30160-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437612483-30160-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Having the !ARCH_MULTIPLATFORM dependency in the Kconfig file results
in one option less to think about when configuring the kernel.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/Kconfig      | 1 +
 arch/arm/mm/proc-v7.S | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0e4929b..f0e2d92 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1066,6 +1066,7 @@ config ARM_ERRATA_411920
 config ARM_ERRATA_430973
 	bool "ARM errata: Stale prediction on replaced interworking branch"
 	depends on CPU_V7
+	depends on !ARCH_MULTIPLATFORM
 	help
 	  This option enables the workaround for the 430973 Cortex-A8
 	  r1p* erratum. If a code sequence containing an ARM/Thumb
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 0716bbe..494e844 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -294,7 +294,7 @@ __v7_ca17mp_setup:
  *  r9: MIDR
  */
 __ca8_errata:
-#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)
+#ifdef CONFIG_ARM_ERRATA_430973
 	teq	r3, #0x00100000			@ only present in r1p*
 	mrceq	p15, 0, r0, c1, c0, 1		@ read aux control register
 	orreq	r0, r0, #(1 << 6)		@ set IBE to 1
-- 
2.1.4
