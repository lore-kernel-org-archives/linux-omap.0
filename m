From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap4: mmc: Fix the regulator resource for MMC2
Date: Tue, 6 Jul 2010 11:32:02 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECF34F@dbde02.ent.ti.com>
References: <1275062884-8584-1-git-send-email-santosh.shilimkar@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5AB0D35@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58303 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab0GFGCH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 02:02:07 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o666246C031549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Jul 2010 01:02:06 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5AB0D35@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>

ping 
> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Thursday, June 10, 2010 9:05 PM
> To: Shilimkar, Santosh; linux-omap@vger.kernel.org
> Cc: Nayak, Rajendra; Ghorai, Sukumar; Kadiyala, Kishore
> Subject: RE: [PATCH] omap4: mmc: Fix the regulator resource for MMC2
> 
> Tony,
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Friday, May 28, 2010 9:38 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Shilimkar, Santosh; Nayak, Rajendra; Ghorai, Sukumar; Kadiyala,
> Kishore
> > Subject: [PATCH] omap4: mmc: Fix the regulator resource for MMC2
> >
> > The MMC1 and MMC2 cards have seperate LDO supplies. Current code assumes
> > that they are powered by same LDO.
> >
> > This patch fixes the same and has VAUX1 as supply to MMC2 card.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> > Tested-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> > Tested with omap3_defconfig on OMAP4430SDP
> >
> Any comments on this one ??
> 
> >  arch/arm/mach-omap2/board-4430sdp.c |   12 ++++++++----
> >  1 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
> omap2/board-4430sdp.c
> > index 7a78986..f62042e 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -384,14 +384,16 @@ static struct omap2_hsmmc_info mmc[] = {
> >  	{}	/* Terminator */
> >  };
> >
> > -static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
> > +static struct regulator_consumer_supply sdp4430_vaux_supply[] = {
> >  	{
> >  		.supply = "vmmc",
> > -		.dev_name = "mmci-omap-hs.0",
> > +		.dev_name = "mmci-omap-hs.1",
> >  	},
> > +};
> > +static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
> >  	{
> >  		.supply = "vmmc",
> > -		.dev_name = "mmci-omap-hs.1",
> > +		.dev_name = "mmci-omap-hs.0",
> >  	},
> >  };
> >
> > @@ -447,6 +449,8 @@ static struct regulator_init_data sdp4430_vaux1 = {
> >  					| REGULATOR_CHANGE_MODE
> >  					| REGULATOR_CHANGE_STATUS,
> >  	},
> > +	.num_consumer_supplies  = 1,
> > +	.consumer_supplies      = sdp4430_vaux_supply,
> >  };
> >
> >  static struct regulator_init_data sdp4430_vaux2 = {
> > @@ -487,7 +491,7 @@ static struct regulator_init_data sdp4430_vmmc = {
> >  					| REGULATOR_CHANGE_MODE
> >  					| REGULATOR_CHANGE_STATUS,
> >  	},
> > -	.num_consumer_supplies  = 2,
> > +	.num_consumer_supplies  = 1,
> >  	.consumer_supplies      = sdp4430_vmmc_supply,
> >  };
> >
> > --
> > 1.6.0.4

