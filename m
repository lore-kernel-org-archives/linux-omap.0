From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/18] omap2: add Clock Management shared register bit
	defines to cm.h
Date: Wed, 16 May 2007 18:11:36 -0600
Message-ID: <20070517005443.578523103@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0004-omap2-add-Clock-Management-shared-register-bit-defi.patch
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

Add Clock Management register bit defines to cm.h that are shared between
OMAP24XX and OMAP3430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 659e089..48999ce 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -91,4 +91,19 @@ static u32 __attribute__((unused)) cm_read_mod_reg(s16 module, s16 idx)
 	return cm_read_reg(OMAP_CM_REGADDR(module, idx));
 }
 
+/* CM register bits shared between 24XX and 3430 */
+
+/* CM_CLKSEL_GFX */
+#define OMAP_CLKSEL_GFX_SHIFT				0
+#define OMAP_CLKSEL_GFX_MASK				(0x7 << 0)
+
+/* CM_ICLKEN_GFX */
+#define OMAP_EN_GFX_SHIFT				0
+#define OMAP_EN_GFX					(1 << 0)
+
+/* CM_IDLEST_GFX */
+#define OMAP_ST_GFX					(1 << 0)
+
+
+
 #endif
-- 
1.5.1.3

-- 
