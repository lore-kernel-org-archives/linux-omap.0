From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Re: omap mmc build errors
Date: Tue, 11 Apr 2006 09:22:20 -0400
Message-ID: <443BAD8C.4090005@indt.org.br>
References: <20060410212657.90862.qmail@web32905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050600000806090905070606"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060410212657.90862.qmail@web32905.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050600000806090905070606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ext Komal Shah wrote:

>Well, latest OMAP MMC driver even doesn't build for H4. 
>
>drivers/mmc/omap.c: In function `mmc_omap_xfer_data':
>drivers/mmc/omap.c:343: warning: unused variable `reg'
>drivers/mmc/omap.c:344: warning: unused variable `p'
>drivers/mmc/omap.c:1227:30: unterminated argument list invoking macro
>"dev_err"
>drivers/mmc/omap.c: In function `mmc_omap_dma_cb':
>drivers/mmc/omap.c:661: error: `dev_err' undeclared (first use in this
>function)
>drivers/mmc/omap.c:661: error: (Each undeclared identifier is reported
>only once
>drivers/mmc/omap.c:661: error: for each function it appears in.)
>drivers/mmc/omap.c:661: error: syntax error at end of input
>drivers/mmc/omap.c:658: warning: unused variable `mmcdat'
>drivers/mmc/omap.c:111: warning: 'dev_attr_cover_switch' defined but
>not used
>drivers/mmc/omap.c:140: warning: 'dev_attr_enable_poll' defined but not
>used
>drivers/mmc/omap.c:265: warning: 'mmc_omap_dma_timer' defined but not
>used
>drivers/mmc/omap.c:275: warning: 'mmc_omap_dma_done' defined but not
>used
>drivers/mmc/omap.c:383: warning: 'mmc_omap_irq' defined but not used
>drivers/mmc/omap.c:520: warning: 'mmc_omap_switch_irq' defined but not
>used
>drivers/mmc/omap.c:529: warning: 'mmc_omap_switch_timer' defined but
>not used
>drivers/mmc/omap.c:538: warning: 'mmc_omap_switch_callback' defined but
>not used
>drivers/mmc/omap.c:542: warning: 'mmc_omap_switch_handler' defined but
>not used
>drivers/mmc/omap.c:576: warning: 'mmc_omap_prepare_dma' defined but not
>used
>drivers/mmc/omap.c:656: warning: 'mmc_omap_dma_cb' defined but not used
>make[2]: *** [drivers/mmc/omap.o] Error 1
>make[1]: *** [drivers/mmc] Error 2
>make: *** [drivers] Error 2
>
>Even platform_get_irq is incorrect no. of arguments :). 
>
>---Komal Shah
>http://komalshah.blogspot.com/
>
>__________________________________________________
>Do You Yahoo!?
>Tired of spam?  Yahoo! Mail has the best spam protection around 
>http://mail.yahoo.com 
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>  
>
Hi Komal and folks,

You have to apply a patch that Tony sent to the list 7 days ago. This 
patch corrects the bugs mentioned above. Attached to this mail follow 
the patch.

Try this please.

BR,

Carlos.

-- 
Carlos Eduardo
Software Engineer
Nokia Institute of Technology - INdT
Embedded Linux Laboratory - 10LE
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br


--------------050600000806090905070606
Content-Type: text/plain;
 name="patch-omap-mmc-fixes"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-omap-mmc-fixes"

diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index becb3c6..197fa3b 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -61,6 +63,7 @@ struct mmc_omap_host {
 	unsigned char		id; /* 16xx chips have 2 MMC blocks */
 	struct clk *		iclk;
 	struct clk *		fclk;
+	struct resource		*res;
 	void __iomem		*base;
 	int			irq;
 	unsigned char		bus_mode;
@@ -973,20 +976,20 @@ static int __init mmc_omap_probe(struct 
 	struct omap_mmc_conf *minfo = pdev->dev.platform_data;
 	struct mmc_host *mmc;
 	struct mmc_omap_host *host = NULL;
+	struct resource *r;
 	int ret = 0;
+	int irq;
 	
-	if (platform_get_resource(pdev, IORESOURCE_MEM, 0) ||
-			platform_get_irq(pdev, IORESOURCE_IRQ, 0)) {
-		dev_err(&pdev->dev, "mmc_omap_probe: invalid resource type\n");
-		return -ENODEV;
-	}
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (!r || irq < 0)
+		return -ENXIO;
 
-	if (!request_mem_region(pdev->resource[0].start,
+	r = request_mem_region(pdev->resource[0].start,
 				pdev->resource[0].end - pdev->resource[0].start + 1,
-				pdev->name)) {
-		dev_dbg(&pdev->dev, "request_mem_region failed\n");
+			       pdev->name);
+	if (!r)
 		return -EBUSY;
-	}
 
 	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
 	if (!mmc) {
@@ -1003,6 +1006,8 @@ static int __init mmc_omap_probe(struct 
 	host->dma_timer.data = (unsigned long) host;
 
 	host->id = pdev->id;
+	host->res = r;
+	host->irq = irq;
 
 	if (cpu_is_omap24xx()) {
 		host->iclk = clk_get(&pdev->dev, "mmc_ick");
@@ -1032,7 +1037,7 @@ static int __init mmc_omap_probe(struct 
 	host->dma_ch = -1;
 
 	host->irq = pdev->resource[1].start;
-	host->base = ioremap(pdev->res.start, SZ_4K);
+	host->base = ioremap(r->start, SZ_4K);
 	if (!host->base) {
 		ret = -ENOMEM;
 		goto out;
@@ -1100,7 +1105,7 @@ static int __init mmc_omap_probe(struct 
 				device_remove_file(&pdev->dev, &dev_attr_cover_switch);
 		}
 		if (ret) {
-			dev_wan(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
+			dev_warn(mmc_dev(host->mmc), "Unable to create sysfs attributes\n");
 			free_irq(OMAP_GPIO_IRQ(host->switch_pin), host);
 			omap_free_gpio(host->switch_pin);
 			host->switch_pin = -1;

--------------050600000806090905070606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050600000806090905070606--
