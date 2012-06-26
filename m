From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH 1/2] ARM: omap: fix typos related to OMAP330
Date: Tue, 26 Jun 2012 23:12:47 +0200
Message-ID: <1340745167.1911.13.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
I tracked this set of typos back to commit
9ad5897c2659b3c610e0c717e8b3dbfb496d2c74 ("[ARM] 3143/1: OMAP 4/5:
Update omap include files"). It is just something I noticed while
working on the next patch.

 arch/arm/plat-omap/include/plat/cpu.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 297245d..f2bdf15 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -238,7 +238,7 @@ IS_AM_SUBCLASS(335x, 0x335)
 /*
  * Macros to detect individual cpu types.
  * These are only rarely needed.
- * cpu_is_omap330():	True for OMAP330
+ * cpu_is_omap310():	True for OMAP310
  * cpu_is_omap730():	True for OMAP730
  * cpu_is_omap850():	True for OMAP850
  * cpu_is_omap1510():	True for OMAP1510
@@ -304,7 +304,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 /*
  * Whether we have MULTI_OMAP1 or not, we still need to distinguish
- * between 730 vs 850, 330 vs. 1510 and 1611B/5912 vs. 1710.
+ * between 730 vs 850, 310 vs. 1510 and 1611B/5912 vs. 1710.
  */
 
 #if defined(CONFIG_ARCH_OMAP730)
-- 
1.7.7.6
