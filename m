From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 01/15] ARM: OMAP3+: do not register non-dt OPP tables for
 device tree boot
Date: Wed, 9 Oct 2013 16:28:50 -0500
Message-ID: <1381354144-7134-2-git-send-email-nm@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381354144-7134-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP3+ supports both device tree and non-device tree boot.
Device tree bindings for OMAP3+ is supposed to be added via dts following:
Documentation/devicetree/bindings/power/opp.txt

Since we now have device tree entries for OMAP3+ cpu OPPs,
The current code wrongly adds duplicate OPPs. So, dont register OPPs
when booting using device tree.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/opp.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
index bd41d59..82fd8c7 100644
--- a/arch/arm/mach-omap2/opp.c
+++ b/arch/arm/mach-omap2/opp.c
@@ -17,6 +17,7 @@
  * GNU General Public License for more details.
  */
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/opp.h>
 #include <linux/cpu.h>
 
@@ -40,6 +41,9 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
 {
 	int i, r;
 
+	if (of_have_populated_dt())
+		return -EINVAL;
+
 	if (!opp_def || !opp_def_size) {
 		pr_err("%s: invalid params!\n", __func__);
 		return -EINVAL;
-- 
1.7.9.5
