From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Avoid discarding sections that might have
	SMP_ON_UP fixups
Date: Fri, 11 Feb 2011 16:32:47 +0000
Message-ID: <20110211163247.GB31529@n2100.arm.linux.org.uk>
References: <AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com> <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com> <20110210144617.GD3652@n2100.arm.linux.org.uk> <AANLkTiks_8hXd=7cKN0jNw=1QGcb=5ZyFu1sEFc0G=Px@mail.gmail.com> <20110210191125.GA12582@n2100.arm.linux.org.uk> <AANLkTim0RRw-xHQYTdHLCXCS_GXkaCiW8y9Fz=jMmwPa@mail.gmail.com> <20110211101345.GA23785@n2100.arm.linux.org.uk> <AANLkTikFkZH6KK_KUgXaaKyQM6eZOh-ki3xdtS2fk8zN@mail.gmail.com> <20110211160500.GA31529@n2100.arm.linux.org.uk> <AANLkTik1T_RDb_MVw9WWY_BX75isoGq2k1L+uVCN-bbq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34418 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757422Ab1BKQcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 11:32:55 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTik1T_RDb_MVw9WWY_BX75isoGq2k1L+uVCN-bbq@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 04:17:48PM +0000, Dave Martin wrote:
> Yep -- I'm still applying my original patch to work around that, but
> it sounds like I need to tidy that up.  Can you elaborate on what you
> meant by defining a "KEEP_EXIT" macro to handle this?

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 45b5651..343d29f 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -21,6 +21,12 @@
 #define ARM_CPU_KEEP(x)
 #endif
 
+#if defined(CONFIG_SMP_ON_UP) && !defined(CONFIG_DEBUG_SPINLOCK)
+#define ARM_EXIT_KEEP(x)	x
+#else
+#define ARM_EXIT_KEEP(x)
+#endif
+
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
@@ -43,6 +49,7 @@ SECTIONS
 		_sinittext = .;
 			HEAD_TEXT
 			INIT_TEXT
+			ARM_EXIT_KEEP(EXIT_TEXT)
 		_einittext = .;
 		ARM_CPU_DISCARD(PROC_INFO)
 		__arch_info_begin = .;
@@ -71,6 +78,7 @@ SECTIONS
 #ifndef CONFIG_XIP_KERNEL
 		__init_begin = _stext;
 		INIT_DATA
+		ARM_EXIT_KEEP(EXIT_DATA)
 #endif
 	}
 
@@ -166,6 +174,7 @@ SECTIONS
 		. = ALIGN(PAGE_SIZE);
 		__init_begin = .;
 		INIT_DATA
+		ARM_EXIT_KEEP(EXIT_DATA)
 		. = ALIGN(PAGE_SIZE);
 		__init_end = .;
 #endif
