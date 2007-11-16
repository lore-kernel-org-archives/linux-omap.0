From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] Runtime constants: define (some) OMAP address bases at
	runtime rather than compile time for multiboot
Date: Fri, 16 Nov 2007 16:21:59 -0700
Message-ID: <20071116232159.713389488@pwsan.com>
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

This series must be applied after the SRAM patcher series posted earlier
this week, since it relies on that code to set up register addresses in
the assembly-language code at runtime.

This series converts SDRC, SMS, and System Control Module accesses.  
Forthcoming patch series will convert PRCM and 32K sync timer register
access.

Boot-tested on N800 and 3430SDP.  If someone out there could test on 2430SDP,
that would be much appreciated.  Some day I'll get my hands on a  2430SDP :-) 

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
 arch/arm/mach-omap2/pm.c             |    8 +--
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
 24 files changed, 351 insertions(+), 136 deletions(-)

size:

   text    data     bss     dec     hex filename
2925380  152936   85144 3163460  304544 vmlinux.orig.n800
2925620  152936   85144 3163700  304634 vmlinux.patched.n800
