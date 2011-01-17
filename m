From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 09/14] ARM: v6k: select generic atomic64 code according to V6 variants
Date: Mon, 17 Jan 2011 19:24:03 +0000
Message-ID: <E1PeugN-0003Sp-0J@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51094 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1AQTYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:24:16 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

If CONFIG_CPU_V6 is enabled, avoid using the double-word exclusive
instructions in the kernel's atomic implementations as these are not
supported.  Fall back to the generic spinlock code instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 95ba92f..283d7b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,7 +7,7 @@ config ARM
 	select HAVE_MEMBLOCK
 	select RTC_LIB
 	select SYS_SUPPORTS_APM_EMULATION
-	select GENERIC_ATOMIC64 if (!CPU_32v6K || !AEABI)
+	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_ARCH_KGDB
 	select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)
-- 
1.6.2.5

