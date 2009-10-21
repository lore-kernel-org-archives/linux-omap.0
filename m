From: Ladislav.Michl@seznam.cz
Subject: Re: mmci-omap regressions
Date: Wed, 21 Oct 2009 23:15:07 +0200
Message-ID: <20091021211506.GA6498@localhost.localdomain>
References: <20090112091721.GA11921@michl.2n.cz> <20090112104242.GA9373@atomide.com>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:40134 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754172AbZJUTPV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 15:15:21 -0400
Content-Disposition: inline
In-Reply-To: <20090112104242.GA9373@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, juha.yrjola@nokia.com

Hmm, it seems noone is going to fix it for me, so let's move on...

On Mon, Jan 12, 2009 at 12:42:43PM +0200, Tony Lindgren wrote:
> Hi,
> 
> * Ladislav Michl <ladis@linux-mips.org> [090112 11:19]:
> > Last time I used MMC card with linux-2.6.15-omap2 and it worked pretty well on
> > my custom 5910 based board. Current git nor linux-2.6.22-omap1 (currently used
> > for production) doesn't work at all. Inspecting diff between 2.6.15-omap2 and
> > 2.6.22-omap1 showed that
> > --- a/drivers/mmc/host/omap.c	2009-01-12 09:32:23.000000000 +0100
> > +++ b/drivers/mmc/host/omap.c	2009-01-12 09:46:26.000000000 +0100
> > @@ -974,7 +974,7 @@
> >  	 * Writing to the CON register twice seems to do the trick. */
> >  	for (i = 0; i < 2; i++)
> >  		OMAP_MMC_WRITE(host, CON, dsor);
> > -	if (ios->power_mode == MMC_POWER_ON) {
> > +	if (ios->power_mode == MMC_POWER_UP) {
> >  		/* Send clock cycles, poll completion */
> >  		OMAP_MMC_WRITE(host, IE, 0);
> >  		OMAP_MMC_WRITE(host, STAT, 0xffff);
> > did the trick.
> > 
> > With above patch applied to 2.6.22-omap1 I got
> > # modprobe omap
> > mmci-omap mmci-omap.1: command timeout, CMD 8
> >  mmcblk0: mmc0:0001        127104KiB
> >  mmcblk0: p1
> > while there is no command timeout with 2.6.15-omap2, but at least it works.
> 
> OK, well at least that's a good start on figuring out what has broken
> it. It does not seem like the right fix though as the MMC_POWER_UP
> should just power up the slot, and clocks should not get turned on
> until in MMC_POWER_ON.
> 
> > Doing the same modification in current git doesn't help. Moreover removing
> > omap.ko and inserting again behaves differently than inserting for first
> > time:
> > # modprobe omap
> > mmci-omap mmci-omap.0: command timeout (CMD8)
> > mmci-omap mmci-omap.0: command timeout (CMD5)
> > mmci-omap mmci-omap.0: command timeout (CMD5)
> > mmci-omap mmci-omap.0: command timeout (CMD5)
> > mmci-omap mmci-omap.0: command timeout (CMD5)
> > mmci-omap mmci-omap.0: command timeout (CMD55)
> > mmci-omap mmci-omap.0: command timeout (CMD55)
> > mmci-omap mmci-omap.0: command timeout (CMD55)
> > mmci-omap mmci-omap.0: command timeout (CMD55)
> > mmc0: error -22 whilst initialising MMC card
> > # rmmod omap
> > # modprobe omap
> > mmci-omap: probe of mmci-omap.0 failed with error -16
> 
> Looks like the current git head does goto exit after MMC_POWER_UP before
> you even get to that code.
> 
> > I'll happily send any requested debug informations and test any patches
> 
> Can you maybe try to debug by applying your patch and commenting out
> the goto exit?

Here is somehow working version. It seems sending init stream multiple times
is not good idea. Please note I have no clue how is MMC supposed to work
(except very basic knowledge).

So with the patch (complete patch, see mmc driver fixes I posted earlier today)
below, output looks like:

# modprobe omap
MMC_POWER_OFF
MMC dsor: 0
MMC_POWER_UP
MMC_POWER_ON
MMC dsor: 878
time elapsed: 254us
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 878
mmci-omap mmci-omap.0: command timeout (CMD8)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD5)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
mmci-omap mmci-omap.0: command timeout (CMD55)
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 878
MMC_POWER_ON
MMC dsor: 803
mmc0: new MMC card at address 0001
mmcblk0: mmc0:0001 D0601 122 MiB
 mmcblk0:
 p1

Note, that "command timeout" is still there, but at least it detect card and
also note that "worst case at 400kHz, 80 cycles makes 200 microsecs" took
actually more than 200us.


diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5d773b8..0bcd6b0 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -123,15 +123,16 @@ struct mmc_omap_host {
 	struct mmc_data *	data;
 	struct mmc_host *	mmc;
 	struct device *		dev;
-	unsigned char		id; /* 16xx chips have 2 MMC blocks */
 	struct clk *		iclk;
 	struct clk *		fclk;
 	struct resource		*mem_res;
 	void __iomem		*virt_base;
 	unsigned int		phys_base;
 	int			irq;
+	unsigned char		id; /* 16xx chips have 2 MMC blocks */
 	unsigned char		bus_mode;
 	unsigned char		hw_bus_mode;
+	unsigned char		power_mode;
 
 	struct work_struct	cmd_abort_work;
 	unsigned		abort:1;
@@ -1233,7 +1234,7 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct mmc_omap_slot *slot = mmc_priv(mmc);
 	struct mmc_omap_host *host = slot->host;
 	int i, dsor;
-	int clk_enabled;
+	int clk_enabled, init_stream;
 
 	mmc_omap_select_slot(slot, 0);
 
@@ -1243,20 +1244,27 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		slot->vdd = ios->vdd;
 
 	clk_enabled = 0;
+	init_stream = 0;
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
+		printk("MMC_POWER_OFF\n");
 		mmc_omap_set_power(slot, 0, ios->vdd);
 		break;
 	case MMC_POWER_UP:
+		printk("MMC_POWER_UP\n");
 		/* Cannot touch dsor yet, just power up MMC */
 		mmc_omap_set_power(slot, 1, ios->vdd);
+		host->power_mode = ios->power_mode;
 		goto exit;
 	case MMC_POWER_ON:
+		printk("MMC_POWER_ON\n");
 		mmc_omap_fclk_enable(host, 1);
 		clk_enabled = 1;
-		dsor |= 1 << 11;
+		if (host->power_mode != MMC_POWER_ON)
+			init_stream = 1;
 		break;
 	}
+	host->power_mode = ios->power_mode;
 
 	if (slot->bus_mode != ios->bus_mode) {
 		if (slot->pdata->set_bus_mode != NULL)
@@ -1269,12 +1277,15 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 * goes somehow out of sync, and the POW bit is not being set,
 	 * which results in the while loop below getting stuck.
 	 * Writing to the CON register twice seems to do the trick. */
+	if (ios->power_mode == MMC_POWER_ON)
+		dsor |= 1 << 11;
+	printk("MMC dsor: %x\n", dsor);
 	for (i = 0; i < 2; i++)
 		OMAP_MMC_WRITE(host, CON, dsor);
 	slot->saved_con = dsor;
-	if (ios->power_mode == MMC_POWER_ON) {
+	if (init_stream) {
 		/* worst case at 400kHz, 80 cycles makes 200 microsecs */
-		int usecs = 250;
+		int usecs = 512;
 
 		/* Send clock cycles, poll completion */
 		OMAP_MMC_WRITE(host, IE, 0);
@@ -1285,8 +1296,8 @@ static void mmc_omap_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			usecs--;
 		}
 		OMAP_MMC_WRITE(host, STAT, 1);
+		printk("time elapsed: %dus\n", 512 - usecs);
 	}
-
 exit:
 	mmc_omap_release_slot(slot, clk_enabled);
 }
@@ -1445,6 +1456,7 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	host->id = pdev->id;
+	host->power_mode = -1;
 	host->mem_res = res;
 	host->irq = irq;
 
@@ -1459,8 +1471,10 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		goto err_ioremap;
 
 	host->iclk = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(host->iclk))
+	if (IS_ERR(host->iclk)) {
+		ret = PTR_ERR(host->iclk);
 		goto err_free_mmc_host;
+	}
 	clk_enable(host->iclk);
 
 	host->fclk = clk_get(&pdev->dev, "fck");
@@ -1500,10 +1514,8 @@ err_free_irq:
 err_free_fclk:
 	clk_put(host->fclk);
 err_free_iclk:
-	if (host->iclk != NULL) {
-		clk_disable(host->iclk);
-		clk_put(host->iclk);
-	}
+	clk_disable(host->iclk);
+	clk_put(host->iclk);
 err_free_mmc_host:
 	iounmap(host->virt_base);
 err_ioremap:
@@ -1529,6 +1541,7 @@ static int mmc_omap_remove(struct platform_device *pdev)
 		host->pdata->cleanup(&pdev->dev);
 
 	mmc_omap_fclk_enable(host, 0);
+	free_irq(host->irq, host);
 	clk_put(host->fclk);
 	clk_disable(host->iclk);
 	clk_put(host->iclk);

Hints and ideas welcome and appreciated :-)

Thanks,
	ladis
