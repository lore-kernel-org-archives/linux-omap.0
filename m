From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v3 1/2] omap: introduce uart_no_empty_fifo_read feature
Date: Fri, 20 Nov 2009 10:02:35 -0600
Message-ID: <1258732956-18799-2-git-send-email-vikram.pandita@ti.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38735 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079AbZKTQCe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 11:02:34 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKG2eM7008051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 10:02:41 -0600
In-Reply-To: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Interoduce omap feature OMAP3_HAS_UART_NO_EMPTY_FIFO_READ

On omap3630/omap4 an empty fifo read causes a crash

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Ack-by: Menon, Nishanth <nm@ti.com>
---
 arch/arm/mach-omap2/id.c              |    7 +++++++
 arch/arm/plat-omap/include/plat/cpu.h |    2 ++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index f48a4b2..3e266cd 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -176,6 +176,12 @@ void __init omap3_check_features(void)
 	OMAP3_CHECK_FEATURE(status, NEON);
 	OMAP3_CHECK_FEATURE(status, ISP);
 
+	/* On omap3630 and omap4: UART empty rx fifo read aborts */
+	if (cpu_is_omap3630())
+		omap3_features |= OMAP3_HAS_UART_NO_EMPTY_FIFO_READ;
+	if (cpu_is_omap44xx())
+		omap3_features |= OMAP3_HAS_UART_NO_EMPTY_FIFO_READ;
+
 	/*
 	 * TODO: Get additional info (where applicable)
 	 *       e.g. Size of L2 cache.
@@ -316,6 +322,7 @@ void __init omap3_cpuinfo(void)
 	OMAP3_SHOW_FEATURE(sgx);
 	OMAP3_SHOW_FEATURE(neon);
 	OMAP3_SHOW_FEATURE(isp);
+	OMAP3_SHOW_FEATURE(uart_no_empty_fifo_read);
 
 	printk(")\n");
 }
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 2e17890..c32f015 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -497,6 +497,7 @@ extern u32 omap3_features;
 #define OMAP3_HAS_SGX			BIT(2)
 #define OMAP3_HAS_NEON			BIT(3)
 #define OMAP3_HAS_ISP			BIT(4)
+#define OMAP3_HAS_UART_NO_EMPTY_FIFO_READ	BIT(5)
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
 static inline unsigned int omap3_has_ ##feat(void)	\
@@ -509,5 +510,6 @@ OMAP3_HAS_FEATURE(sgx, SGX)
 OMAP3_HAS_FEATURE(iva, IVA)
 OMAP3_HAS_FEATURE(neon, NEON)
 OMAP3_HAS_FEATURE(isp, ISP)
+OMAP3_HAS_FEATURE(uart_no_empty_fifo_read, UART_NO_EMPTY_FIFO_READ)
 
 #endif
-- 
1.6.5.1.69.g36942

