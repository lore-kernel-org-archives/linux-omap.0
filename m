From: Tony Lindgren <tony@atomide.com>
Subject: Re: MMC broken on beagleboard with current git
Date: Tue, 30 Sep 2008 15:58:39 +0300
Message-ID: <20080930125838.GA15828@atomide.com>
References: <FDAFB709-68B8-478D-8321-1322449B9A7F@student.utwente.nl> <20080925085142.GC5222@atomide.com> <77EE6A0D-895B-4E0B-B9C4-18D333BFF85C@student.utwente.nl> <20080925094718.GE5222@atomide.com> <4D346DA2-6C57-48A7-AC4E-2191C44497CF@student.utwente.nl> <20080925103952.GJ5222@atomide.com> <5e088bd90809250824q38fb95e0q7a9e3f8a24a4d845@mail.gmail.com> <20080926074208.GC7962@atomide.com> <20080926111351.GA8736@atomide.com> <20080928124641.GB8254@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5G06lTa6Jq83wMTw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59125 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbYI3Mzr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 08:55:47 -0400
Content-Disposition: inline
In-Reply-To: <20080928124641.GB8254@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [080928 15:44]:
> * Tony Lindgren <tony@atomide.com> [080926 14:11]:
> > * Tony Lindgren <tony@atomide.com> [080926 10:40]:
> > > * Steve Sakoman <sakoman@gmail.com> [080925 18:24]:
> > > > On Thu, Sep 25, 2008 at 3:39 AM, Tony Lindgren <tony@atomide.com> wrote:
> > > > 
> > > > > Hmm, I don't understand how it could work on 3430sdp...
> > > > >
> > > > > Looks like board-omap3beagle.c calls hsmmc_init() just like
> > > > > board-3430sdp.c. Maybe timings have changed and you need
> > > > > a longer delay somewhere during the init?
> > > > 
> > > > I can confirm that mmc is also broken on Overo.  I'll spend some time
> > > > today investigating.
> > > 
> > > I'll double check on omap3430sdp.
> > 
> > Hmm, MMC does not seem to work any longer on 3430sdp either. I guess I
> > have broken it, sorry.
> > 
> > I've also confirmed that undoing c434c15d28c82d92e55897bd265c423e9ab69362
> > makes it work again.
> > 
> > I swear it was working when I last tested it.. I'll try to debug it
> > further, but I may not get to it for real until on Monday.
> > 
> > I still suspect some timing change caused by the init changes..
> 
> I've reverted c434c15d28c82d92e55897bd265c423e9ab69362 as I may not be
> able to debug it until Wednesday.

OK, found the problem, here's a diff on top of the currently reverted
patch. I've pushed the MMC changes with this fix merged in, can you
guys try it out now?

Regards,

Tony

--5G06lTa6Jq83wMTw
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-mmc-init.patch"

>From c5e72c31fe23a139aabab1ab6c63c2c3a3aad46f Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 30 Sep 2008 12:03:42 +0300
Subject: [PATCH] Fix new MMC init code for hsmmc, and for 2430

The reason the new MMC init code did not work on 34xx was the
_DEVID defines in omap_hsmmc.c. Fix these for now and add a comment
about doing that with platform_data and controller and slot specific
functions.

Fix device id's for omap1, and add a late init function for the tps
interrupt. Looks like omap1 MMC still does not work though.

Change omap2430 mmchs clock id's to start from 0, as the first
MMC instance is now 0.

Also add a comment to clarify the difference between a slot and a
controller.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index 4fbe367..4cc2d4f 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -33,6 +33,24 @@ static int mmc_set_power(struct device *dev, int slot, int power_on,
 	return 0;
 }
 
