From: Tony Lindgren <tony@atomide.com>
Subject: Re: [TMP] OMAP3EVM: Test gpmc nand & smsc911x
Date: Wed, 25 Apr 2012 09:47:26 -0700
Message-ID: <20120425164726.GU3739@atomide.com>
References: <cover.1333640054.git.afzal@ti.com>
 <bb95fec60401f7cf6ac77200a12baf3fc83852f5.1333640054.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54951 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab2DYQrh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 12:47:37 -0400
Content-Disposition: inline
In-Reply-To: <bb95fec60401f7cf6ac77200a12baf3fc83852f5.1333640054.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: khilman@ti.com, linux@arm.linux.org.uk, dwmw2@infradead.org, sameo@linux.intel.com, grinberg@compulab.co.il, mike@compulab.co.il, nm@ti.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org

* Afzal Mohammed <afzal@ti.com> [120405 09:08]:
> @@ -114,6 +147,8 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
>  
>  static inline void __init omap3evm_init_smsc911x(void)
>  {
> +	struct gpmc_device_pdata *gpmc_smsc911x_info;
> +
>  	/* Configure ethernet controller reset gpio */
>  	if (cpu_is_omap3430()) {
>  		if (get_omap3_evm_rev() == OMAP3EVM_BOARD_GEN_1)
> @@ -122,7 +157,11 @@ static inline void __init omap3evm_init_smsc911x(void)
>  			smsc911x_cfg.gpio_reset = OMAP3EVM_GEN2_ETHR_GPIO_RST;
>  	}
>  
> -	gpmc_smsc911x_init(&smsc911x_cfg);
> +	gpmc_smsc911x_info = gpmc_smsc911x_init(&smsc911x_cfg);
> +	if (gpmc_smsc911x_info)
> +		*gpmc_data_cur++ = gpmc_smsc911x_info;
> +	else
> +		pr_err("error: unable to initilaize gpmc smsc911x\n");
>  }
>  
>  #else

Obviously we can't merge any of this if until all the board-*.c files
are changed and tested.

Can you maybe still keep the old interfaces in addition to the new ones
so we can do the conversion one board-*.c file at a time while keeping
things working?

Regards,

Tony
