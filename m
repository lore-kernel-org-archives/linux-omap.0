From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH -next] ARM: OMAP2+: devices: remove duplicated include
 from devices.c
Date: Thu, 4 Jul 2013 04:53:27 -0700
Message-ID: <20130704115327.GI5523@atomide.com>
References: <CAPgLHd9rXBA_QtQqOj4JbcFpfPoRTN5Ac9m9ofbP2PKVSmgANA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62710 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab3GDLxf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jul 2013 07:53:35 -0400
Content-Disposition: inline
In-Reply-To: <CAPgLHd9rXBA_QtQqOj4JbcFpfPoRTN5Ac9m9ofbP2PKVSmgANA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: linux@arm.linux.org.uk, yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Wei Yongjun <weiyj.lk@gmail.com> [130619 17:07]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks applying into omap-for-v3.11/fixes. Looks like the reboot.h
duplicate has already been removed.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/devices.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c0f99ab..8349238 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -15,7 +15,6 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/pinctrl/machine.h>


