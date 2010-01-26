From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: Select CPU_32v6K for CPU_V7 only if ARCH_OMAP2 is
	not selected
Date: Tue, 26 Jan 2010 11:37:48 -0800
Message-ID: <20100126193748.15134.4837.stgit@baageli.muru.com>
References: <20100126193311.15134.24078.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63309 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821Ab0AZTh3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 14:37:29 -0500
In-Reply-To: <20100126193311.15134.24078.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise the kernel built with both CPU_V6 and CPU_V7 will not
boot on omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index baf6384..4c2e90d 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -399,7 +399,7 @@ config CPU_V6
 config CPU_32v6K
 	bool "Support ARM V6K processor extensions" if !SMP
 	depends on CPU_V6
-	default y if SMP && !ARCH_MX3
+	default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
 	help
 	  Say Y here if your ARMv6 processor supports the 'K' extension.
 	  This enables the kernel to use some instructions not present
@@ -410,7 +410,7 @@ config CPU_32v6K
 # ARMv7
 config CPU_V7
 	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
-	select CPU_32v6K
+	select CPU_32v6K if !ARCH_OMAP2
 	select CPU_32v7
 	select CPU_ABRT_EV7
 	select CPU_PABRT_V7

