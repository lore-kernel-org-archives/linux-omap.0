From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 00/24 V2] OMAP4: PM: suspend, CPU-hotplug and CPUilde
 support
Date: Tue, 11 Oct 2011 12:39:54 +0530
Message-ID: <4E93EBC2.1060103@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com> <87ty7ghgiw.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37629 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360Ab1JKHKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 03:10:01 -0400
Received: by mail-gy0-f179.google.com with SMTP id 4so7196937gyg.38
        for <linux-omap@vger.kernel.org>; Tue, 11 Oct 2011 00:10:00 -0700 (PDT)
In-Reply-To: <87ty7ghgiw.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Monday 10 October 2011 11:31 PM, Kevin Hilman wrote:
> Hi Santosh,
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
>> suspend (S2R), CPU hotplug and CPUidle.
> 
> There are a few more compile errors when doing OMAP1-only builds.
> You'll need a way to eliminate the secure calls for OMAP1.
> 
> This series causes a couple build errors when doing OMAP1-only builds
> (I used omap1_defconfig):
> 
OK. Thanks for catching it.

> First:
> 
> /work/kernel/omap/pm/arch/arm/plat-omap/common.c:24:30: fatal error: mach/omap-secure.h: No such file or directory
> 
> And trying creating a dummy header to see if it would continue to build gives:
> 
> /work/kernel/omap/pm/arch/arm/plat-omap/common.c: In function 'omap_reserve':
> /work/kernel/omap/pm/arch/arm/plat-omap/common.c:70:2: error: implicit declaration of function 'omap_secure_ram_reserve_memblock'
> make[2]: *** [arch/arm/plat-omap/common.o] Error 1
> make[1]: *** [arch/arm/plat-omap] Error 2
> 
For OMAP1 build, omap_secure_ram_reserve_memblock() definition is
needed since common.c is built for OMAP1 as well.
The trivial change in the end of this email fixes the omap1 build.
Have folded that change in original patch and updated the OMAP4
PM branch - for_3_2/omap4-mpuss-pm_2

Regards
Santosh
P.S : Even with this fix, omap1_defconfig build breaks because of USB.
I removed USB from build to check rest of the build and it was
fine then.

---
diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h
b/arch/arm/mach-omap2/include/mach/omap-secure.h
index 6e929c5..48247ce 100644
--- a/arch/arm/mach-omap2/include/mach/omap-secure.h
+++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
@@ -51,7 +51,6 @@ extern u32 omap_secure_dispatcher(u32 idx, u32 flag,
u32 nargs,
 				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
 extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
-extern int omap_secure_ram_reserve_memblock(void);

 #endif /* __ASSEMBLER__ */
 #endif /* OMAP_ARCH_OMAP_SECURE_H */
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 827f896..d5ef8dc 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -21,7 +21,7 @@
 #include <plat/vram.h>
 #include <plat/dsp.h>

-#include <mach/omap-secure.h>
+#include <plat/omap-secure.h>


 #define NO_LENGTH_CHECK 0xffffffff
diff --git a/arch/arm/plat-omap/include/plat/omap-secure.h
b/arch/arm/plat-omap/include/plat/omap-secure.h
new file mode 100644
index 0000000..64f9d1c
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/omap-secure.h
@@ -0,0 +1,13 @@
+#ifndef __OMAP_SECURE_H__
+#define __OMAP_SECURE_H__
+
+#include <linux/types.h>
+
+#ifdef CONFIG_ARCH_OMAP2PLUS
+extern int omap_secure_ram_reserve_memblock(void);
+#else
+static inline void omap_secure_ram_reserve_memblock(void)
+{ }
+#endif
+
+#endif /* __OMAP_SECURE_H__ */
