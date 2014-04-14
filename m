From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 10/15] bus: omap_l3_noc: remove iclk from omap_l3 struct
Date: Mon, 14 Apr 2014 11:25:21 -0500
Message-ID: <1397492726-17203-12-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397492726-17203-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

we do not use iclk directly anymore. And, even if we had to, we
should be using pm_runtime APIs to do the same to be completely SoC
independent.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/bus/omap_l3_noc.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
index a1931e8..573e40f 100644
--- a/drivers/bus/omap_l3_noc.h
+++ b/drivers/bus/omap_l3_noc.h
@@ -142,7 +142,6 @@ static struct l3_target_data *l3_targ[L3_MODULES] = {
 
 struct omap_l3 {
 	struct device *dev;
-	struct clk *ick;
 
 	/* memory base */
 	void __iomem *l3_base[L3_MODULES];
-- 
1.7.9.5
