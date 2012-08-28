From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 2/9] ARM: OMAP: omap3evm: cleanup revision bits
Date: Wed, 29 Aug 2012 02:18:50 +0300
Message-ID: <1346195937-6383-3-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The omap3evm has its revision information bits inside the plat/board.h
file. Those bits are not used anywhere in the upstream tree besides the
board-omap3evm.c file.
Move the OMAP3EVM_BOARD_GEN_* bits to the board file and remove the
get_omap3_evm_rev() function declaration.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-omap3evm.c    |   12 ++++++++++++
 arch/arm/plat-omap/include/plat/board.h |   18 ------------------
 2 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 5be082b..8477137 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -73,6 +73,18 @@
 #define OMAP3EVM_GEN1_ETHR_GPIO_RST	64
 #define OMAP3EVM_GEN2_ETHR_GPIO_RST	7
 
+/*
+ * OMAP35x EVM revision
+ * Run time detection of EVM revision is done by reading Ethernet
+ * PHY ID -
+ *	GEN_1	= 0x01150000
+ *	GEN_2	= 0x92200000
+ */
+enum {
+	OMAP3EVM_BOARD_GEN_1 = 0,	/* EVM Rev between  A - D */
+	OMAP3EVM_BOARD_GEN_2,		/* EVM Rev >= Rev E */
+};
+
 static u8 omap3_evm_version;
 
 u8 get_omap3_evm_rev(void)
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index e6a8d79..db3bdc1 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -14,18 +14,6 @@
 
 #include <plat/gpio-switch.h>
 
-/*
- * OMAP35x EVM revision
- * Run time detection of EVM revision is done by reading Ethernet
- * PHY ID -
- *	GEN_1	= 0x01150000
- *	GEN_2	= 0x92200000
- */
-enum {
-	OMAP3EVM_BOARD_GEN_1 = 0,	/* EVM Rev between  A - D */
-	OMAP3EVM_BOARD_GEN_2,		/* EVM Rev >= Rev E */
-};
-
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
 #define OMAP_TAG_GPIO_SWITCH	0x4f06
@@ -125,10 +113,4 @@ extern int omap_board_config_size;
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
 
-/* OMAP3EVM revision */
-#if defined(CONFIG_MACH_OMAP3EVM)
-u8 get_omap3_evm_rev(void);
-#else
-#define get_omap3_evm_rev() (-EINVAL)
-#endif
 #endif
-- 
1.7.8.6
