From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Fri, 19 Apr 2013 16:53:28 +0200
Message-ID: <1366383208.3928.144.camel@mars>
References: <1366311829.4085.90.camel@mars>  <51704C05.4030200@ti.com>
	 <1366316595.4085.113.camel@mars>  <5170738F.8050305@ti.com>
	 <1366325282.4232.6.camel@lovely> <51708097.6070102@ti.com>
	 <51708131.2040208@ti.com>  <1366362081.3928.18.camel@mars>
	 <1366372957.3928.104.camel@mars>  <51714E0D.7020304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:51779 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030770Ab3DSOxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Apr 2013 10:53:34 -0400
Received: by mail-bk0-f42.google.com with SMTP id jc3so1765914bkc.15
        for <linux-omap@vger.kernel.org>; Fri, 19 Apr 2013 07:53:32 -0700 (PDT)
In-Reply-To: <51714E0D.7020304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org

On Fri, 2013-04-19 at 09:00 -0500, Jon Hunter wrote:
> On 04/19/2013 07:02 AM, Christoph Fritz wrote:
> > so I hacked the missing values to omap2_nand_gpmc_retime():
> > 
> > From 8868823925441a824fe0d3143614482f25fb379b Mon Sep 17 00:00:00 2001
> > From: Christoph Fritz <chf.fritz@googlemail.com>
> > Date: Fri, 19 Apr 2013 12:41:11 +0200
> > Subject: [PATCH] [RFC] ARM: OMAP2+: nand: add missing gpmc timing values
> > 
> > This patch adds missing gpmc timing values to omap2_nand_gpmc_retime().
> > ---
> >  arch/arm/mach-omap2/gpmc-nand.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> > index d9c2719..d8bb241 100644
> > --- a/arch/arm/mach-omap2/gpmc-nand.c
> > +++ b/arch/arm/mach-omap2/gpmc-nand.c
> > @@ -58,6 +58,9 @@ static int omap2_nand_gpmc_retime(
> >  	/* Read */
> >  	t.adv_rd_off = gpmc_t->adv_rd_off;
> >  	t.oe_on  = t.adv_on;
> > +	if (cpu_is_omap34xx()) {
> > +		t.oe_on = gpmc_t->oe_on;
> > +	}
> 
> How about just setting gpmc,adv-on-ns, then you don't need the above.
> 
> >  	t.access = gpmc_t->access;
> >  	t.oe_off = gpmc_t->oe_off;
> >  	t.cs_rd_off = gpmc_t->cs_rd_off;
> > @@ -69,11 +72,18 @@ static int omap2_nand_gpmc_retime(
> >  	if (cpu_is_omap34xx()) {
> 
> We should get rid of cpu_is_omap34xx() here as this is handled by
> gpmc_cs_set_timings().
> 
> >  		t.wr_data_mux_bus = gpmc_t->wr_data_mux_bus;
> >  		t.wr_access = gpmc_t->wr_access;
> > +		t.we_on = gpmc_t->we_on;
> 
> How about just setting gpmc,adv-on-ns, then you don't need the above.
> 
> >  	}
> >  	t.we_off = gpmc_t->we_off;
> >  	t.cs_wr_off = gpmc_t->cs_wr_off;
> >  	t.wr_cycle = gpmc_t->wr_cycle;
> >  
> > +	if (cpu_is_omap34xx()) {
> > +		t.bool_timings = gpmc_t->bool_timings;
> > +		t.cycle2cycle_delay = gpmc_t->cycle2cycle_delay;
> > +		t.page_burst_access = gpmc_t->page_burst_access;
> > +	}
> 
> The above timings are applicable to all gpmc versions and so you should
> not need to make this dependent on cpu_is_omap34xx(). So would be
> worthwhile spending a patch to add the above timings to this function.

Before sending this patch, I'd like to get your opinion on this
approach:

>From 015f1e8006f8f85818b6bbd5ba00dc6b4ae48b65 Mon Sep 17 00:00:00 2001
From: Christoph Fritz <chf.fritz@googlemail.com>
Date: Fri, 19 Apr 2013 12:41:11 +0200
Subject: [RFC][PATCH] ARM: OMAP2+: nand: reorganize gpmc timing values

This patch removes omap2_nand_gpmc_retime() which was used to quirk
some timing values before gpmc_cs_set_timings(). Due to recent changes,
gpmc_cs_set_timings() has evolved so that there is no more need for
omap2_nand_gpmc_retime().

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |   40 +--------------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index d9c2719..c8044b0 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -43,44 +43,6 @@ static struct platform_device gpmc_nand_device = {
 	.resource	= gpmc_nand_resource,
 };
 
-static int omap2_nand_gpmc_retime(
-				struct omap_nand_platform_data *gpmc_nand_data,
-				struct gpmc_timings *gpmc_t)
-{
-	struct gpmc_timings t;
-	int err;
-
-	memset(&t, 0, sizeof(t));
-	t.sync_clk = gpmc_t->sync_clk;
-	t.cs_on = gpmc_t->cs_on;
-	t.adv_on = gpmc_t->adv_on;
-
-	/* Read */
-	t.adv_rd_off = gpmc_t->adv_rd_off;
-	t.oe_on  = t.adv_on;
-	t.access = gpmc_t->access;
-	t.oe_off = gpmc_t->oe_off;
-	t.cs_rd_off = gpmc_t->cs_rd_off;
-	t.rd_cycle = gpmc_t->rd_cycle;
-
-	/* Write */
-	t.adv_wr_off = gpmc_t->adv_wr_off;
-	t.we_on  = t.oe_on;
-	if (cpu_is_omap34xx()) {
-		t.wr_data_mux_bus = gpmc_t->wr_data_mux_bus;
-		t.wr_access = gpmc_t->wr_access;
-	}
-	t.we_off = gpmc_t->we_off;
-	t.cs_wr_off = gpmc_t->cs_wr_off;
-	t.wr_cycle = gpmc_t->wr_cycle;
-
-	err = gpmc_cs_set_timings(gpmc_nand_data->cs, &t);
-	if (err)
-		return err;
-
-	return 0;
-}
-
 static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 {
 	/* support only OMAP3 class */
@@ -131,7 +93,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 				gpmc_get_client_irq(GPMC_IRQ_COUNT_EVENT);
 
 	if (gpmc_t) {
-		err = omap2_nand_gpmc_retime(gpmc_nand_data, gpmc_t);
+		err = gpmc_cs_set_timings(gpmc_nand_data->cs, gpmc_t);
 		if (err < 0) {
 			dev_err(dev, "Unable to set gpmc timings: %d\n", err);
 			return err;
-- 
1.7.10.4



