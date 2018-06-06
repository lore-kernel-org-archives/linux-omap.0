From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] can: m_can: Fix runtime resume call
Date: Wed, 6 Jun 2018 13:23:13 +0530
Message-ID: <cc569a2e-0075-bd9b-2f90-4c6427dc185c@ti.com>
References: <20180529132426.31216-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529132426.31216-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: mkl@pengutronix.de, wg@grandegger.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 29 May 2018 06:54 PM, Faiz Abbas wrote:
> pm_runtime_get_sync() returns a 1 if the state of the device is already
> 'active'. This is not a failure case and should return a success.
> 
> Therefore fix error handling for pm_runtime_get_sync() call such that
> it returns success when the value is 1.
> 
> Also cleanup the TODO for using runtime PM for sleep mode as that is
> implemented.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/net/can/m_can/m_can.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index a9fbf81ac3d4..04c48371ab2a 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -634,10 +634,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
>  	int err;
>  
>  	err = pm_runtime_get_sync(priv->device);
> -	if (err)
> +	if (err < 0) {
>  		pm_runtime_put_noidle(priv->device);
> +		return err;
> +	}
>  
> -	return err;
> +	return 0;
>  }
>  
>  static void m_can_clk_stop(struct m_can_priv *priv)
> @@ -1687,8 +1689,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -/* TODO: runtime PM with power down or sleep mode  */
> -
>  static __maybe_unused int m_can_suspend(struct device *dev)
>  {
>  	struct net_device *ndev = dev_get_drvdata(dev);
> 

Gentle ping.

Thanks,
Faiz
