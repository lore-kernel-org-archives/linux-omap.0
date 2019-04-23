From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 17/19] net: ethernet: ti: cpsw: introduce mac sl
 module api
Date: Tue, 23 Apr 2019 21:01:56 +0200
Message-ID: <20190423190156.GJ28405@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-18-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556024950-20752-18-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 23, 2019 at 04:09:08PM +0300, Grygorii Strashko wrote:
> +void cpsw_sl_reset(struct cpsw_sl *sl, unsigned long tmo)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(tmo);
> +
> +	/* Set the soft reset bit */
> +	cpsw_sl_reg_write(sl, CPSW_SL_SOFT_RESET, CPSW_SL_SOFT_RESET_BIT);
> +
> +	/* Wait for the bit to clear */
> +	do {
> +		cpu_relax();
> +	} while ((cpsw_sl_reg_read(sl, CPSW_SL_SOFT_RESET) &
> +		  CPSW_SL_SOFT_RESET_BIT) &&
> +		  time_after(timeout, jiffies));

Hi Grygorii

If you are waiting for milliseconds, you probably should have a
sleep/delay in here.

> +int cpsw_sl_wait_for_idle(struct cpsw_sl *sl, unsigned long tmo)
> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(tmo);
> +
> +	do {
> +		cpu_relax();
> +	} while (!(cpsw_sl_reg_read(sl, CPSW_SL_MACSTATUS) &
> +		  sl->idle_mask) && time_after(timeout, jiffies));
> +

Same here.

> +	if (!(cpsw_sl_reg_read(sl, CPSW_SL_MACSTATUS) & sl->idle_mask)) {
> +		dev_err(sl->dev, "cpsw_sl failed to soft-reset.\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;

  Andrew
