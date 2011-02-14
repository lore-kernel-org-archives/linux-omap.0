From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V4] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL
Date: Mon, 14 Feb 2011 14:24:06 -0800
Message-ID: <874o861chl.fsf@ti.com>
References: <1296798454-23755-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33131 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208Ab1BNWYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 17:24:16 -0500
Received: by mail-yi0-f45.google.com with SMTP id 21so2646664yie.18
        for <linux-omap@vger.kernel.org>; Mon, 14 Feb 2011 14:24:13 -0800 (PST)
In-Reply-To: <1296798454-23755-1-git-send-email-shweta.gulati@ti.com> (Shweta
	Gulati's message of "Fri, 4 Feb 2011 11:17:34 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>

Shweta Gulati <shweta.gulati@ti.com> writes:

> From: Thara Gopinath <thara@ti.com>
>
> Voltage control on TWL can be done using VMODE/I2C1/I2C_SR.
> Since almost all platforms use I2C_SR on omap3, omap3_twl_init by
> default expects that OMAP's I2C_SR is plugged in to TWL's I2C
> and calls omap3_twl_set_sr_bit. On platforms where I2C_SR is not connected,
> the board files are expected to call omap3_twl_set_sr_bit(false) to
> ensure that I2C_SR path is not set for voltage control and prevent
> the default behavior of omap3_twl_init.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>

Thanks, queueing for 2.6.39 (branch: for_2.6.39/pm-misc) after one minor
change below...

[...]

> +
> +/**
> + * omap3_twl_set_sr_bit() - Set/Clear SR bit on TWL
> + * @enable: enable SR mode in twl or not
> + *
> + * If 'enable' is true, enables Smartreflex bit on TWL 4030 to make sure
> + * voltage scaling through OMAP SR works. Else, the smartreflex bit
> + * on twl4030 is cleared as there are platforms which use OMAP3 and T2 but
> + * use Synchronized Scaling Hardware Strategy (ENABLE_VMODE=1) and Direct
> + * Strategy Software Scaling Mode (ENABLE_VMODE=0), for setting the voltages,
> + * in those scenarios this bit is to be cleared (enable = false).
> + *
> + * Returns 0 on sucess, error is returned if I2C read/write fails.
> + */
> +int __init omap3_twl_set_sr_bit(bool enable)
> +{
> +	u8 temp;
> +	int ret;
> +	if (twl_sr_enable_autoinit)
> +		pr_warning("%s: unexpected multiple calls\n", __func__);
> +
> +	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> +					TWL4030_DCDC_GLOBAL_CFG);
> +	if (ret)
> +		goto err;
> +
> +	if (enable)
> +		temp |= SMARTREFLEX_ENABLE;
> +	else
> +		temp &= ~SMARTREFLEX_ENABLE;
> +
> +	ret = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> +					TWL4030_DCDC_GLOBAL_CFG);
> +	if (!ret) {
> +		twl_sr_enable_autoinit = true;
> +		return 0;
> +	}
> +err:
> +	pr_err("%s: Error access to TWL4030 (%d)\n", __func__, ret);
> +	return ret;
> +}
> +

Removed this extra blank line at end-of-file.

Kevin
