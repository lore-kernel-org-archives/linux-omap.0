From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 2/5] regulator: omap smps regulator driver
Date: Wed, 13 Jul 2011 23:40:22 +0900
Message-ID: <20110713144019.GA7861@opensource.wolfsonmicro.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
 <1310565638-13140-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47700 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754654Ab1GMOk3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 10:40:29 -0400
Content-Disposition: inline
In-Reply-To: <1310565638-13140-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@ti.com, khilman@ti.com

On Wed, Jul 13, 2011 at 05:00:35PM +0300, Tero Kristo wrote:

> +config REGULATOR_OMAP_SMPS
> +	tristate "TI OMAP SMPS Power Regulators"
> +	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM && TWL4030_CORE

What is the dependency on the TWL4030?  I see no references to it in the
code...

> +	for (i = 0; i < pdata->num_regulators; i++) {
> +		initdata = pdata->regulators[i];
> +

I do strongly prefer the idiom of just registering all the regulators
even if they're read only.

> +		c = &initdata->constraints;
> +		c->valid_modes_mask &= REGULATOR_MODE_NORMAL;
> +		c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE;
> +		c->always_on = true;

No, this is bad.  We *always* pay attention to the constraints the user
set even if they're nuts or won't work, the machine driver has the final
say on what is or isn't allowed on a given board.  The mode setting is
especially suspect as there's no mode support in the driver.
