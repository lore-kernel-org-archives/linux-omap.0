From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 1/2] net: can: c_can: Fix default pinmux glitch at
 init
Date: Thu, 9 Jul 2015 13:58:21 +0300
Message-ID: <559E53CD.5080302@ti.com>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com> <1436279277-3386-2-git-send-email-rogerq@ti.com> <559D0BA4.9000000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <559D0BA4.9000000@ti.com>
Sender: linux-can-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, wg@grandegger.com, mkl@pengutronix.de, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/08/2015 02:38 PM, Roger Quadros wrote:
> From: "J.D. Schroeder" <jay.schroeder@garmin.com>
>
> The previous change 3973c526ae9c (net: can: c_can: Disable pins when CAN interface
> is down) causes a slight glitch on the pinctrl settings when used. Since
> commit ab78029 (drivers/pinctrl: grab default handles from device core),
> the device core will automatically set the default pins. This causes
> the pins to be momentarily set to the default and then to the sleep
> state in register_c_can_dev(). By adding an optional "enable" state,
> boards can set the default pin state to be disabled and avoid the
> glitch when the switch from default to sleep first occurs. If the
> "enable" state is not available c_can_pinctrl_select_state() falls
> back to using the "default" pinctrl state.
>
> [Roger Q] - Forward port to v4.2 and use pinctrl_get_select().
>
> Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/net/can/c_can/c_can.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
> index 041525d..5d214d1 100644
> --- a/drivers/net/can/c_can/c_can.c
> +++ b/drivers/net/can/c_can/c_can.c
> @@ -592,6 +592,7 @@ static int c_can_start(struct net_device *dev)
>   {
>   	struct c_can_priv *priv = netdev_priv(dev);
>   	int err;
> +	struct pinctrl *p;
>
>   	/* basic c_can configuration */
>   	err = c_can_chip_config(dev);
> @@ -604,8 +605,13 @@ static int c_can_start(struct net_device *dev)
>
>   	priv->can.state = CAN_STATE_ERROR_ACTIVE;
>
> -	/* activate pins */
> -	pinctrl_pm_select_default_state(dev->dev.parent);
> +	/* Attempt to use "active" if available else use "default" */
> +	p = pinctrl_get_select(priv->device, "active");
> +	if (!IS_ERR(p))
> +		pinctrl_put(p);
> +	else
> +		pinctrl_pm_select_default_state(priv->device);
> +

Thanks. This part looks good to me now.

>   	return 0;
>   }
>
>


-- 
regards,
-grygorii
