From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] ARM: OMAP: DRA7: Make use of omap_revision information for
 soc_is* calls
Date: Wed, 17 Feb 2016 16:18:43 +0530
Message-ID: <1455706123-26497-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, linux@arm.linux.org.uk
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently of_machine_is_compatible is used to detect the soc which
employs string comparison operations. We already have all the required
information in the omap_revision. Hence make use of the same like
the previous OMAPs and avoid costly string comparisons.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Couple of checkpatch warnings present but stuck to the code
convention followed in the file already.

Boot tested on both DRA7-EVM and DRA72-EVM.

Previous discussion:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/378615.html

 arch/arm/mach-omap2/soc.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 79ca3c3..70df8f6 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -181,6 +181,14 @@ static inline int is_ti ##class (void)		\
 	return (GET_TI_CLASS == (id)) ? 1 : 0;	\
 }
 
+#define GET_DRA_CLASS	((omap_rev() >> 24) & 0xff)
+
+#define IS_DRA_CLASS(class, id)				\
+static inline int is_dra ##class (void)			\
+{							\
+	return (GET_DRA_CLASS == (id)) ? 1 : 0;		\
+}
+
 #define GET_OMAP_SUBCLASS	((omap_rev() >> 20) & 0x0fff)
 
 #define IS_OMAP_SUBCLASS(subclass, id)			\
@@ -201,6 +209,12 @@ static inline int is_am ##subclass (void)		\
 	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
 }
 
+#define IS_DRA_SUBCLASS(subclass, id)			\
+static inline int is_dra ##subclass (void)		\
+{							\
+	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
+}
+
 IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)
@@ -210,6 +224,7 @@ IS_AM_CLASS(33xx, 0x33)
 IS_AM_CLASS(43xx, 0x43)
 
 IS_TI_CLASS(81xx, 0x81)
+IS_DRA_CLASS(7xx, 0x7)
 
 IS_OMAP_SUBCLASS(242x, 0x242)
 IS_OMAP_SUBCLASS(243x, 0x243)
@@ -224,6 +239,8 @@ IS_TI_SUBCLASS(816x, 0x816)
 IS_TI_SUBCLASS(814x, 0x814)
 IS_AM_SUBCLASS(335x, 0x335)
 IS_AM_SUBCLASS(437x, 0x437)
+IS_DRA_SUBCLASS(75x, 0x75)
+IS_DRA_SUBCLASS(72x, 0x72)
 
 #define soc_is_omap24xx()		0
 #define soc_is_omap242x()		0
@@ -397,9 +414,9 @@ IS_OMAP_TYPE(3430, 0x3430)
 #undef soc_is_dra7xx
 #undef soc_is_dra74x
 #undef soc_is_dra72x
-#define soc_is_dra7xx()	(of_machine_is_compatible("ti,dra7"))
-#define soc_is_dra74x()	(of_machine_is_compatible("ti,dra74"))
-#define soc_is_dra72x()	(of_machine_is_compatible("ti,dra72"))
+#define soc_is_dra7xx()	is_dra7xx()
+#define soc_is_dra74x()	is_dra75x()
+#define soc_is_dra72x()	is_dra72x()
 #endif
 
 /* Various silicon revisions for omap2 */
-- 
1.9.1
