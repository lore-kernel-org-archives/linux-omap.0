From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: smsc911x: fix return value check in
 gpmc_smsc911x_init()
Date: Thu, 14 Nov 2013 10:41:08 -0800
Message-ID: <20131114184108.GP10317@atomide.com>
References: <CAPgLHd9V0=GHGYgfuL7cCkzmZT7HVzuNg0iwwsOcipbnJ90bVw@mail.gmail.com>
 <52761C55.5080609@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49534 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754588Ab3KNSlT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 13:41:19 -0500
Content-Disposition: inline
In-Reply-To: <52761C55.5080609@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, khilman@deeprootsystems.com, linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [131103 01:50]:
> On 10/25/13 11:31, Wei Yongjun wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > In case of error, the function platform_device_register_resndata()
> > returns ERR_PTR() and never returns NULL. The NULL test in the return
> > value check should be replaced with IS_ERR().
> > 
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks applying into omap-for-v3.13/fixes.

Tony
 
> > ---
> >  arch/arm/mach-omap2/gpmc-smsc911x.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
> > index ef99011..2757504 100644
> > --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
> > +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
> > @@ -83,7 +83,7 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *gpmc_cfg)
> >  	pdev = platform_device_register_resndata(NULL, "smsc911x", gpmc_cfg->id,
> >  		 gpmc_smsc911x_resources, ARRAY_SIZE(gpmc_smsc911x_resources),
> >  		 &gpmc_smsc911x_config, sizeof(gpmc_smsc911x_config));
> > -	if (!pdev) {
> > +	if (IS_ERR(pdev)) {
> >  		pr_err("Unable to register platform device\n");
> >  		gpio_free(gpmc_cfg->gpio_reset);
> >  		goto free2;
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> -- 
> Regards,
> Igor.
