From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: v3.16-rc1 & default cachepolicy
Date: Thu, 19 Jun 2014 21:58:53 +0100
Message-ID: <20140619205853.GH3705@n2100.arm.linux.org.uk>
References: <20140619203655.GE558@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35763 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932343AbaFSU66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jun 2014 16:58:58 -0400
Content-Disposition: inline
In-Reply-To: <20140619203655.GE558@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 19, 2014 at 11:36:55PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> When booting v3.16-rc1 on OMAP1, I noticed strange slowness.
> E.g. initramfs unpack takes several minutes. This was caused by default
> cachepolicy getting changed from writethrough -> uncached for some reason:
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 3.16.0-rc1-e3-los_880e+ (aaro@cooljazz) (gcc version 4.9.0 (GCC) ) #1 PREEMPT Thu Jun 19 22:51:42 EEST 2014
> [    0.000000] CPU: ARM925T [54029252] revision 2 (ARMv4T), cr=0000317f
> [    0.000000] CPU: VIVT data cache, VIVT instruction cache
> [    0.000000] Machine: Amstrad E3 (Delta)
> [    0.000000] Ignoring memory below PHYS_OFFSET: 0x02000000-0x10000000
> [    0.000000] bootconsole [earlycon0] enabled
> [    0.000000] Memory policy: Data cache uncached
> [...]
> [    4.602732] Unpacking initramfs...
> [  425.125093] Freeing initrd memory: 3532K (c1c00000 - c1f73000)
> 
> It seems this is caused by commit:
> 
> commit ca8f0b0a545f55b3dc6877cda24d609a8979c951
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Tue May 27 20:34:28 2014 +0100
> 
>     ARM: ensure C page table setup code follows assembly code
> 
> I can workaround this with "cachepolicy=writethrough" parameter.

It brings up the question - proc-arm925.S contains:

        .long   PMD_TYPE_SECT | \
                PMD_BIT4 | \
                PMD_SECT_AP_WRITE | \
                PMD_SECT_AP_READ
        .long   PMD_TYPE_SECT | \
                PMD_BIT4 | \
                PMD_SECT_AP_WRITE | \
                PMD_SECT_AP_READ

In other words, it's telling the assembly code to setup uncached mappings
for everything, even memory.  Most people want to set memory up (even at
the assembly code time) in cacheable mode... so I'd suggest adding:

                PMD_SECT_BUFFERABLE | \
                PMD_SECT_CACHEABLE | \

from the first.  You'll find it in the .macro at the end of proc-arm925.S.
Please let me know if that works for you.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
