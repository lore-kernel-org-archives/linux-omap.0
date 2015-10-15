From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 3/3] ARM: OMAP2: AM43XX: Modify optimize string comparisons
 in soc_is calls
Date: Thu, 15 Oct 2015 10:40:08 +0530
Message-ID: <1444885808-6306-4-git-send-email-j-keerthy@ti.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Currently everytime soc_is calls are made, firstly device tree nodes
are parsed and then string comparisons are made to determine the
soc version. Optimizing it to be done one time and store the result.
Use the stored value in all the subsequent checks for soc_is calls.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Rebased to latest 4.3-rc5
 
 arch/arm/mach-omap2/id.c  | 11 +++++++++++
 arch/arm/mach-omap2/soc.h | 10 ++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 4f497cc..0d7ccd3 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -61,6 +61,16 @@ void init_dra_soc_id(void)
 		soc_ids |= DRA72X;
 }
 
+void init_am43_soc_id(void)
+{
+	if (of_machine_is_compatible("ti,am43"))
+		soc_ids |= AM43XX;
+	if (of_machine_is_compatible("ti,am4372"))
+		soc_ids |= AM437X;
+	if (of_machine_is_compatible("ti,am438x"))
+		soc_ids |= AM438X;
+}
+
 int check_soc_version(unsigned long id)
 {
 	return soc_ids & id;
@@ -357,6 +367,7 @@ void __init omap3xxx_check_revision(void)
 	u16 hawkeye;
 	u8 rev;
 
+	init_am43_soc_id();
 	/*
 	 * We cannot access revision registers on ES1.0.
 	 * If the processor type is Cortex-A8 and the revision is 0x0
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 06d8c96..bf092d5 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -132,6 +132,9 @@
 #define DRA7XX				BIT(0)
 #define	DRA74X				BIT(1)
 #define DRA72X				BIT(2)
+#define AM43XX				BIT(3)
+#define AM437X				BIT(4)
+#define AM438X				BIT(5)
 
 int check_soc_version(unsigned long id);
 int omap_type(void);
@@ -266,6 +269,7 @@ IS_AM_SUBCLASS(437x, 0x437)
 #define soc_is_am335x()			0
 #define soc_is_am43xx()			0
 #define soc_is_am437x()			0
+#define soc_is_am438x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -441,8 +445,10 @@ IS_OMAP_TYPE(3430, 0x3430)
 #ifdef	CONFIG_SOC_AM43XX
 # undef soc_is_am43xx
 # undef soc_is_am437x
-# define soc_is_am43xx()		is_am43xx()
-# define soc_is_am437x()		is_am437x()
+# undef soc_is_am438x
+# define soc_is_am43xx()		check_soc_version(AM43XX)
+# define soc_is_am437x()		check_soc_version(AM437X)
+# define soc_is_am438x()		check_soc_version(AM438X)
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
-- 
1.9.1
