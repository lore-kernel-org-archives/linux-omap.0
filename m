From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/28] omap2 clock: framework generalization, cleanup
Date: Mon, 20 Aug 2007 03:53:47 -0600
Message-ID: <20070820095347.933473149@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

This set of patches contains some significant changes to the OMAP2 clock
framework.  The main goal of these patches is to generalize the framework
enough to be usable for the OMAP3430 clock tree, although in the process
I think the OMAP2 clock code is improved quite a bit - I hope you'll agree.

The major change in this patch set is the rewrite of clksel
clock handling, which: 

* enables clksel parent clocks to be updated at clock framework init, from
  whatever the bootloader configured,

* properly encodes platform restrictions for particular rates, 

* generalizes the clksel code to be useful for OMAP3430 clocks,

* facilitates future improved clock state reporting,

* and improves readability and maintainability.

The clksel patches are patches 6 through 20.  A few other notable changes 
in this patchset:

* Cleanups/bug fixes: patches 1, 3, 4, 5

* Generalize root clock propagation at clock framework init: patch 2

* Use OMAP clock framework enable/disable fns for osc_ck, APLLs: patches 21,
  22, 23

* Recalculate osc_ck and sys_ck via recalculate fns, rather than 
  omap2_get_crystal_rate(): patch 24

* Generalize DPLL multiplier, divider handling: patches 25

* Generalize clocks enabled at init via ENABLE_ON_INIT clock flag: patch 26

* Generalize clock autoidle configuration: patches 27, 28

The patches were boot-tested on N800.  Comments and testing are appreciated.
In particular, any testing on 2430SDP are particularly welcome, since I
don't have one here.

Patches apply cleanly against current git head, and seem to run fine,
but I've been doing most of my testing against 2.6.22-omap1, since my
N800 touchscreen does not work consistently with git head.

These changes increase uncompressed kernel memory footprint by 
about 6kB:
   text    data     bss     dec     hex filename
2877920  147788   85992 3111700  2f7b14 vmlinux.orig
2881092  150908   85992 3117992  2f93a8 vmlinux

diffstat:
 arch/arm/mach-omap2/clock.c                       |  978 +++++++++----------
 arch/arm/mach-omap2/clock.h                       | 1092 +++++++++++++++++-----
 arch/arm/plat-omap/clock.c                        |   20
 include/asm-arm/arch-omap/clock.h                 |   57 -
 linux-omap/arch/arm/mach-omap2/board-n800-audio.c |   13
 linux-omap/arch/arm/mach-omap2/clock.c            |    6
 linux-omap/arch/arm/mach-omap2/clock.h            |    2
 linux-omap/arch/arm/mach-omap2/cm_regbits_24xx.h  |   50 +
 linux-omap/arch/arm/mach-omap2/pm.c               |   63 -
 linux-omap/arch/arm/plat-omap/clock.c             |   17
 linux-omap/include/asm-arm/arch-omap/clock.h      |    1
 11 files changed, 1492 insertions(+), 807 deletions(-)

My apologies in advance for the double 'Index:' lines in some of the
patches - must be some quilt bug - it seems harmless and I have not
yet had the chance to track it down.

- Paul

-- 
