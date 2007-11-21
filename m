From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH RESEND 0/4] Runtime constants: define (some) OMAP address
	bases at runtime rather than compile time for multiboot
Date: Tue, 20 Nov 2007 17:16:20 -0700
Message-ID: <20071121001620.571082090@pwsan.com>
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

The OMAP2/3 kernel builds define several preprocessor macros for
module base virtual addresses (e.g., OMAP2_CTRL_BASE).  These macros
are substituted with virtual addresses at compile-time, depending on
what OMAP architecture the kernel is built for.  This technique is
simple and works well for single-OMAP kernels, but cannot be used to
build a multi-OMAP kernel.

So, convert the users of these defines to use runtime-computed global
variables where possible.  Where not possible (e.g., in static initializers),
use chip-specific preprocessor macros.  The global variables are set up
early in the board-*.c files in the map_io() code, before almost everything
else.

This series converts SDRC, SMS, and System Control Module accesses.
Forthcoming patch series will convert PRCM and 32K sync timer register
access.

Boot-tested on N800 and 3430SDP.  Thanks to Kevin Hilman, who tested an
earlier version of this against 2430SDP.  This series has been refreshed
against git 0945b0b (current HEAD).

Comments welcome,


- Paul

---

diffstat:

 arch/arm/mach-omap2/board-2430osk.c  |    1
 arch/arm/mach-omap2/board-2430sdp.c  |    1
 arch/arm/mach-omap2/board-3430sdp.c  |    1
 arch/arm/mach-omap2/board-apollon.c  |    1
 arch/arm/mach-omap2/board-generic.c  |    1
 arch/arm/mach-omap2/board-h4.c       |    4 +
 arch/arm/mach-omap2/board-n800.c     |    1
 arch/arm/mach-omap2/clock34xx.h      |   30 ++++--------
 arch/arm/mach-omap2/control.h        |   41 +++++++++++++++++
 arch/arm/mach-omap2/id.c             |    4 +
 arch/arm/mach-omap2/memory.c         |   10 ++--
 arch/arm/mach-omap2/pm.c             |    6 +-
 arch/arm/mach-omap2/sdrc.h           |   66 +++++++++-------------------
 arch/arm/plat-omap/common.c          |   36 +++++++++++++++
 arch/arm/plat-omap/devices.c         |   12 +++--
 arch/arm/plat-omap/mux.c             |   13 +++--
 arch/arm/plat-omap/sram.c            |    6 +-
 arch/arm/plat-omap/usb.c             |   66 ++++++++++++++++++++++------
 include/asm-arm/arch-omap/common.h   |    4 +
 include/asm-arm/arch-omap/control.h  |   58 +++++++++++++++++++++++++
 include/asm-arm/arch-omap/omap24xx.h |   18 -------
 include/asm-arm/arch-omap/omap34xx.h |   19 +-------
 include/asm-arm/arch-omap/sdrc.h     |   81 ++++++++++++++++++++++++++++++++++-
 include/asm-arm/arch-omap/usb.h      |    5 --
 24 files changed, 350 insertions(+), 135 deletions(-)

size:

   text    data     bss     dec     hex filename
2925408  152936   85112 3163456  304540 vmlinux.orig.n800
2925664  152936   85144 3163744  304660 vmlinux.patched.n800
