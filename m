From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3 08/11] OMAP3: PM: Adding debug support to Voltage
 and Smartreflex drivers
Date: Thu, 14 Oct 2010 12:20:30 -0700
Message-ID: <1287084030.14514.145.camel@localhost>
References: <1285166719-19352-1-git-send-email-thara@ti.com>
	 <1285166719-19352-9-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39218 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab0JNV50 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Oct 2010 17:57:26 -0400
Received: by mail-vw0-f46.google.com with SMTP id 2so76279vws.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 14:57:26 -0700 (PDT)
In-Reply-To: <1285166719-19352-9-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

On Wed, 2010-09-22 at 20:15 +0530, Thara Gopinath wrote:
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -558,8 +558,13 @@ int sr_enable(struct voltagedomain *voltdm,
> unsigned long volt)
>                 return -ENODATA;
>         }
>  
> -       /* errminlimit is opp dependent and hence linked to voltage */
> -       sr->err_minlimit = volt_data->sr_errminlimit;
> +       /*
> +        * errminlimit is opp dependent and hence linked to voltage
> +        * if the debug option is enabled, the user might have over
> ridden
> +        * this parameter so do not get it from voltage table
> +        */

this comment needs better punctuation to be clearer

> +       if (!enable_sr_vp_debug)
> +               sr->err_minlimit = volt_data->sr_errminlimit;

Rather than checking if debug is enabled, you should create a flag
specific to whether this value was overwritten by the user, and use that
flag instead. 

Kevin


