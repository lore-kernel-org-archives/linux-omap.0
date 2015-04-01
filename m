From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [rtc-linux] [PATCH 2/3] rtc: omap: Update Kconfig for OMAP RTC
Date: Wed, 1 Apr 2015 17:52:21 +0200
Message-ID: <20150401155221.GD20669@piout.net>
References: <1427867698-1326-1-git-send-email-lokeshvutla@ti.com>
 <1427867698-1326-3-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:60268 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753004AbbDAPw1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Apr 2015 11:52:27 -0400
Content-Disposition: inline
In-Reply-To: <1427867698-1326-3-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, lokeshvutla@ti.com

On 01/04/2015 at 11:24:57 +0530, Lokesh Vutla wrote :
> RTC is present in AM43xx and DRA7xx also. Updating the Kconfig
> to depend on ARCH_OMAP or ARCH_DAVINCI
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/rtc/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index b5b5c3d..40faf56 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1121,11 +1121,11 @@ config RTC_DRV_IMXDI
>  	   will be called "rtc-imxdi".
>  
>  config RTC_DRV_OMAP
> -	tristate "TI OMAP1"
> -	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
> +	tristate "TI OMAP Real Time Clock"
> +	depends on ARCH_OMAP || ARCH_DAVINCI
>  	help
>  	  Say "yes" here to support the on chip real time clock
> -	  present on TI OMAP1, AM33xx and DA8xx/OMAP-L13x.
> +	  present on TI OMAP1, AM33xx, DA8xx/OMAP-L13x, AM43xx and DRA7xx.
>  
>  	  This driver can also be built as a module, if so, module
>  	  will be called rtc-omap.
> -- 
> 1.9.1
> 
> -- 
> -- 
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> --- 
> You received this message because you are subscribed to the Google Groups "rtc-linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
