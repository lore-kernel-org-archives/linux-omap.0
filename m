From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 07/11] ARM: OMAP2+: prm44xx: make prm_{save,
 restore}_context static
Date: Tue,  8 Oct 2019 13:34:49 +0100
Message-ID: <20191008123453.1651-7-ben.dooks@codethink.co.uk>
References: <20191008123453.1651-1-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191008123453.1651-1-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@lists.codethink.co.uk, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
List-Id: linux-omap@vger.kernel.org

The prm_{save,restore}_context functions are not exported
so make them static to avoid the following warnings:

arch/arm/mach-omap2/prm44xx.c:748:6: warning: symbol 'prm_save_context' was not declared. Should it be static?
arch/arm/mach-omap2/prm44xx.c:759:6: warning: symbol 'prm_restore_context' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm44xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 1d9346f2a4ae..25093c1e5b9a 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -745,7 +745,7 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 
 static int omap44xx_prm_late_init(void);
 
-void prm_save_context(void)
+static void prm_save_context(void)
 {
 	omap_prm_context.irq_enable =
 			omap4_prm_read_inst_reg(AM43XX_PRM_OCP_SOCKET_INST,
@@ -756,7 +756,7 @@ void prm_save_context(void)
 						omap4_prcm_irq_setup.pm_ctrl);
 }
 
-void prm_restore_context(void)
+static void prm_restore_context(void)
 {
 	omap4_prm_write_inst_reg(omap_prm_context.irq_enable,
 				 OMAP4430_PRM_OCP_SOCKET_INST,
-- 
2.23.0
