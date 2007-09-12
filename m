From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/3] omap2 clock: create clock24xx.[ch] in preparation for
	3430 clock code
Date: Wed, 12 Sep 2007 00:01:41 -0600
Message-ID: <20070912060141.645853958@pwsan.com>
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

this short patch series separates OMAP24xx clock definitions and code
from common clock code and headers.  It's in preparation for OMAP3430
clock definitions and code.

All this happens in patches 2 and 3 of this series.  The remaining
patch 1 moves some SDRC-related defines from clock.h into sdrc.h where
they belong.

The diffstat looks big, but the patches are mostly just cut and paste,
with a few minor changes to expose common functions to the linker, and
to satisfy checkpatch (at least somewhat).

Review and comments are appreciated, as always.


- Paul

diffstat:
 arch/arm/mach-omap2/clock.c                |  548 -----
 arch/arm/mach-omap2/clock.h                | 2661 -----------------------------
 linux-omap/arch/arm/mach-omap2/Makefile    |    3
 linux-omap/arch/arm/mach-omap2/clock.c     |    2
 linux-omap/arch/arm/mach-omap2/clock.h     |   62
 linux-omap/arch/arm/mach-omap2/clock24xx.c |  521 +++++
 linux-omap/arch/arm/mach-omap2/clock24xx.h | 2653 ++++++++++++++++++++++++++++
 linux-omap/arch/arm/mach-omap2/sdrc.h      |   31
 8 files changed, 3290 insertions(+), 3191 deletions(-)

size:
   text    data     bss     dec     hex filename
2853812  149804   85992 3089608  2f24c8 vmlinux.orig
2854244  149804   85992 3090040  2f2678 vmlinux
