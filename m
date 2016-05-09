From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 5/6] ARM: OMAP2+: Remove legacy sram init code for omap3
 platforms
Date: Mon, 9 May 2016 16:49:25 -0500
Message-ID: <1462830566-28708-6-git-send-email-d-gerlach@ti.com>
References: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1462830566-28708-1-git-send-email-d-gerlach@ti.com>
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
Cc: Tony Lindgren <tony@atomide.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Remove omap3 platforms from using legacy sram init code in mach-omap2 as
the platforms will now use the generic mmio-sram driver like other omap
platforms already do.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index a935d28443da..1a5b8afdb2e3 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -579,8 +579,7 @@ void __init pdata_quirks_init(const struct of_device_id *omap_dt_match_table)
 	 * We still need this for omap2420 and omap3 PM to work, others are
 	 * using drivers/misc/sram.c already.
 	 */
-	if (of_machine_is_compatible("ti,omap2420") ||
-	    of_machine_is_compatible("ti,omap3"))
+	if (of_machine_is_compatible("ti,omap2420"))
 		omap_sdrc_init(NULL, NULL);
 
 	pdata_quirks_check(auxdata_quirks);
-- 
2.7.3
