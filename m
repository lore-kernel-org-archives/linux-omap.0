From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Add more menelaus KConfig help.
Date: Thu, 21 Jun 2007 05:06:14 -0700
Message-ID: <20070621120613.GK20283@atomide.com>
References: <5d5443650706150452q7ff04dffp3da7f02d55dbf926@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650706150452q7ff04dffp3da7f02d55dbf926@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070615 04:58]:
> -- 
> --Trilok Soni

> From 5e83a70aa3b38ff44761dc26e5c05cf2998d984b Mon Sep 17 00:00:00 2001
> From: Trilok Soni <soni.trilok@gmail.com>
> Date: Sat, 26 May 2007 19:19:19 +0530
> Subject: [PATCH] ARM: OMAP: Add more menelaus KConfig help.
> 
> Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
> ---
>  drivers/i2c/chips/Kconfig |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
> index 9b62c3b..41e7fa1 100644
> --- a/drivers/i2c/chips/Kconfig
> +++ b/drivers/i2c/chips/Kconfig
> @@ -115,10 +115,14 @@ config GPIOEXPANDER_OMAP
>  	  to configure IrDA, Camera and audio devices.
>  
>  config MENELAUS
> -	bool "Menelaus PM chip"
> +	bool "TWL92330/Menelaus PM chip"
>  	depends on I2C=y && ARCH_OMAP24XX
>  	help
> -	  Say yes here if you have Menelaus chip on your board
> +	  If you say yes here you get support for the Texas Instruments
> +	  TWL92330/Menelaus Power Management chip. This include voltage
> +	  regulators, Dual slot memory card tranceivers, real-time clock
> +	  and other features that are often used in portable devices like
> +	  cell phones and PDAs.
>  
>  config TWL4030_CORE
>  	bool "TI's TWL4030 companion chip Core Driver Support"
> -- 
> 1.5.0
> 

Pushing.

Tony
