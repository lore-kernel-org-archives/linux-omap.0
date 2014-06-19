From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v3.16-rc1 & default cachepolicy
Date: Fri, 20 Jun 2014 01:40:04 +0300
Message-ID: <20140619224004.GF558@drone.musicnaut.iki.fi>
References: <20140619203655.GE558@drone.musicnaut.iki.fi>
 <20140619205853.GH3705@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:59330 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758054AbaFSWkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jun 2014 18:40:13 -0400
Content-Disposition: inline
In-Reply-To: <20140619205853.GH3705@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Jun 19, 2014 at 09:58:53PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 19, 2014 at 11:36:55PM +0300, Aaro Koskinen wrote:
> > When booting v3.16-rc1 on OMAP1, I noticed strange slowness.
> > E.g. initramfs unpack takes several minutes. This was caused by default
> > cachepolicy getting changed from writethrough -> uncached for some reason:
> > 
> > [    0.000000] Booting Linux on physical CPU 0x0
> > [    0.000000] Initializing cgroup subsys cpu
> > [    0.000000] Linux version 3.16.0-rc1-e3-los_880e+ (aaro@cooljazz) (gcc version 4.9.0 (GCC) ) #1 PREEMPT Thu Jun 19 22:51:42 EEST 2014
> > [    0.000000] CPU: ARM925T [54029252] revision 2 (ARMv4T), cr=0000317f
> > [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> > [    0.000000] Machine: Amstrad E3 (Delta)
> > [    0.000000] Ignoring memory below PHYS_OFFSET: 0x02000000-0x10000000
> > [    0.000000] bootconsole [earlycon0] enabled
> > [    0.000000] Memory policy: Data cache uncached
> > [...]
> > [    4.602732] Unpacking initramfs...
> > [  425.125093] Freeing initrd memory: 3532K (c1c00000 - c1f73000)
> > 
> > It seems this is caused by commit:
> > 
> > commit ca8f0b0a545f55b3dc6877cda24d609a8979c951
> > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > Date:   Tue May 27 20:34:28 2014 +0100
> > 
> >     ARM: ensure C page table setup code follows assembly code
> > 
> > I can workaround this with "cachepolicy=writethrough" parameter.
> 
> It brings up the question - proc-arm925.S contains:
> 
>         .long   PMD_TYPE_SECT | \
>                 PMD_BIT4 | \
>                 PMD_SECT_AP_WRITE | \
>                 PMD_SECT_AP_READ
>         .long   PMD_TYPE_SECT | \
>                 PMD_BIT4 | \
>                 PMD_SECT_AP_WRITE | \
>                 PMD_SECT_AP_READ
> 
> In other words, it's telling the assembly code to setup uncached mappings
> for everything, even memory.  Most people want to set memory up (even at
> the assembly code time) in cacheable mode... so I'd suggest adding:
> 
>                 PMD_SECT_BUFFERABLE | \
>                 PMD_SECT_CACHEABLE | \
> 
> from the first.  You'll find it in the .macro at the end of proc-arm925.S.
> Please let me know if that works for you.

So I tried the below change. But now it hangs early, even before
the earlyprintk is working. :-/

A.

diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 97448c3..cb7c0e7 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -502,6 +502,8 @@ __\name\()_proc_info:
 	.long	\cpu_val
 	.long	\cpu_mask
 	.long   PMD_TYPE_SECT | \
+		PMD_SECT_BUFFERABLE | \
+		PMD_SECT_CACHEABLE | \
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
