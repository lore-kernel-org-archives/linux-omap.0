From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/4] I2C: OMAP3: PM: (re)init for every transfer to support off-mode
Date: Mon, 29 Jun 2009 10:04:44 -0700
Message-ID: <87y6rb7yz7.fsf@deeprootsystems.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-2-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-3-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-4-git-send-email-khilman@deeprootsystems.com>
	<1245965646-20070-5-git-send-email-khilman@deeprootsystems.com>
	<4A44AD44.4070107@nokia.com> <87bpobjcx6.fsf@deeprootsystems.com>
	<F12CE1A68F023D498A2691C7B5393115035F09BD@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:63280 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbZF2REo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 13:04:44 -0400
Received: by pzk26 with SMTP id 26so346074pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 10:04:47 -0700 (PDT)
In-Reply-To: <F12CE1A68F023D498A2691C7B5393115035F09BD@ZMY16EXM66.ds.mot.com> (HU TAO-TGHK's message of "Mon\, 29 Jun 2009 16\:51\:51 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: HU TAO-TGHK48 <taohu@motorola.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

"HU TAO-TGHK48" <taohu@motorola.com> writes:

> I think we also need extra patch for fixing stability issue.
>
> Sometimes after back from retention/off mode, OMAP3430 I2C controller
> stops working even all register settings are restored.
>
> OMAP3430 TRM says: "During active mode (I2Ci.I2C_CON[15] I2C_EN bit is
> set to 1), make no changes to the I2Ci.I2C_SCLL and I2Ci.I2C_SCLH
> registers. 
> Changes may result in unpredictable behavior."
>
> diff --git a/drivers/i2c/busses/i2c-omap.c
> b/drivers/i2c/busses/i2c-omap.c index 5ce055c..b084209 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -238,12 +238,14 @@ static void omap_i2c_unidle(struct omap_i2c_dev
> *dev)
>  		clk_enable(dev->iclk);
>  	clk_enable(dev->fclk);
>  	if (cpu_is_omap34xx()) {
> +		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>  		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG,
> dev->pscstate);
>  		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG,
> dev->scllstate);
>  		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG,
> dev->sclhstate);
>  		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG,
> dev->bufstate);
>  		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
> dev->syscstate);
>  		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> +		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
> OMAP_I2C_CON_EN);
>  	}
>  	dev->idle = 0;
>  	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);

Shouldn't you do a read-modify-write of I2C_CON_REG here?  Otherwise,
you're loosing any of the other settings in I2C_CON_REG.

Not being an expert in the I2C hardware, I'm not sure if it matters,
but this doesn't seem quite right due to possible side effects.

Kevin

