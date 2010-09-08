From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Tue, 7 Sep 2010 20:09:51 -0700
Message-ID: <20100908030951.GH22507@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100906180346.GC20849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49554 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab0IHDKF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 23:10:05 -0400
Content-Disposition: inline
In-Reply-To: <20100906180346.GC20849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

* Tony Lindgren <tony@atomide.com> [100906 10:56]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100906 03:36]:
> > Here's my latest patch (which is combined from two patches.)
> > 
> > Tony, could you follow up with patches for anything which is still
> > required - I think there's two things you've addressed which this
> > currently misses:
> > 
> > 1. not initializing twd_base (I'm not convinced this is safe - rather
> >    making smp_prepare_cpus() return early is probably a better idea.)

Looks like the omap spefific fix needed now is for the localtimer, and
that can be now checked with cpu_is_omap44xx() as Santosh suggested
earlier. Will post that shortly.

> > 2. __flush_icache_all()
> > 
> > Note that (2) seems to be complicated by the instruction only being
> > available on ARMv7 and later.

This is still open and needs to be fixed somehow..

Then the following patch is needed to fix compile if CONFIG_SMP is not set.

Other than that, things are actually quite close to working. Will post
three more patches as a reply to this mail that allow me to boot to
shell with the same SMP kernel binary on omap2, 3 & 4 more or less.

Need to track down some .config file strangeness though tomorrow to
figure out what is causing the WARNING: at mm/percpu-vm.c:320 pcpu_alloc
messages again.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 7 Sep 2010 19:09:57 -0700
Subject: [PATCH] ARM: Fix smp_on_up compile when CONFIG_SMP is not set

Fix undefined reference to smp_init_cpus()
and error for the discarded section:

ld:arch/arm/kernel/vmlinux.lds:517: syntax error

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index fe94467..5a82c39 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -825,8 +825,10 @@ void __init setup_arch(char **cmdline_p)
 	paging_init(mdesc);
 	request_standard_resources(&meminfo, mdesc);
 
+#ifdef CONFIG_SMP
 	if (is_smp())
 		smp_init_cpus();
+#endif
 	reserve_crashkernel();
 
 	cpu_init();
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 53cb57e..b721e8b 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -244,7 +244,7 @@ SECTIONS
 	DISCARDS
 
 #ifndef CONFIG_SMP_ON_UP
-	/DISCARD/ {
+	/DISCARD/ : {
 		*(.smpalt.init)
 	}
 #endif
