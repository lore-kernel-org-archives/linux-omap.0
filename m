From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] [RFC-HACK] pinctrl-single: init by
 postcore_initcall()
Date: Thu, 22 May 2014 16:31:54 -0700
Message-ID: <20140522233154.GE29577@atomide.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
 <1400799986-20043-2-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41608 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbaEVXb7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 19:31:59 -0400
Content-Disposition: inline
In-Reply-To: <1400799986-20043-2-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Christoph Fritz <chf.fritz@googlemail.com> [140522 16:07]:
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -2069,7 +2069,22 @@ static struct platform_driver pcs_driver = {
>  #endif
>  };
>  
> +#ifdef CONFIG_USE_OF
> +static int __init pcs_driver_drv_init(void)
> +{
> +       return platform_driver_register(&pcs_driver);
> +}
> +postcore_initcall(pcs_driver_drv_init);
> +
> +static void __exit pcs_driver_drv_exit(void)
> +{
> +       platform_driver_unregister(&pcs_driver);
> +}
> +module_exit(pcs_driver_drv_exit);
> +#else
>  module_platform_driver(pcs_driver);
> +#endif
> +

I would prefer to initialize all the drivers with module_init
and and if necessary, selected frameworks with subsys_initcall. 

In drivers/Makefile we do have painctrl before gpio, so this
too could be just module_init once the other drivers are fixed.

Regards,

Tony
