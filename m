From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/7] OMAP3 clock patches: first set (take two)
Date: Thu, 27 Sep 2007 00:11:19 -0600
Message-ID: <20070927061119.551228401@pwsan.com>
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

this is take two of the initial OMAP3430 clock tree patches, with
several bug fixes.  UART clock enable warnings are now fixed,
and some clocks that didn't recalculate rates correctly are now
fixed.  A few more details are in the per-patch notes.

Boot tested on N800 and 3430SDP.  Diffstat and size have been updated at
the end of the message.  Testing welcome, as always.

- Paul

-----------------------------------------------------------------------

These patches implement the OMAP3430 clock tree, along with the basic
clock code necessary to support it.  The clock definitions were drawn
from 3430 ES1 and ES2 TRMs, and the patches try to adhere to the TRM
as closely as is practicable.

The clock tree is mostly 3430ES1-based.  A few 3430ES2 features are
implemented, such as 16.8MHz SYS_CLK and PWRDN bits.  Some ES2 clocks
are yet to be defined, and will be added in subsequent patches.  Also
not included in this patch set are DPLL control patches, L3 divider
code, and OPP code; these will be sent as separate patch sets.

Most of the new code is in patch 4.  Patches 1 & 2 are cleanup/bugfix
patches; patch 3 adds support for PWRDN bit usage in the clock
framework; patches 5-7 fix the GPMC, dmtimer, and GPIO drivers for
boot.

The code has been boot-tested on 3430SDP using a 3430ES1 chip.

Thanks to Tony Lindgren and Richard Woodruff for their assistance in
providing support and information.  These patches also include some silicon
errata drawn from the TI CDP kernel clock code, written by Karthik Dasu.

Review and comments are appreciated,

- Paul

 arch/arm/mach-omap2/clock.c                       |   66
 arch/arm/mach-omap2/cm.h                          |    2
 include/asm-arm/arch-omap/clock.h                 |   12
 linux-omap/arch/arm/mach-omap2/Makefile           |    1
 linux-omap/arch/arm/mach-omap2/clock.c            |   36
 linux-omap/arch/arm/mach-omap2/clock.h            |   22
 linux-omap/arch/arm/mach-omap2/clock24xx.c        |    7
 linux-omap/arch/arm/mach-omap2/clock24xx.h        |   75
 linux-omap/arch/arm/mach-omap2/clock34xx.c        |  222 ++
 linux-omap/arch/arm/mach-omap2/clock34xx.h        | 2214 ++++++++++++++++++++++
 linux-omap/arch/arm/mach-omap2/cm.h               |    2
 linux-omap/arch/arm/mach-omap2/cm_regbits_34xx.h  |  138 +
 linux-omap/arch/arm/mach-omap2/gpmc.c             |    6
 linux-omap/arch/arm/mach-omap2/prcm_common.h      |   41
 linux-omap/arch/arm/mach-omap2/prm.h              |    2
 linux-omap/arch/arm/mach-omap2/prm_regbits_34xx.h |    9
 linux-omap/arch/arm/plat-omap/dmtimer.c           |    5
 linux-omap/arch/arm/plat-omap/gpio.c              |   40
 linux-omap/include/asm-arm/arch-omap/clock.h      |    2
 linux-omap/include/asm-arm/arch-omap/gpio.h       |    2
 linux-omap/include/asm-arm/arch-omap/omap34xx.h   |    9
 21 files changed, 2801 insertions(+), 112 deletions(-)

size:
   text    data     bss     dec     hex filename
2763816  115776   96224 2975816  2d6848 vmlinux.orig
2768744  130432   96256 2995432  2db4e8 vmlinux
