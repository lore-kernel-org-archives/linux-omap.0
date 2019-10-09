From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ARM: OMAP2+: pm33xx-core: make am43xx_get_rtc_base_addr static
Date: Wed,  9 Oct 2019 14:41:37 +0100
Message-ID: <20191009134137.28852-1-ben.dooks@codethink.co.uk>
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
To: linux-kernel@lists.codethink.co.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>
List-Id: linux-omap@vger.kernel.org

Make am43xx_get_rtc_base_addr as is not used outside of
this file. Fixes the following sparse warning:

arch/arm/mach-omap2/pm33xx-core.c:190:14: warning: symbol 'am43xx_get_rtc_base_addr' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-omap2/pm33xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index f11442ed3eff..05ad017796f8 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -187,7 +187,7 @@ static struct am33xx_pm_sram_addr *amx3_get_sram_addrs(void)
 		return NULL;
 }
 
-void __iomem *am43xx_get_rtc_base_addr(void)
+static void __iomem *am43xx_get_rtc_base_addr(void)
 {
 	rtc_oh = omap_hwmod_lookup("rtc");
 
-- 
2.23.0
