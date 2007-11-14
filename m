From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/5] SRAM patcher: patch register addresses in SRAM code at
	runtime
Date: Wed, 14 Nov 2007 01:30:10 -0700
Message-ID: <20071114083010.938764990@pwsan.com>
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


Several SRAM-based assembly-language routines in the Linux OMAP kernel
use hardcoded virtual addresses to access system registers.  These
addresses were defined at compile-time by the preprocessor, since the
same registers often appeared at different virtual addresses
depending upon the target OMAP architecture.  Hardcoding the addresses
is efficient and convenient to implement; but precludes a single kernel
binary image from supporting multiple OMAP architectures.

This patches implement a different approach.  They patch in the
correct register addresses at runtime into the SRAM, just after the
code is copied there.  While the current code simply writes in the
preprocessor-defined address bases, a forthcoming patch series uses
this code to write runtime-computed address bases.

The code that does the patching is quite paranoid by default, and will
refuse to overwrite any address that does not contain a magic number,
SRAM_VA_MAGIC.  It also contains debugging printks which can be
activated by defining the DEBUG symbol in sram.c and compiling with
CONFIG_DEBUG_LL enabled.

Boot-tested on N800 and 3430SDP.  If someone out there with a 2430SDP
can give these a whirl, that would be appreciated.  Comments welcome,


- Paul

---

diffstat: 

 arch/arm/mach-omap2/pm.c         |   13 +++
 arch/arm/mach-omap2/sdrc.h       |    2
 arch/arm/mach-omap2/sleep.S      |   21 +++---
 arch/arm/mach-omap2/sram-fn.S    |  125 +++++++++++++++++++-----------------
 arch/arm/plat-omap/Kconfig       |   10 ++
 arch/arm/plat-omap/sram.c        |  135 +++++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/sram.h |    3
 include/linux/poison.h           |    6 +
 8 files changed, 245 insertions(+), 70 deletions(-)

size:

   text    data     bss     dec     hex filename
2924328  152944   85112 3162384  304110 vmlinux.orig.n800
2924504  152944   85112 3162560  3041c0 vmlinux.patched.nodebug.n800
2924928  152944   85112 3162984  304368 vmlinux.patched.debug.n800
