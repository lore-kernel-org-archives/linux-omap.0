From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] twl4030-core: fix a typo
Date: Thu, 9 Oct 2008 19:07:22 +0300
Message-ID: <20081009160713.GA12091@frodo>
References: <EAF47CD23C76F840A9E7FCE10091EFAB028C6305D0@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52795 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbYJIQHa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 12:07:30 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB028C6305D0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On Thu, Oct 09, 2008 at 08:44:49PM +0530, Pakaravoor, Jagadeesh wrote:
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> Fix a trivial typo.

please Cc Samuel Ortiz <sameo@openedhand.com> and lkml


> Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> ---
> Index: linux-omap-git/drivers/mfd/twl4030-core.c
> ===================================================================
> --- linux-omap-git.orig/drivers/mfd/twl4030-core.c	2008-10-09 18:32:15.000000000 +0530
> +++ linux-omap-git/drivers/mfd/twl4030-core.c	2008-10-09 20:40:18.007239952 +0530
> @@ -57,7 +57,7 @@
>  #define DRIVER_NAME			"twl4030"
>  
>  #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
> -	defined(CONFIG_TWL4030_BCI_BATTERY_MODUEL)
> +	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
>  #define twl_has_bci()		true
>  #else
>  #define twl_has_bci()		false
> 
> --
> With Regards,
> Jagadeesh Bhaskar P
>  
> ----------------------------
> Some men see things as they are and say why - I dream things that never were and say why not.
> - George Bernard Shaw
> -------------------
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
