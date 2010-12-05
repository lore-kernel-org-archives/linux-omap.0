From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 2/2] ARM: move high-usage mostly read variables in setup.c to __read_mostly
Date: Sun, 05 Dec 2010 11:43:41 +0000
Message-ID: <E1PPD0H-0004ys-Pu@rmk-PC.arm.linux.org.uk>
References: <20101205114257.GD9138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34649 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab0LELny (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Dec 2010 06:43:54 -0500
In-Reply-To: <20101205114257.GD9138@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 336f14e..8075e59 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -75,9 +75,9 @@ extern void reboot_setup(char *str);
 
 unsigned int processor_id;
 EXPORT_SYMBOL(processor_id);
-unsigned int __machine_arch_type;
+unsigned int __machine_arch_type __read_mostly;
 EXPORT_SYMBOL(__machine_arch_type);
-unsigned int cacheid;
+unsigned int cacheid __read_mostly;
 EXPORT_SYMBOL(cacheid);
 
 unsigned int __atags_pointer __initdata;
@@ -91,24 +91,24 @@ EXPORT_SYMBOL(system_serial_low);
 unsigned int system_serial_high;
 EXPORT_SYMBOL(system_serial_high);
 
-unsigned int elf_hwcap;
+unsigned int elf_hwcap __read_mostly;
 EXPORT_SYMBOL(elf_hwcap);
 
 
 #ifdef MULTI_CPU
-struct processor processor;
+struct processor processor __read_mostly;
 #endif
 #ifdef MULTI_TLB
-struct cpu_tlb_fns cpu_tlb;
+struct cpu_tlb_fns cpu_tlb __read_mostly;
 #endif
 #ifdef MULTI_USER
-struct cpu_user_fns cpu_user;
+struct cpu_user_fns cpu_user __read_mostly;
 #endif
 #ifdef MULTI_CACHE
-struct cpu_cache_fns cpu_cache;
+struct cpu_cache_fns cpu_cache __read_mostly;
 #endif
 #ifdef CONFIG_OUTER_CACHE
-struct outer_cache_fns outer_cache;
+struct outer_cache_fns outer_cache __read_mostly;
 EXPORT_SYMBOL(outer_cache);
 #endif
 
-- 
1.6.2.5

