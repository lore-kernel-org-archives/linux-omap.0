From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] [I2C] OMAP: Don't write IE state in unidle if 0
Date: Mon, 28 Dec 2009 12:19:41 -0800
Message-ID: <20091228201941.GO3512@atomide.com>
References: <1261530373-408-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64820 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbZL1UTp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 15:19:45 -0500
Content-Disposition: inline
In-Reply-To: <1261530373-408-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Rajendra Nayak <rnayak@ti.com>, Jouni Hogander <jouni.hogander@nokia.com>, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Jon Hunter <jon-hunter@ti.com>, Hu Tao <taohu@motorola.com>, Xiaolong Chen <A21785@motorola.com>

* Cory Maccarrone <darkstar6262@gmail.com> [091222 17:05]:
> Commit ef871432... (i2c-omap: OMAP3: PM: (re)init for every transfer
> to support off-mode) introduced a change which make the dev->iestate
> contents be written to the OMAP_I2C_IE_REG every time omap_i2c_unidle
> is called.  Previously, the state was only written if it wasn't equal
> to zero.
> 
> In omap_i2c_probe, omap_i2c_unidle() is called prior to omap_i2c_init(),
> in which case dev->iestate has not yet been initialized and will be set
> to zero.  Having this value written to the registers causes deadlock
> while booting.
> 
> As such, this change restores the original functionality.

Looks like initializing dev->iestate to something before calling
omap_i2c_unidle in omap_i2c_probe is not an option in this case.
We'd want to initialize it to zero, which causes the deadlock..

Acked-by: Tony Lindgren <tony@atomide.com>


> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 3440d88..c0bb9eb 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -248,7 +248,13 @@ static void omap_i2c_unidle(struct omap_i2c_dev *dev)
>  		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>  	}
>  	dev->idle = 0;
> -	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
> +
> +	/*
> +	 * Don't write to this register if the IE state is 0 as it can
> +	 * cause deadlock.
> +	 */
> +	if (dev->iestate)
> +		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
>  }
>  
>  static void omap_i2c_idle(struct omap_i2c_dev *dev)
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
