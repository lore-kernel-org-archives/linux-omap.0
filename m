From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] Input: ads7846 - configure pendown gpio as input
Date: Wed, 2 Feb 2011 17:56:00 +0200
Message-ID: <20110202155600.GA22939@legolas.emea.dhcp.ti.com>
References: <1296660646-28168-1-git-send-email-sourav.poddar@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41774 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754466Ab1BBP4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 10:56:06 -0500
Content-Disposition: inline
In-Reply-To: <1296660646-28168-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org

Hi,

On Wed, Feb 02, 2011 at 09:00:46PM +0530, Sourav Poddar wrote:
> The ads7846 driver requests a gpio to detect pendown events,
> but does not configure its direction. Configure this gpio
> as an input after requesting it.
> 
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
>  drivers/input/touchscreen/ads7846.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index 036f245..c001ce5 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -962,6 +962,7 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
>  		return err;
>  	}
>  
> +	gpio_direction_input(pdata->gpio_pendown);

this function returns a value on error, it's better if you check it.

-- 
balbi
