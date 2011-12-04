From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [PATCH 09/11] video: Remove redundant spi driver bus initialization
Date: Sun, 04 Dec 2011 00:36:47 +0000
Message-ID: <4EDAC09F.5090401@gmx.de>
References: <1322148561-25138-1-git-send-email-lars@metafoo.de> <1322148561-25138-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322148561-25138-9-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/24/2011 03:29 PM, Lars-Peter Clausen wrote:
> In ancient times it was necessary to manually initialize the bus field of an
> spi_driver to spi_bus_type. These days this is done in spi_driver_register(),
> so we can drop the manual assignment.
> 
> The patch was generated using the following coccinelle semantic patch:
> // <smpl>
> @@
> identifier _driver;
> @@
> struct spi_driver _driver = {
> 	.driver = {
> -		.bus = &spi_bus_type,
> 	},
> };
> // </smpl>
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-omap@vger.kernel.org

Applied this patch.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/omap/lcd_mipid.c                     |    1 -
>  drivers/video/omap2/displays/panel-acx565akm.c     |    1 -
>  drivers/video/omap2/displays/panel-n8x0.c          |    1 -
>  .../omap2/displays/panel-nec-nl8048hl11-01b.c      |    1 -
>  .../video/omap2/displays/panel-tpo-td043mtea1.c    |    1 -
>  5 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/omap/lcd_mipid.c b/drivers/video/omap/lcd_mipid.c
> index eb381db..8d546dd 100644
> --- a/drivers/video/omap/lcd_mipid.c
> +++ b/drivers/video/omap/lcd_mipid.c
> @@ -603,7 +603,6 @@ static int mipid_spi_remove(struct spi_device *spi)
>  static struct spi_driver mipid_spi_driver = {
>  	.driver = {
>  		.name	= MIPID_MODULE_NAME,
> -		.bus	= &spi_bus_type,
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe	= mipid_spi_probe,
> diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
> index dbd59b8..51a87e1 100644
> --- a/drivers/video/omap2/displays/panel-acx565akm.c
> +++ b/drivers/video/omap2/displays/panel-acx565akm.c
> @@ -803,7 +803,6 @@ static int acx565akm_spi_remove(struct spi_device *spi)
>  static struct spi_driver acx565akm_spi_driver = {
>  	.driver = {
>  		.name	= "acx565akm",
> -		.bus	= &spi_bus_type,
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe	= acx565akm_spi_probe,
> diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
> index 150e8ba..dc9408d 100644
> --- a/drivers/video/omap2/displays/panel-n8x0.c
> +++ b/drivers/video/omap2/displays/panel-n8x0.c
> @@ -708,7 +708,6 @@ static int mipid_spi_remove(struct spi_device *spi)
>  static struct spi_driver mipid_spi_driver = {
>  	.driver = {
>  		.name	= "lcd_mipid",
> -		.bus	= &spi_bus_type,
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe	= mipid_spi_probe,
> diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
> index 2ba9d0c..8365e77 100644
> --- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
> +++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
> @@ -303,7 +303,6 @@ static struct spi_driver nec_8048_spi_driver = {
>  	.resume		= nec_8048_spi_resume,
>  	.driver		= {
>  		.name	= "nec_8048_spi",
> -		.bus	= &spi_bus_type,
>  		.owner	= THIS_MODULE,
>  	},
>  };
> diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> index 2462b9e..e6649aa 100644
> --- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
> @@ -512,7 +512,6 @@ static int __devexit tpo_td043_spi_remove(struct spi_device *spi)
>  static struct spi_driver tpo_td043_spi_driver = {
>  	.driver = {
>  		.name	= "tpo_td043mtea1_panel_spi",
> -		.bus	= &spi_bus_type,
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe	= tpo_td043_spi_probe,
