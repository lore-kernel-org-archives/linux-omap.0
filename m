From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/17] ARM: OMAP2+: hwmod: parse also soc hierarchy for hwmod
 compatible nodes
Date: Thu, 24 Sep 2015 17:26:43 +0300
Message-ID: <1443104818-993-3-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Previously the code was only parsing ocp hierarchy, which misses mpu and
iva/dsp nodes at least, which still contain hwmod support. Parse also the
soc hierarchy to include these.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cc8a987..f53ebc6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2467,15 +2467,24 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 	if (of_have_populated_dt()) {
 		struct device_node *bus;
+		struct device_node *soc;
 
 		bus = of_find_node_by_name(NULL, "ocp");
 		if (!bus)
 			return -ENODEV;
 
 		r = of_dev_hwmod_lookup(bus, oh, &index, &np);
-		if (r)
-			pr_debug("omap_hwmod: %s missing dt data\n", oh->name);
-		else if (np && index)
+		if (r) {
+			soc = of_find_node_by_name(NULL, "soc");
+			if (soc)
+				r = of_dev_hwmod_lookup(soc, oh, &index, &np);
+
+			if (r)
+				pr_debug("omap_hwmod: %s missing dt data\n",
+					 oh->name);
+		}
+
+		if (np && index)
 			pr_warn("omap_hwmod: %s using broken dt data from %s\n",
 				oh->name, np->name);
 	}
-- 
1.7.9.5
