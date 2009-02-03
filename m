From: David Brownell <david-b@pacbell.net>
Subject: Re: hotplug problem in MMC due to GPIOlib
Date: Tue, 3 Feb 2009 08:28:56 -0800
Message-ID: <200902030828.56827.david-b@pacbell.net>
References: <003201c985f0$05f94fc0$LocalHost@wipultra796>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:27388 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751761AbZBCQ27 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Feb 2009 11:28:59 -0500
In-Reply-To: <003201c985f0$05f94fc0$LocalHost@wipultra796>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-omap@vger.kernel.org

On Tuesday 03 February 2009, kishore kadiyala wrote:
> Hi ,
> 
> On 3430 SDP , the MMC card insertion and removal is not working on the linux -omap tree !
> It seems like interrupts are  not getting  triggered on Card insertion & removal !
> 
> I wonder if it has to do something with GPIO library  !
> Also whether the GPIO library takes care of the requests to TWL4030 ?

I wonder if the patch I sent several weeks ago solves the bug
for you like it did for me ... fix worked on the sdp.

This gets resent soonish for mainline inclusion.

- Dave


=========== CUT HERE
From: David Brownell <dbrownell@users.sourceforge.net>

Work around lockdep issue when card detect IRQ handlers run in
thread context ... it forces IRQF_DISABLED, which prevents all
access to twl4030 card detect signals.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mmc/host/omap_hsmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -568,6 +568,9 @@ static void mmc_omap_detect(struct work_
 {
 	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
 						mmc_carddetect_work);
+	struct omap_mmc_slot_data *slot = &mmc_slot(host);
+
+	host->carddetect = slot->card_detect(slot->card_detect_irq);
 
 	sysfs_notify(&host->mmc->class_dev.kobj, NULL, "cover_switch");
 	mmc_omap_fclk_state(host, ON);
@@ -591,7 +594,6 @@ static irqreturn_t omap_mmc_cd_handler(i
 {
 	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
 
-	host->carddetect = mmc_slot(host).card_detect(irq);
 	schedule_work(&host->mmc_carddetect_work);
 
 	return IRQ_HANDLED;
