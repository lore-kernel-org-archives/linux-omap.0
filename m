From: Jeremy Vial <jvial@adeneo-embedded.com>
Subject: [PATCH 2/2] ARM: OMAP3: Fix coding style problems in
 arch/arm/mach-omap2/control.c
Date: Thu, 31 Jul 2014 15:10:34 +0200
Message-ID: <1406812234-23163-3-git-send-email-jvial@adeneo-embedded.com>
References: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1406812234-23163-1-git-send-email-jvial@adeneo-embedded.com>
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
Cc: linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Signed-off-by: Jeremy Vial <jvial@adeneo-embedded.com>
---
 arch/arm/mach-omap2/control.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index acadac0..cc5d767 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -281,6 +281,7 @@ void omap3_clear_scratchpad_contents(void)
 	u32 max_offset = OMAP343X_SCRATCHPAD_ROM_OFFSET;
 	void __iomem *v_addr;
 	u32 offset = 0;
+
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
 	if (omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
 	    OMAP3430_GLOBAL_COLD_RST_MASK) {
@@ -475,7 +476,6 @@ void omap3_control_save_context(void)
 	control_context.csi = omap_ctrl_readl(OMAP343X_CONTROL_CSI);
 	control_context.padconf_sys_nirq =
 		omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
-	return;
 }
 
 void omap3_control_restore_context(void)
@@ -533,7 +533,6 @@ void omap3_control_restore_context(void)
 	omap_ctrl_writel(control_context.csi, OMAP343X_CONTROL_CSI);
 	omap_ctrl_writel(control_context.padconf_sys_nirq,
 			 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
-	return;
 }
 
 void omap3630_ctrl_disable_rta(void)
-- 
1.7.9.5
