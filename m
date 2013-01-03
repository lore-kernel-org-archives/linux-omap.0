From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [PATCH] omap: am33xx-hwmod: Fix wrongly terminated
 am33xx_usbss_mpu_irqs array
Date: Fri,  4 Jan 2013 00:32:22 +0200
Message-ID: <1357252342-6166-1-git-send-email-panto@antoniou-consulting.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matt Porter <mporter@ti.com>, Russell King <linux@arm.linux.org.uk>, Pantelis Antoniou <panto@antoniou-consulting.com>, linux-kernel@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The IRQ array must be terminated by -1 and not by -1+OMAP_INTC_START
This led to having a resource list of 100s of IRQs.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 081c71e..e402303 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -2070,7 +2070,7 @@ static struct omap_hwmod_irq_info am33xx_usbss_mpu_irqs[] = {
 	{ .name = "usbss-irq", .irq = 17 + OMAP_INTC_START, },
 	{ .name = "musb0-irq", .irq = 18 + OMAP_INTC_START, },
 	{ .name = "musb1-irq", .irq = 19 + OMAP_INTC_START, },
-	{ .irq = -1 + OMAP_INTC_START, },
+	{ .irq = -1, },
 };
 
 static struct omap_hwmod am33xx_usbss_hwmod = {
-- 
1.7.12
