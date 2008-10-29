From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] [ONENAND] Add command line partition support on OMAP driver
Date: Wed, 29 Oct 2008 11:12:02 +0900
Message-ID: <20081029021202.GA32306@july>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add command line partition support on OMAP driver

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index a9885d1..60cf668 100644
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -51,6 +51,10 @@
 #define ONENAND_IO_SIZE		SZ_128K
 #define ONENAND_BUFRAM_SIZE	(1024 * 5)
 
+#ifdef CONFIG_MTD_PARTITIONS
+static const char *part_probes[] = { "cmdlinepart", NULL,  };
+#endif
+
 struct omap2_onenand {
 	struct platform_device *pdev;
 	int gpmc_cs;
@@ -685,9 +689,12 @@ static int __devinit omap2_onenand_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_MTD_PARTITIONS
-	if (pdata->parts != NULL)
+	r = parse_mtd_partitions(&c->mtd, part_probes, &c->parts, 0);
+	if (r > 0)
+		r = add_mtd_partitions(&c->mtd, c->parts, r);
+	else if (pdata->parts != NULL)
 		r = add_mtd_partitions(&c->mtd, pdata->parts,
-				       pdata->nr_parts);
+				pdata->nr_parts);
 	else
 #endif
 		r = add_mtd_device(&c->mtd);

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
