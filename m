From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/2] ARM: implement support for read-mostly sections
Date: Sun, 05 Dec 2010 11:43:21 +0000
Message-ID: <E1PPCzx-0004yo-MJ@rmk-PC.arm.linux.org.uk>
References: <20101205114257.GD9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34650 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab0LELoB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:44:01 -0500
In-Reply-To: <20101205114257.GD9138@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

As our SMP implementation uses MESI protocols.  Grouping together data
which is mostly only read together means that we avoid unnecessary
cache line bouncing when this code shares a cache line with other data.

In other words, cache lines associated with read-mostly data are
expected to spend most of their time in shared state.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/cache.h  |    2 ++
 arch/arm/kernel/vmlinux.lds.S |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
index 9d61220..75fe66b 100644
--- a/arch/arm/include/asm/cache.h
+++ b/arch/arm/include/asm/cache.h
@@ -23,4 +23,6 @@
 #define ARCH_SLAB_MINALIGN 8
 #endif
 
+#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+
 #endif
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index cead889..1581f6d 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -167,6 +167,7 @@ SECTIONS
 
 		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(32)
+		READ_MOSTLY_DATA(32)
 
 		/*
 		 * The exception fixup table (might need resorting at runtime)
-- 
1.6.2.5

