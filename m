From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Fixing build warning with omap3_defconfig
Date: Thu, 11 Mar 2010 14:23:53 -0800
Message-ID: <20100311222353.GO2900@atomide.com>
References: <1267527368-19690-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54952 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758552Ab0CKWWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 17:22:33 -0500
Content-Disposition: inline
In-Reply-To: <1267527368-19690-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org

* Anuj Aggarwal <anuj.aggarwal@ti.com> [100302 02:52]:
> Fixes the below build warning when compiled with omap3_defconfig:
> 
>   CC      arch/arm/mach-omap2/board-am3517evm.o
>   In file included from arch/arm/mach-omap2/board-am3517evm.c:23:
>   include/linux/i2c/pca953x.h:14: warning: 'struct i2c_client' declared
>   	inside parameter list
>   include/linux/i2c/pca953x.h:14: warning: its scope is only this definition
>   	or declaration, which is probably not what you want
>   include/linux/i2c/pca953x.h:17: warning: 'struct i2c_client' declared inside
>   	parameter list
>   CC      arch/arm/mach-omap2/usb-musb.o
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> ---
>  include/linux/i2c/pca953x.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/i2c/pca953x.h b/include/linux/i2c/pca953x.h
> index 81736d6..6c8f853 100644
> --- a/include/linux/i2c/pca953x.h
> +++ b/include/linux/i2c/pca953x.h
> @@ -1,4 +1,5 @@
>  /* platform data for the PCA9539 16-bit I/O expander driver */
> +#include <linux/i2c.h>
>  
>  struct pca953x_platform_data {
>  	/* number of the first GPIO */
> 

This needs to go via the I2C list.

Tony
