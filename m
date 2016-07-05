From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 2/2] mtd: nand: omap2: Add check for old elm binding
Date: Tue, 5 Jul 2016 11:32:30 +0200
Message-ID: <1467711150-23356-2-git-send-email-t.remmet@phytec.de>
References: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

commit c9711ec5250b ("mtd: nand: omap: Clean up device tree support")
removes the check for the old elm phandle binding.
Add it again to keep backward compatibility.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 drivers/mtd/nand/omap2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 08e1588..d788663 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1658,7 +1658,9 @@ static int omap_get_dt_info(struct device *dev, struct omap_nand_info *info)
 	/* detect availability of ELM module. Won't be present pre-OMAP4 */
 	info->elm_of_node = of_parse_phandle(child, "ti,elm-id", 0);
 	if (!info->elm_of_node)
-		dev_dbg(dev, "ti,elm-id not in DT\n");
+		info->elm_of_node = of_parse_phandle(child, "elm_id", 0);
+		if (!info->elm_of_node)
+			dev_dbg(dev, "ti,elm-id not in DT\n");
 
 	/* select ecc-scheme for NAND */
 	if (of_property_read_string(child, "ti,nand-ecc-opt", &s)) {
-- 
1.9.1
