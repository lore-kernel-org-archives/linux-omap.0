From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix sev instruction usage for multi-omap
Date: Fri, 6 Aug 2010 10:05:20 +0300
Message-ID: <20100806070519.GB23778@atomide.com>
References: <8739uu9em0.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com>
 <87tyn8ptkl.fsf@deeprootsystems.com>
 <20100806070301.GA23778@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="z6Eq5LdranGa6ru8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64009 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933077Ab0HFHEt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 03:04:49 -0400
Content-Disposition: inline
In-Reply-To: <20100806070301.GA23778@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100806 09:55]:
> * Kevin Hilman <khilman@deeprootsystems.com> [100806 01:48]:
> > 
> > > Also with omap_4430sdp_defconfig, I see these compile errors
> > > arch/arm/kernel/entry-armv.S: Assembler messages:
> > > arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
> > > arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
> > > make[1]: *** [arch/arm/kernel/entry-armv.o] Error 1
> > > make: *** [arch/arm/kernel] Error 2
> > >
> > > Doing a git log on entry-armv.S shows me a top commit which might
> > > be an issue if conflicts are'nt resolved well.
> > >
> > > commit 7b70c4275f28702b76b273c8534c38f8313812e9
> > > Merge: ceb0885... a20df56...
> > > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Date:   Sat Jul 31 14:20:16 2010 +0100
> > >
> > >     Merge branch 'devel-stable' into devel
> > >
> > >     Conflicts:
> > >         arch/arm/kernel/entry-armv.S
> > >         arch/arm/kernel/setup.c
> > >         arch/arm/mm/init.c
> > >
> > > Maybe this is an issue in Tony's for-next as well. Haven't tested
> > > it though.
> > 
> > Yeah, I'm guessing this an issue in for-next, and probably l-o master
> > too.
> 
> Noticed that with omap3_defconfig with CONFIG_SMP enabled. Does the
> following work for you?

Here's a related patch that allows CONFIG_SMP to compile with
omap3_defconfig. Booting still won't work before some arm generic
code is changed.

Regards,

Tony

--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=smp-fix-sev

>From f931fb147f2a3cf4c4b7646e5f270c241ab4aad1 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 5 Aug 2010 13:28:42 +0300
Subject: [PATCH] omap: Fix sev instruction usage for multi-omap

Otherwise we get the following error with omap3_defconfig and CONFIG_SMP:

Error: selected processor does not support `sev'

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 63b2d88..88d3a1e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
 
+AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a
 AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a
 
 # Functions loaded to SRAM
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index af3c20c..9e9f70e 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -102,8 +102,7 @@ static void __init wakeup_secondary(void)
 	 * Send a 'sev' to wake the secondary core from WFE.
 	 * Drain the outstanding writes to memory
 	 */
-	dsb();
-	set_event();
+	dsb_sev();
 	mb();
 }
 
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
index 6a3ff65..5177a9c 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -19,13 +19,6 @@
 
 #include <asm/hardware/gic.h>
 
-/*
- * set_event() is used to wake up secondary core from wfe using sev. ROM
- * code puts the second core into wfe(standby).
- *
- */
-#define set_event()	__asm__ __volatile__ ("sev" : : : "memory")
-
 /* Needed for secondary core boot */
 extern void omap_secondary_startup(void);
 extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);

--z6Eq5LdranGa6ru8--
