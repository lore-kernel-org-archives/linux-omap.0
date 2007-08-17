From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: OMAP2 McSPI code cleanup
Date: Fri, 17 Aug 2007 16:48:40 +0900
Message-ID: <003901c7e0a3$08dc39d0$e1ac580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ARM: OMAP: OMAP2 McSPI code cleanup

Remove unused variable & write space

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
--
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 6b357cd..3cdab13 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -645,7 +645,7 @@ static int omap2_mcspi_setup(struct spi_device *spi)
 
 	clk_enable(mcspi->ick);
 	clk_enable(mcspi->fck);
-	ret =  omap2_mcspi_setup_transfer(spi, NULL);
+	ret = omap2_mcspi_setup_transfer(spi, NULL);
 	clk_disable(mcspi->fck);
 	clk_disable(mcspi->ick);
 
@@ -693,7 +693,6 @@ static void omap2_mcspi_work(struct work_struct *work)
 		struct spi_device		*spi;
 		struct spi_transfer		*t = NULL;
 		int				cs_active = 0;
-		struct omap2_mcspi_device_config *conf;
 		struct omap2_mcspi_cs		*cs;
 		int				par_override = 0;
 		int				status = 0;
@@ -706,7 +705,6 @@ static void omap2_mcspi_work(struct work_struct *work)
 		spin_unlock_irq(&mcspi->lock);
 
 		spi = m->spi;
-		conf = spi->controller_data;
 		cs = spi->controller_state;
 
 		omap2_mcspi_set_enable(spi, 1);
