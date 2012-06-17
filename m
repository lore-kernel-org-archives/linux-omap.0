From: Jingoo Han <jg1.han@samsung.com>
Subject: RE: [PATCH] OMAPDSS: HDMI: Discard phy_tx_enabled member
Date: Mon, 18 Jun 2012 08:44:59 +0900
Message-ID: <000a01cd4ce3$35367160$9fa35420$%han@samsung.com>
References: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:24307 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab2FQXpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 17 Jun 2012 19:45:01 -0400
In-reply-to: <1339797701-11540-1-git-send-email-jaswinder.singh@linaro.org>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jaswinder.singh@linaro.org, tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Mythri P K' <mythripk@ti.com>


On Saturday 16 June 2012 7:02:00 jaswinder.singh wrote:

> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Explicitly maintaining HDMI phy power state using a flag is prone to
> race and un-necessary when we have a zero-cost alternative of checking
> the state before trying to set it.

CC'ed 'Mythri P K' as the author for OMAP HDMI.

Hi Jassi, long time no see.

This patch looks good.
If there is no problem, checking register is better way.

Best regards,
Jingoo Han.

> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  drivers/video/omap2/dss/ti_hdmi.h         |    1 -
>  drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |   11 ++++-------
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/ti_hdmi.h b/drivers/video/omap2/dss/ti_hdmi.h
> index e734cb4..d174ca1 100644
> --- a/drivers/video/omap2/dss/ti_hdmi.h
> +++ b/drivers/video/omap2/dss/ti_hdmi.h
> @@ -177,7 +177,6 @@ struct hdmi_ip_data {
> 
>  	/* ti_hdmi_4xxx_ip private data. These should be in a separate struct */
>  	int hpd_gpio;
> -	bool phy_tx_enabled;
>  };
>  int ti_hdmi_4xxx_phy_enable(struct hdmi_ip_data *ip_data);
>  void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data);
> diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> index 4dae1b2..3fa3d98 100644
> --- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> +++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
> @@ -157,6 +157,10 @@ static int hdmi_pll_init(struct hdmi_ip_data *ip_data)
>  /* PHY_PWR_CMD */
>  static int hdmi_set_phy_pwr(struct hdmi_ip_data *ip_data, enum hdmi_phy_pwr val)
>  {
> +	/* Return if already the state */
> +	if (REG_GET(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, 5, 4) == val)
> +		return 0;
> +
>  	/* Command for power control of HDMI PHY */
>  	REG_FLD_MOD(hdmi_wp_base(ip_data), HDMI_WP_PWR_CTRL, val, 7, 6);
> 
> @@ -241,11 +245,6 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
> 
>  	hpd = gpio_get_value(ip_data->hpd_gpio);
> 
> -	if (hpd == ip_data->phy_tx_enabled) {
> -		spin_unlock_irqrestore(&phy_tx_lock, flags);
> -		return 0;
> -	}
> -
>  	if (hpd)
>  		r = hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_TXON);
>  	else
> @@ -257,7 +256,6 @@ static int hdmi_check_hpd_state(struct hdmi_ip_data *ip_data)
>  		goto err;
>  	}
> 
> -	ip_data->phy_tx_enabled = hpd;
>  err:
>  	spin_unlock_irqrestore(&phy_tx_lock, flags);
>  	return r;
> @@ -327,7 +325,6 @@ void ti_hdmi_4xxx_phy_disable(struct hdmi_ip_data *ip_data)
>  	free_irq(gpio_to_irq(ip_data->hpd_gpio), ip_data);
> 
>  	hdmi_set_phy_pwr(ip_data, HDMI_PHYPWRCMD_OFF);
> -	ip_data->phy_tx_enabled = false;
>  }
> 
>  static int hdmi_core_ddc_init(struct hdmi_ip_data *ip_data)
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

