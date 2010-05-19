From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/22] OMAP4: hwmod: Replace OCPIF_HAS_IDLEST by
	HWMOD_NO_IDLEST
Date: Tue, 18 May 2010 20:18:42 -0600
Message-ID: <20100519021841.19716.47124.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Benoit Cousson <b-cousson@ti.com>

Some initiator modules in OMAP2 & 3 does not have IDLEST bit,
in that case we cannot detect the module readiness by
polling that bit and must exist the function immediately
assuming that the module is ready.

The previous flag was affected to the OCP interface. While it is
technically true that the idlest is related to the L4 slave
interface of the module, the PRCM status belong to the module.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 4a134c4..6459d07 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -808,7 +808,7 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 
 	os = *oh->slaves + oh->_mpu_port_index;
 
-	if (!(os->flags & OCPIF_HAS_IDLEST))
+	if (oh->flags & HWMOD_NO_IDLEST)
 		return 0;
 
 	/* XXX check module SIDLEMODE */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 4965bbe..0eccc09 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -176,9 +176,8 @@ struct omap_hwmod_addr_space {
 #define OCP_USER_SDMA			(1 << 1)
 
 /* omap_hwmod_ocp_if.flags bits */
-#define OCPIF_HAS_IDLEST		(1 << 0)
-#define OCPIF_SWSUP_IDLE		(1 << 1)
-#define OCPIF_CAN_BURST			(1 << 2)
+#define OCPIF_SWSUP_IDLE		(1 << 0)
+#define OCPIF_CAN_BURST			(1 << 1)
 
 /**
  * struct omap_hwmod_ocp_if - OCP interface data
@@ -351,6 +350,8 @@ struct omap_hwmod_omap4_prcm {
  *     when module is enabled, rather than the default, which is to
  *     enable autoidle
  * HWMOD_SET_DEFAULT_CLOCKACT: program CLOCKACTIVITY bits at startup
+ * HWMOD_NO_IDLEST : this module does not have idle status - this is the case
+ *     only for few initiator modules on OMAP2 & 3.
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -358,6 +359,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_INIT_NO_IDLE			(1 << 3)
 #define HWMOD_NO_OCP_AUTOIDLE			(1 << 4)
 #define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 5)
+#define HWMOD_NO_IDLEST				(1 << 6)
 
 /*
  * omap_hwmod._int_flags definitions
