From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv2 2/2] Input: ads7846 - configure pendown gpio as input
Date: Thu, 3 Feb 2011 11:58:45 +0200
Message-ID: <20110203095845.GK23561@legolas.emea.dhcp.ti.com>
References: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38623 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755479Ab1BCJ6t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 04:58:49 -0500
Content-Disposition: inline
In-Reply-To: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, charu@ti.com, gadiyar@ti.com, linux-input@vger.kernel.org, balbi@ti.com

On Thu, Feb 03, 2011 at 03:18:50PM +0530, Sourav Poddar wrote:
> The ads7846 driver requests a gpio to detect pendown events,
> but does not configure its direction. Configure this gpio
> as an input after requesting it.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> changes between v2 and v1: Added return error support in v2. 
>  
> drivers/input/touchscreen/ads7846.c |    7 +++++++
> 1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 036f245..f30768b 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -962,6 +962,13 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>  		return err;
>  	}
>  
> +	err = gpio_direction_input(pdata->gpio_pendown);
> +	if (err) {
> +		dev_err(&spi->dev, "failed to configure pendown GPIO input direction %d\n",
> +			pdata->gpio_pendown);
> +		return err;

and now you miss a gpio_free().

-- 
balbi
