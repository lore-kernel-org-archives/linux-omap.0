From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 00/25] Re-jig cpu_suspend for a saner calling convention
Date: Thu, 23 Jun 2011 20:09:00 +0100
Message-ID: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Version 3.

Currently cpu_suspend is not like a normal C function - when it's called
it returns normally to a bunch of code which is not expected to return.
The return path is via code pointed to by 'r3'.

It also corrupts a bunch of registers in ways which make it non-compliant
with a C API.

If we do make this compliant as a normal C-like function, it eliminates
this register saving, and also allows us to make greater savings.  We
also swap 'lr' and 'r3', so cpu_suspend effectively only returns to
following code on resume - and r3 points to the suspend code.

I've also changed cpu_suspend() to have a saner visible prototype for
calling from platforms, hiding the needed v:p offset parameter in the
inline function.

So, this becomes:
static void soc_suspend(void)
{
        [soc specific preparation]

        cpu_suspend(soc_suspend_arg, soc_finish_suspend);

        [soc specific cleanup ]
}

where soc_suspend_fn can be either assembly or C code - but must never
return.  (See separate patch posted on 13th June to allow it to return.)

This patch series also merges the call to cpu_init() into cpu_suspend(),
and makes cpu_init() call the per-CPU initialization function to ensure
that various registers are setup (eg, clock switching on StrongARM,
read-buffer enabled for userspace, etc.)  This allows some more custom
platform suspend code to be removed.

I've been able to convert OMAP3 suspend support and test it in both
retention and off modes.

The only platform not converted to cpu_suspend() is the shmobile stuff,
which I've requested their assistance with.

This patch set also eliminates 300 LOC from platform code.

Tested on Assabet (SA1100) and 3430LDP only.

 arch/arm/include/asm/suspend.h          |   21 ++++
 arch/arm/kernel/setup.c                 |   99 ++++++++++----------
 arch/arm/kernel/sleep.S                 |   73 ++++++---------
 arch/arm/mach-exynos4/pm.c              |    2 +-
 arch/arm/mach-exynos4/sleep.S           |   22 ----
 arch/arm/mach-omap2/pm34xx.c            |   48 ++-------
 arch/arm/mach-omap2/sleep34xx.S         |  160 ++-----------------------------
 arch/arm/mach-pxa/include/mach/pm.h     |    4 +-
 arch/arm/mach-pxa/palmz72.c             |    1 +
 arch/arm/mach-pxa/pm.c                  |    1 -
 arch/arm/mach-pxa/pxa25x.c              |    3 +-
 arch/arm/mach-pxa/pxa27x.c              |   11 ++-
 arch/arm/mach-pxa/pxa3xx.c              |   14 +++-
 arch/arm/mach-pxa/sleep.S               |   55 ++---------
 arch/arm/mach-pxa/zeus.c                |    3 +-
 arch/arm/mach-s3c2412/pm.c              |    4 +-
 arch/arm/mach-s3c2416/pm.c              |    4 +-
 arch/arm/mach-s3c64xx/pm.c              |    2 +-
 arch/arm/mach-s3c64xx/sleep.S           |   23 -----
 arch/arm/mach-s5pv210/pm.c              |    2 +-
 arch/arm/mach-s5pv210/sleep.S           |   21 ----
 arch/arm/mach-sa1100/pm.c               |    7 +-
 arch/arm/mach-sa1100/sleep.S            |   19 +----
 arch/arm/mm/proc-sa1100.S               |    4 +-
 arch/arm/mm/proc-v7.S                   |   10 ++-
 arch/arm/plat-s3c24xx/sleep.S           |   25 -----
 arch/arm/plat-samsung/include/plat/pm.h |    5 +-
 arch/arm/plat-samsung/pm.c              |   11 +--
 28 files changed, 180 insertions(+), 474 deletions(-)
