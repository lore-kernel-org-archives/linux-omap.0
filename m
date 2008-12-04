From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] Putting TPS6235x into the power regulator framework
Date: Thu, 4 Dec 2008 12:04:18 +0000
Message-ID: <20081204120418.GB8019@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3949 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbYLDMEU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2008 07:04:20 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: y@india.ti.com
Cc: linux-omap@vger.kernel.org, Manikandan Pillai <mani.pillai@ti.com>

On Thu, Dec 04, 2008 at 03:55:06PM +0530, y@india.ti.com wrote:

> +	},
> +		.num_consumer_supplies  = 1,
> +		.consumer_supplies      = &tps6235x_consumers[0],

...

> +		.num_consumer_supplies  = 1,
> +		.consumer_supplies      = &tps6235x_consumers[1],

This code will work but flags up alarm bells when doing review - it
would be clearer to declare two separate variables, which is also less
error prone if someone takes your code and uses it as a template for
another board.

> +config REGULATOR_TPS6235X
> +	bool "TPS6235X Power regulator for OMAP3EVM"
> +	depends on PR785
> +	help
> +	  This driver supports the voltage regulators provided by TPS6235x chips.
> +	  The TPS62352 and TPS62353 are mounted on PR785 Power module card for
> +	  providing voltage regulator functions.

This should probably be two drivers: a driver for the TPS6235x and a
driver for the power module card, otherwise systems that use the chip on
a different board won't be able to do so.  Looking at the code it seems
you've got something fairly close to this structure already, it just
needs exposing.

> index 02a7744..901f402 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -30,33 +30,6 @@ static LIST_HEAD(regulator_list);
>  static LIST_HEAD(regulator_map_list);
>  
>  /**
> - * struct regulator_dev
> - *
> - * Voltage / Current regulator class device. One for each regulator.
> - */
> -struct regulator_dev {
> -	struct regulator_desc *desc;
> -	int use_count;

This is... interesting?  I think all you're doing is looking inside to
get the driver data rather than using regulator_get_drvdata() - is there
anything else?

> new file mode 100644
> index 0000000..8a900db
> --- /dev/null
> +++ b/drivers/regulator/tps6235x-regulator.c

> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>

Do you need the consumer header here?

> +
> +#define	MODULE_NAME		"tps6235x_power"

Really?

> +/* Debug functions */
> +#ifdef	DEBUG
> +
> +#define dump_reg(client, reg, val)                                      \
> +	do {                                                            \
> +		tps6235x_read_reg(client, reg, &val);                   \
> +		dev_dbg(&(client)->dev, "Reg(0x%.2X): 0x%.2X\n", reg, val); \
> +	} while (0)
> +
> +#endif	/* #ifdef DEBUG */

static inline?

> +/* Maximum number of bytes to be read in a single read */
> +#define	PR785_RETRY_COUNT	0x3

The name and comment don't seem to match up very well...

> +static int tps6235x_dcdc_is_enabled(struct regulator_dev *dev)
> +{
> +	struct  tps_6235x_info *tps_info =
> +			(struct tps_6235x_info *)dev->reg_data;

Should use regulator_get_drvdata() for this.

> +	return tps_info->state;
> +}

> +static int tps6235x_dcdc_set_voltage(struct regulator_dev *dev,
> +				int min_uV, int max_uV)
> +{
> +	struct  tps_6235x_info *tps_info =
> +			(struct tps_6235x_info *)dev->reg_data;
> +	unsigned int millivolts = max_uV / 1000;
> +
> +	return pr785_set_dcdc_volt(tps_info->tps_i2c_addr,  millivolts) ;
> +}

Normally you'd want to go for the lowest voltage you can in the range
rather than the highest voltage.  A driver doing voltage scaling for
power saving would be likely to call set_voltage() with a range from the
minimum that could currently be used to the maximum rated for the chip
since it's only trying to save power, it doesn't specifically *need* the
lower voltage.  This allows the driver to run on systems where there are
additional constraints which prevent the use of the lowest voltages.
