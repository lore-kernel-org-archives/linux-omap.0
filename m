From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 14/14] ARM: v6k: only allow SMP if we have v6k or v7 CPU
Date: Mon, 17 Jan 2011 19:25:45 +0000
Message-ID: <E1Peui1-0003T9-6Q@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51103 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab1AQT0J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:26:09 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

SMP extensions are only supported on ARMv6k or ARMv7 architectures, so
only offer the option if we're building for such an architecture.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 283d7b9..ba304a3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1250,6 +1250,7 @@ source "kernel/time/Kconfig"
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on CPU_V6K || CPU_V7
 	depends on GENERIC_CLOCKEVENTS
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
-- 
1.6.2.5