+static int mmc_late_init(struct device *dev)
+{
+	int ret;
+
+	ret = gpio_request(H2_TPS_GPIO_MMC_PWR_EN, "MMC power");
+	if (ret < 0)
+		return ret;
+
+	gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 0);
+
+	return ret;
+}
+
+static void mmc_shutdown(struct device *dev)
+{
+	gpio_free(H2_TPS_GPIO_MMC_PWR_EN);
+}
+
 /*
  * H2 could use the following functions tested:
  * - mmc_get_cover_state that uses OMAP_MPUIO(1)
@@ -40,6 +58,8 @@ static int mmc_set_power(struct device *dev, int slot, int power_on,
  */
 static struct omap_mmc_platform_data mmc1_data = {
 	.nr_slots                       = 1,
+	.init				= mmc_late_init,
+	.shutdown			= mmc_shutdown,
 	.dma_mask			= 0xffffffff,
 	.slots[0]       = {
 		.set_power              = mmc_set_power,
@@ -53,13 +73,6 @@ static struct omap_mmc_platform_data *mmc_data[OMAP16XX_NR_MMC];
 
 void __init h2_mmc_init(void)
 {
-	int ret;
-
-	ret = gpio_request(H2_TPS_GPIO_MMC_PWR_EN, "MMC power");
-	if (ret < 0)
-		return;
-	gpio_direction_output(H2_TPS_GPIO_MMC_PWR_EN, 0);
-
 	mmc_data[0] = &mmc1_data;
 	omap1_init_mmc(mmc_data, OMAP16XX_NR_MMC);
 }
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 2900a4a..8bf70cf 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -2727,7 +2727,6 @@ static struct clk usbhs_ick = {
 
 static struct clk mmchs1_ick = {
 	.name		= "mmchs_ick",
-	.id		= 1,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
@@ -2740,7 +2739,6 @@ static struct clk mmchs1_ick = {
 
 static struct clk mmchs1_fck = {
 	.name		= "mmchs_fck",
-	.id		= 1,
 	.parent		= &func_96m_ck,
 	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
@@ -2752,7 +2750,7 @@ static struct clk mmchs1_fck = {
 
 static struct clk mmchs2_ick = {
 	.name		= "mmchs_ick",
-	.id		= 2,
+	.id		= 1,
 	.parent		= &l4_ck,
 	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X | WAIT_READY,
@@ -2765,7 +2763,7 @@ static struct clk mmchs2_ick = {
 
 static struct clk mmchs2_fck = {
 	.name		= "mmchs_fck",
-	.id		= 2,
+	.id		= 1,
 	.parent		= &func_96m_ck,
 	.prcm_mod	= CORE_MOD,
 	.flags		= CLOCK_IN_OMAP243X,
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 086e6de..c6544d2 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1015,7 +1015,7 @@ static int mmc_omap_get_dma_channel(struct mmc_omap_host *host, struct mmc_data
 	}
 
 	if (is_read) {
-		if (host->id == 1) {
+		if (host->id == 0) {
 			sync_dev = OMAP_DMA_MMC_RX;
 			dma_dev_name = "MMC1 read";
 		} else {
@@ -1023,7 +1023,7 @@ static int mmc_omap_get_dma_channel(struct mmc_omap_host *host, struct mmc_data
 			dma_dev_name = "MMC2 read";
 		}
 	} else {
-		if (host->id == 1) {
+		if (host->id == 0) {
 			sync_dev = OMAP_DMA_MMC_TX;
 			dma_dev_name = "MMC1 write";
 		} else {
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index cf3cb36..9a007ca 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -87,17 +87,25 @@
 #define SRC			(1 << 25)
 #define SRD			(1 << 26)
 
-#define OMAP_MMC1_DEVID		1
-#define OMAP_MMC2_DEVID		2
+/*
+ * FIXME: Most likely all the data using these _DEVID defines should come
+ * from the platform_data, or implemented in controller and slot specific
+ * functions.
+ */
+#define OMAP_MMC1_DEVID		0
+#define OMAP_MMC2_DEVID		1
+
 #define OMAP_MMC_DATADIR_NONE	0
 #define OMAP_MMC_DATADIR_READ	1
 #define OMAP_MMC_DATADIR_WRITE	2
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
 #define DRIVER_NAME		"mmci-omap"
+
 /*
- * slot_id is device id - 1, device id is a static value
- * of 1 to represent device 1 etc..
+ * One controller can have multiple slots, like on some omap boards using
+ * omap.c controller driver. Luckily this is not currently done on any known
+ * omap_hsmmc.c device.
  */
 #define mmc_slot(host)		(host->pdata->slots[host->slot_id])
 

--5G06lTa6Jq83wMTw--
