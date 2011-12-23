From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] MFD: TPS65217: Add new mfd device for TPS65217
Date: Fri, 23 Dec 2011 10:49:18 +0000
Message-ID: <20111223104918.GD2834@opensource.wolfsonmicro.com>
References: <1324617679-14301-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42664 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918Ab1LWKtW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Dec 2011 05:49:22 -0500
Content-Disposition: inline
In-Reply-To: <1324617679-14301-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: sameo@linux.intel.com, lrg@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com

On Fri, Dec 23, 2011 at 10:51:19AM +0530, AnilKumar Ch wrote:
> The TPS65217 chip is a power management IC for Portable Navigation Systems
> and Tablet Computing devices. It contains the following components:

I can't help but thinking that there ought to be more code sharing
between the various TI PMIC drivers.

> +static int tps65217_i2c_read_device(struct tps65217_dev *tps65217, char reg,
> +				  int bytes, void *dest)
> +{
> +	struct i2c_client *i2c = tps65217->i2c_client;
> +	struct i2c_msg xfer[2];
> +	int ret;

Use regmap for the register I/O, this will save a lot of code and will
also give access to things like the register cache code.

> +	tps65217 = kzalloc(sizeof(struct tps65217_dev), GFP_KERNEL);
> +	if (tps65217 == NULL)
> +		return -ENOMEM;

Use devm_kzalloc(), it saves all the unwinding code.

> +/* All register addresses */
> +#define TPS65217_REG_CHIPID		0X00

You should verify this as part of the probe() routine - read it back to
make sure it's what's expected, and log the chip revision too in case it
is useful for diagnostics.
