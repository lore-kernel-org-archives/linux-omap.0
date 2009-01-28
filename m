From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/10] omap mailbox: fix empty struct device for omap1
Date: Wed, 28 Jan 2009 14:49:55 +0000
Message-ID: <20090128144955.GA23089@n2100.arm.linux.org.uk>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com> <20090116082727.17571.87307.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58934 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZA1OuN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 09:50:13 -0500
Content-Disposition: inline
In-Reply-To: <20090116082727.17571.87307.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Fri, Jan 16, 2009 at 10:27:27AM +0200, Hiroshi DOYU wrote:
> @@ -17,6 +17,8 @@
>  #include <mach/mailbox.h>
>  #include <mach/irqs.h>
>  
> +#define DRV_NAME "omap1-mailbox"

I don't see any need for this define - it just adds an additional level of
indirection when trying to find out the name of the driver.  It's only
used in two places as is, so it's value is rather limited:

> @@ -184,9 +184,9 @@ static int omap1_mbox_remove(struct platform_device *pdev)
>  
>  static struct platform_driver omap1_mbox_driver = {
>  	.probe	= omap1_mbox_probe,
> -	.remove	= omap1_mbox_remove,
> +	.remove	= __devexit_p(omap1_mbox_remove),
>  	.driver	= {
> -		.name	= "mailbox",
> +		.name	= DRV_NAME,
>  	},
>  };
>  
> @@ -203,4 +203,7 @@ static void __exit omap1_mbox_exit(void)
>  module_init(omap1_mbox_init);
>  module_exit(omap1_mbox_exit);
>  
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("omap mailbox: omap1 architecture specific functions");
> +MODULE_AUTHOR("Hiroshi DOYU" <Hiroshi.DOYU@nokia.com>);
> +MODULE_ALIAS("platform:"DRV_NAME);
