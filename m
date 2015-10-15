From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] twl4030_charger: add missing iio dependency
Date: Thu, 15 Oct 2015 11:19:57 +0200
Message-ID: <1C0B2D13-79B6-42A5-B4AD-09542F92F692@goldelico.com>
References: <1444900267-31937-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1444900267-31937-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Acked-by: Nikolaus Schaller <hns@goldelico.com>

BR,
Nikolaus

Am 15.10.2015 um 11:11 schrieb Sebastian Reichel <sre@kernel.org>:

> This driver fails to link without CONFIG_IIO, since
> there are no stubs for the iio_channels functions.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> drivers/power/Kconfig | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 9e68853217ca..cb0ae666dc68 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -313,7 +313,7 @@ config CHARGER_MAX8903
> 
> config CHARGER_TWL4030
> 	tristate "OMAP TWL4030 BCI charger driver"
> -	depends on TWL4030_CORE
> +	depends on IIO && TWL4030_CORE
> 	help
> 	  Say Y here to enable support for TWL4030 Battery Charge Interface.
> 
> -- 
> 2.6.1
> 

