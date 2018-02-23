From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] bus: ti-sysc: Remove unnecessary debugging statements
Date: Fri, 23 Feb 2018 13:00:53 -0800
Message-ID: <20180223210100.86732-6-tony@atomide.com>
References: <20180223210100.86732-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180223210100.86732-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.coM>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We already show the status for the interconnect target module
when debugging is enabled, there's no need to be more verbose
about that. So let's just cut down the noise and remove the
extra debug statements.

Signed-off-by: Tony Lindgren <tony@atomide.coM>
---
 drivers/bus/ti-sysc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -201,9 +201,6 @@ static int sysc_parse_and_check_child_range(struct sysc *ddata)
 	ddata->module_pa = of_translate_address(np, ranges++);
 	ddata->module_size = be32_to_cpup(ranges);
 
-	dev_dbg(ddata->dev, "interconnect target 0x%llx size 0x%x for %pOF\n",
-		ddata->module_pa, ddata->module_size, np);
-
 	return 0;
 }
 
@@ -296,11 +293,8 @@ static int sysc_check_children(struct sysc *ddata)
  */
 static void sysc_check_quirk_16bit(struct sysc *ddata, struct resource *res)
 {
-	if (resource_size(res) == 8) {
-		dev_dbg(ddata->dev,
-			"enabling 16-bit and clockactivity quirks\n");
+	if (resource_size(res) == 8)
 		ddata->cfg.quirks |= SYSC_QUIRK_16BIT | SYSC_QUIRK_USE_CLOCKACT;
-	}
 }
 
 /**
@@ -326,7 +320,6 @@ static int sysc_parse_one(struct sysc *ddata, enum sysc_registers reg)
 	res = platform_get_resource_byname(to_platform_device(ddata->dev),
 					   IORESOURCE_MEM, name);
 	if (!res) {
-		dev_dbg(ddata->dev, "has no %s register\n", name);
 		ddata->offsets[reg] = -ENODEV;
 
 		return 0;
-- 
2.16.2
