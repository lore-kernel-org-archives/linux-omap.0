From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/3] MMC: OMAP: HSMMC: Remove lazy_disable
Date: Wed, 22 Jun 2011 11:26:41 -0700
Message-ID: <87k4cdrace.fsf@ti.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:54917 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758481Ab1FVS0p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 14:26:45 -0400
In-Reply-To: <1308752314-32079-2-git-send-email-balajitk@ti.com> (Balaji
	T. K.'s message of "Wed, 22 Jun 2011 19:48:32 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com

Balaji T K <balajitk@ti.com> writes:

> lazy_disable framework in OMAP HSMMC manages multiple low power states
> and Card is powered off after inactivity time of 8 seconds.
> Based on previous discussion on the list Card power(regulator)

needs some punctuation for readability.

> handling (when to power OFF/ON) should ideally be handled by core layer.

So are you working on the core layer replacement for this?  If not, is
there a plan or owner for this?

> Remove usage of lazy disable to allow core layer _only_ to handle card power.
> With the removal of lazy disable framework, MMC regulators
> are left ON until MMC_POWER_OFF via set_ios.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

[...]

> @@ -2080,10 +1848,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, host);
>  	INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
>  
> -	if (mmc_slot(host).power_saving)
> -		mmc->ops	= &omap_hsmmc_ps_ops;
> -	else
> -		mmc->ops	= &omap_hsmmc_ops;
> +	mmc->ops	= &omap_hsmmc_ops;

I guess the _ps_ops struct is now completely unused so should probably
be removed in this patch also.

Kevin

