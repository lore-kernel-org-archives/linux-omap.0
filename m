From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 11/12] OMAP2/3: SRAM: add comment about crashes during a TLB
	miss
Date: Mon, 13 Dec 2010 23:34:54 -0700
Message-ID: <20101214063453.21555.15306.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50295 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab0LNGf2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:35:28 -0500
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, Jon Hunter <jon-hunter@ti.com>

Some users were observing crashes during the execution of CORE DVFS
code from OCM RAM -- a locally-modified copy of the linux-omap code.
Richard Woodruff tracked this down to a DTLB miss which had been
inadvertently and intermittently caused by the local modifications.
(The TLB miss caused the ARM MMU to attempt to walk the page tables
stored in SDRAM, which was not possible since SDRAM is off-line for a
portion of the CORE DVFS OCM RAM code.)

Add a note to the OMAP2 & OMAP3 CORE DVFS SRAM code to warn others that
changes may result in crashes here if they are not carefully tested.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Richard Woodruff <r-woodruff2@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sram242x.S |    6 ++++++
 arch/arm/mach-omap2/sram243x.S |    6 ++++++
 arch/arm/mach-omap2/sram34xx.S |    6 ++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sram242x.S b/arch/arm/mach-omap2/sram242x.S
index 92e6e1a..6d88cee 100644
--- a/arch/arm/mach-omap2/sram242x.S
+++ b/arch/arm/mach-omap2/sram242x.S
@@ -21,6 +21,12 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  * MA 02111-1307 USA
+ *
+ * Richard Woodruff notes that any changes to this code must be carefully
+ * audited and tested to ensure that they don't cause a TLB miss while
+ * the SDRAM is inaccessible.  Such a situation will crash the system
+ * since it will cause the ARM MMU to attempt to walk the page tables.
+ * These crashes may be intermittent.
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
diff --git a/arch/arm/mach-omap2/sram243x.S b/arch/arm/mach-omap2/sram243x.S
index ab49736..2f104a6 100644
--- a/arch/arm/mach-omap2/sram243x.S
+++ b/arch/arm/mach-omap2/sram243x.S
@@ -21,6 +21,12 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  * MA 02111-1307 USA
+ *
+ * Richard Woodruff notes that any changes to this code must be carefully
+ * audited and tested to ensure that they don't cause a TLB miss while
+ * the SDRAM is inaccessible.  Such a situation will crash the system
+ * since it will cause the ARM MMU to attempt to walk the page tables.
+ * These crashes may be intermittent.
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 3637274..43f67f5 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -104,6 +104,12 @@
  * touching the SDRAM.  Until that time, users who know that their use case
  * can satisfy the above requirement can enable the CONFIG_OMAP3_SDRC_AC_TIMING
  * option.
+ *
+ * Richard Woodruff notes that any changes to this code must be carefully
+ * audited and tested to ensure that they don't cause a TLB miss while
+ * the SDRAM is inaccessible.  Such a situation will crash the system
+ * since it will cause the ARM MMU to attempt to walk the page tables.
+ * These crashes may be intermittent.
  */
 ENTRY(omap3_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack


