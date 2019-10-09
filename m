From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] ARM: OMAP2+: force iomem for omap_interconnect_sync
Date: Wed,  9 Oct 2019 14:39:02 +0100
Message-ID: <20191009133902.28405-1-ben.dooks@codethink.co.uk>
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
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Force the type of omap_interconnect_sync to avoid the
following sparse warnign:

arch/arm/mach-omap2/omap4-common.c:142:27: warning: incorrect type in assignment (different address spaces)
arch/arm/mach-omap2/omap4-common.c:142:27:    expected void [noderef] <asn:2> *static [toplevel] sram_sync
arch/arm/mach-omap2/omap4-common.c:142:27:    got void *

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
---
 arch/arm/mach-omap2/omap4-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 5c3845730dbf..d27c5f61d708 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -139,7 +139,7 @@ static int __init omap4_sram_init(void)
 		pr_warn("%s:Unable to get sram pool needed to handle errata I688\n",
 			__func__);
 	else
-		sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);
+		sram_sync = (void __force __iomem *)gen_pool_alloc(sram_pool, PAGE_SIZE);
 
 	return 0;
 }
-- 
2.23.0
