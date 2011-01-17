From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 10/14] ARM: v6k: select TLS register code according to V6 variants
Date: Mon, 17 Jan 2011 19:24:23 +0000
Message-ID: <E1Peugh-0003St-DY@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59813 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316Ab1AQT0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:26:36 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

If CONFIG_CPU_V6 is enabled, we may or may not have the TLS register.
Use the conditional code which copes with this variability.  Otherwise,
if CONFIG_CPU_32v6K is set, we know we have the TLS register on all
supported CPUs, so use it unconditionally.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/tls.h |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index e71d6ff..60843eb 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -28,15 +28,14 @@
 #define tls_emu		1
 #define has_tls_reg		1
 #define set_tls		set_tls_none
-#elif __LINUX_ARM_ARCH__ >= 7 ||					\
-	(__LINUX_ARM_ARCH__ == 6 && defined(CONFIG_CPU_32v6K))
-#define tls_emu		0
-#define has_tls_reg		1
-#define set_tls		set_tls_v6k
-#elif __LINUX_ARM_ARCH__ == 6
+#elif defined(CONFIG_CPU_V6)
 #define tls_emu		0
 #define has_tls_reg		(elf_hwcap & HWCAP_TLS)
 #define set_tls		set_tls_v6
+#elif defined(CONFIG_CPU_32v6K)
+#define tls_emu		0
+#define has_tls_reg		1
+#define set_tls		set_tls_v6k
 #else
 #define tls_emu		0
 #define has_tls_reg		0
-- 
1.6.2.5

