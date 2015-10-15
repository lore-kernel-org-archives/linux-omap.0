From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH] twl4030_charger: add missing iio dependency
Date: Thu, 15 Oct 2015 11:14:26 +0200
Message-ID: <CAAfyv3710TWjAeP1ViUZFhX0RJ0G0SdXN3uX2U4nC3_dnQXDfA@mail.gmail.com>
References: <1444900267-31937-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1444900267-31937-1-git-send-email-sre@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Oct 15, 2015 at 11:11 AM, Sebastian Reichel <sre@kernel.org> wrote:
> This driver fails to link without CONFIG_IIO, since
> there are no stubs for the iio_channels functions.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  drivers/power/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 9e68853217ca..cb0ae666dc68 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -313,7 +313,7 @@ config CHARGER_MAX8903
>
>  config CHARGER_TWL4030
>         tristate "OMAP TWL4030 BCI charger driver"
> -       depends on TWL4030_CORE
> +       depends on IIO && TWL4030_CORE
>         help
>           Say Y here to enable support for TWL4030 Battery Charge Interface.
>
> --
> 2.6.1
>
Acked-by: Marek Belisko <marek@goldelico.com>

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
