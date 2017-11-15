From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v5 06/16] mtd: onenand: omap2: Remove partitioning support
 from platform data
Date: Wed, 15 Nov 2017 17:29:47 +0100
Message-ID: <20171115162947.kihbxurhogbd25hi@lenoch>
References: <20171115162306.2o2w2yrf7wucroxd@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171115162306.2o2w2yrf7wucroxd@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

No platform data user setups partitioning information, so remove.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Acked-by: Roger Quadros <rogerq@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- new patch

 drivers/mtd/onenand/omap2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 93bd94337b35..883993bbe40b 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -703,8 +703,7 @@ static int omap2_onenand_probe(struct platform_device *pdev)
 	if ((r = onenand_scan(&c->mtd, 1)) < 0)
 		goto err_release_dma;
 
-	r = mtd_device_register(&c->mtd, pdata ? pdata->parts : NULL,
-				pdata ? pdata->nr_parts : 0);
+	r = mtd_device_register(&c->mtd, NULL, 0);
 	if (r)
 		goto err_release_onenand;
 
-- 
2.11.0


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
