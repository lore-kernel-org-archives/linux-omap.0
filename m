From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 17/18] omap2: remove remaining prcm-regs.h includes
Date: Fri, 25 May 2007 02:23:39 -0600
Message-ID: <20070525082502.745578096@pwsan.com>
References: <20070525082322.168056647@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=0017-omap2-remove-remaining-prcm-regs.h-includes.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Remove remaining prcm-regs.h includes.  Most of these files don't
use prcm-regs.h anyway.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    1 -
 arch/arm/mach-omap2/board-apollon.c |    1 -
 arch/arm/mach-omap2/board-h4.c      |    1 -
 arch/arm/mach-omap2/mmu.h           |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 7070b89..f01c000 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -38,7 +38,6 @@
 #include <asm/arch/keypad.h>
 #include <asm/arch/gpmc.h>
 #include <asm/arch/mcspi.h>
-#include "prcm-regs.h"
 
 #include <asm/io.h>
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 60adb62..1276f1f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -39,7 +39,6 @@
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
 #include <asm/arch/gpmc.h>
-#include "prcm-regs.h"
 
 /* LED & Switch macros */
 #define LED0_GPIO13		13
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index aa5b657..d51b7aa 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -39,7 +39,6 @@
 #include <asm/arch/menelaus.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/gpmc.h>
-#include "prcm-regs.h"
 
 #include <asm/io.h>
 
diff --git a/arch/arm/mach-omap2/mmu.h b/arch/arm/mach-omap2/mmu.h
index cbc82af..7520f91 100644
--- a/arch/arm/mach-omap2/mmu.h
+++ b/arch/arm/mach-omap2/mmu.h
@@ -1,7 +1,6 @@
 #ifndef __MACH_OMAP2_MMU_H
 #define __MACH_OMAP2_MMU_H
 
-#include "prcm-regs.h"
 #include <asm/arch/mmu.h>
 #include <asm/io.h>
 
-- 
1.5.1.3

-- 
