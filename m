From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] can: m_can: Move acessing of message ram to after clocks
 are enabled
Date: Wed, 6 Jun 2018 13:22:43 +0530
Message-ID: <19e1af1d-047e-3acf-3ba3-71811f30f50e@ti.com>
References: <20180529141940.1682-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529141940.1682-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 29 May 2018 07:49 PM, Faiz Abbas wrote:
> MCAN message ram should only be accessed once clocks are enabled.
> Therefore, move the call to parse/init the message ram to after
> clocks are enabled.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index b397a33f3d32..a9fbf81ac3d4 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1642,8 +1642,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  	priv->can.clock.freq = clk_get_rate(cclk);
>  	priv->mram_base = mram_addr;
>  
> -	m_can_of_parse_mram(priv, mram_config_vals);
> -
>  	platform_set_drvdata(pdev, dev);
>  	SET_NETDEV_DEV(dev, &pdev->dev);
>  
> @@ -1666,6 +1664,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> +	m_can_of_parse_mram(priv, mram_config_vals);
> +
>  	devm_can_led_init(dev);
>  
>  	of_can_transceiver(dev);
> @@ -1715,8 +1715,6 @@ static __maybe_unused int m_can_resume(struct device *dev)
>  
>  	pinctrl_pm_select_default_state(dev);
>  
> -	m_can_init_ram(priv);
> -
>  	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>  
>  	if (netif_running(ndev)) {
> @@ -1726,6 +1724,7 @@ static __maybe_unused int m_can_resume(struct device *dev)
>  		if (ret)
>  			return ret;
>  
> +		m_can_init_ram(priv);
>  		m_can_start(ndev);
>  		netif_device_attach(ndev);
>  		netif_start_queue(ndev);
> 

Gentle ping.

Thanks,
Faiz
