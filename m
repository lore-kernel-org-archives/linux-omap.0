From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 2/4] ARM: add soc memory barrier extension
Date: Wed, 15 Jul 2015 18:47:23 +0100
Message-ID: <E1ZFQmB-0006GB-DW@rmk-PC.arm.linux.org.uk>
References: <20150715174647.GA7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150715174647.GA7557@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

Add an extension to the heavy barrier code to allow a SoC specific
memory barrier function to be provided.  This is needed for platforms
where the interconnect has weak ordering, and thus needs assistance
to ensure that memory writes are properly visible in the correct order
to other parts of the system.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/barrier.h | 1 +
 arch/arm/mm/flush.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index fea99b0e2087..3d8f1d3ad9a7 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -37,6 +37,7 @@
 #endif
 
 #ifdef CONFIG_ARM_HEAVY_MB
+extern void (*soc_mb)(void);
 extern void arm_heavy_mb(void);
 #define __arm_heavy_mb(x...) do { dsb(x); arm_heavy_mb(); } while (0)
 #else
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index ce6c2960d5ac..1ec8e7590fc6 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -22,12 +22,16 @@
 #include "mm.h"
 
 #ifdef CONFIG_ARM_HEAVY_MB
+void (*soc_mb)(void);
+
 void arm_heavy_mb(void)
 {
 #ifdef CONFIG_OUTER_CACHE_SYNC
 	if (outer_cache.sync)
 		outer_cache.sync();
 #endif
+	if (soc_mb)
+		soc_mb();
 }
 EXPORT_SYMBOL(arm_heavy_mb);
 #endif
-- 
2.1.0
