From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH 4/4] spi: omap2-mcspi: Handle error on gpio_request
Date: Sun, 24 May 2015 10:13:07 +0200
Message-ID: <20150524081307.GC17508@opentech.at>
References: <20150522122544.GL21391@sirena.org.uk> <1432433625-23407-1-git-send-email-mwelling@ieee.org> <1432433625-23407-5-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432433625-23407-5-git-send-email-mwelling@ieee.org>
Sender: linux-next-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: broonie@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 23 May 2015, Michael Welling wrote:

> If a valid GPIO is specified but cannot be requested by the driver, print a
> message and error out of omap2_mcspi_setup.
> 
> Signed-off-by: Michael Welling <mwelling@ieee.org>
> ---
>  drivers/spi/spi-omap2-mcspi.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index c4e21ad..5867384 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -1023,9 +1023,12 @@ static int omap2_mcspi_setup(struct spi_device *spi)
>  	}
>  
>  	if (gpio_is_valid(spi->cs_gpio)) {
> -		if (gpio_request(spi->cs_gpio, dev_name(&spi->dev)) == 0)
> -			gpio_direction_output(spi->cs_gpio,
> -			!(spi->mode & SPI_CS_HIGH));
> +		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
> +		if (ret) {
> +			dev_err(&spi->dev, "failed to request gpio\n");
> +			return ret;
> +		}
> +		gpio_direction_output(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
>  	}

just wondering if the outer gpio_is_valid is actually needed as it seems
gpio_request() is actually calling gpio_is_valid() anyway and would return
non 0 if it were not,

thx!
hofrat
