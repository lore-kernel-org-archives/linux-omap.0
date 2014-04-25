From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 01/23] OMAPDSS: HDMI: lane config support
Date: Fri, 25 Apr 2014 15:36:13 +0530
Message-ID: <535A3395.4050106@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42886 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbaDYKHf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Apr 2014 06:07:35 -0400
In-Reply-To: <1398334639-14172-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Thursday 24 April 2014 03:46 PM, Tomi Valkeinen wrote:
> Add support to configure the pins used for the HDMI lanes. The order and
> polarity of the lanes can be defined in the DT data.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---

> +static void hdmi_phy_configure_lanes(struct hdmi_phy_data *phy)
> +{
> +	static const u16 pad_cfg_list[] = {
> +		0x0123,
> +		0x0132,
> +		0x0312,
> +		0x0321,
> +		0x0231,
> +		0x0213,
> +		0x1023,
> +		0x1032,
> +		0x3012,
> +		0x3021,
> +		0x2031,
> +		0x2013,
> +		0x1203,
> +		0x1302,
> +		0x3102,
> +		0x3201,
> +		0x2301,
> +		0x2103,
> +		0x1230,
> +		0x1320,
> +		0x3120,
> +		0x3210,
> +		0x2310,
> +		0x2130,
> +	};
> +
> +	u16 lane_cfg = 0;
> +	int i;
> +	unsigned lane_cfg_val;
> +	u16 pol_val = 0;
> +
> +	for (i = 0; i < 4; ++i)
> +		lane_cfg |= phy->lane_function[i] << ((3 - i) * 4);
> +
> +	pol_val |= phy->lane_polarity[0] << 0;
> +	pol_val |= phy->lane_polarity[1] << 3;
> +	pol_val |= phy->lane_polarity[2] << 2;
> +	pol_val |= phy->lane_polarity[3] << 1;
> +
> +	for (i = 0; i < ARRAY_SIZE(pad_cfg_list); ++i)
> +		if (pad_cfg_list[i] == lane_cfg)
> +			break;
> +
> +	if (WARN_ON(i == ARRAY_SIZE(pad_cfg_list)))
> +		i = 0;
> +
> +	lane_cfg_val = i;

I spent some time to see if we could get create lane_cfg_val without 
having the table above, looks like there is no pattern at all in the 
register field.

> +
> +	REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, lane_cfg_val, 26, 22);
> +	REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, pol_val, 30, 27);
> +}
> +
>   int hdmi_phy_enable(struct hdmi_phy_data *phy, struct hdmi_wp_data *wp,
>   			struct hdmi_config *cfg)
>   {
> @@ -92,8 +183,7 @@ int hdmi_phy_enable(struct hdmi_phy_data *phy, struct hdmi_wp_data *wp,
>   	/* Setup max LDO voltage */
>   	REG_FLD_MOD(phy->base, HDMI_TXPHY_POWER_CTRL, 0xB, 3, 0);
>
> -	/* Write to phy address 3 to change the polarity control */
> -	REG_FLD_MOD(phy->base, HDMI_TXPHY_PAD_CFG_CTRL, 0x1, 27, 27);

wow, didn't realize it was hardcoded like this.

Reviewed-by: Archit Taneja <archit@ti.com?

Archit

