From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0105/1529] Fix typo
Date: Sat, 21 May 2016 13:50:13 +0200
Message-ID: <20160521115013.4816-1-andrea.gelmini@gelma.net>
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
To: andrea.gelmini@gelma.net
Cc: tony@atomide.com, linux-omap@vger.kernel.org, trivial@kernel.org, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/mux34xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
index be271f1..393e687 100644
--- a/arch/arm/mach-omap2/mux34xx.c
+++ b/arch/arm/mach-omap2/mux34xx.c
@@ -1266,7 +1266,7 @@ static struct omap_ball __initdata omap3_cus_ball[] = {
 #endif
 
 /*
- * Signals different on CBB package comapared to superset
+ * Signals different on CBB package compared to superset
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBB)
 static struct omap_mux __initdata omap3_cbb_subset[] = {
@@ -1597,7 +1597,7 @@ static struct omap_ball __initdata omap3_cbb_ball[] = {
 #endif
 
 /*
- * Signals different on 36XX CBP package comapared to 34XX CBC package
+ * Signals different on 36XX CBP package compared to 34XX CBC package
  */
 #if defined(CONFIG_OMAP_MUX) && defined(CONFIG_OMAP_PACKAGE_CBP)
 static struct omap_mux __initdata omap36xx_cbp_subset[] = {
-- 
2.8.2.534.g1f66975
