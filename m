From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv3 2/5] Input: tsc2005: use dev_err for error messages
Date: Sun, 18 May 2014 22:33:37 -0700
Message-ID: <20140519053337.GA29386@core.coreip.homeip.net>
References: <1398470179-20880-1-git-send-email-sre@kernel.org>
 <1398470179-20880-3-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398470179-20880-3-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Sebastian Reichel <sre@ring0.de>, linux-input@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 26, 2014 at 01:56:16AM +0200, Sebastian Reichel wrote:
> Change some dev_dbg() invocations to dev_err() ones, because they
> are supposed to output error messages.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/tsc2005.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
> index 550adcb..520e673 100644
> --- a/drivers/input/touchscreen/tsc2005.c
> +++ b/drivers/input/touchscreen/tsc2005.c
> @@ -579,7 +579,7 @@ static int tsc2005_probe(struct spi_device *spi)
>  	int error;
>  
>  	if (!pdata) {
> -		dev_dbg(&spi->dev, "no platform data\n");
> +		dev_err(&spi->dev, "no platform data\n");
>  		return -ENODEV;
>  	}
>  
> @@ -591,7 +591,7 @@ static int tsc2005_probe(struct spi_device *spi)
>  	max_p	= pdata->ts_pressure_max   ? : MAX_12BIT;
>  
>  	if (spi->irq <= 0) {
> -		dev_dbg(&spi->dev, "no irq\n");
> +		dev_err(&spi->dev, "no irq\n");
>  		return -ENODEV;
>  	}
>  
> -- 
> 1.9.2
> 

-- 
Dmitry
