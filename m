From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/3] regulator: twl: Make sure we have access to powerbus
 before trying to write to it
Date: Wed, 6 Apr 2016 01:26:15 +0300
Message-ID: <57043B87.20304@gmail.com>
References: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1458980895-10240-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458980895-10240-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: tony@atomide.com, lgirdwood@gmail.com, sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 26.03.2016 10:28, Ivaylo Dimitrov wrote:
> According to the TRM, we need to enable i2c access to powerbus before
> writing to it. Also, a new write to powerbus should not be attempted if
> there is a pending transfer. The current code does not implement that
> functionality and while there are no known problems caused by that, it is
> better to follow what TRM says.
>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>   drivers/regulator/twl-regulator.c | 78 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 70 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
> index 955a6fb..aad748b0 100644
> --- a/drivers/regulator/twl-regulator.c
> +++ b/drivers/regulator/twl-regulator.c
> @@ -21,7 +21,7 @@
>   #include <linux/regulator/machine.h>
>   #include <linux/regulator/of_regulator.h>
>   #include <linux/i2c/twl.h>
> -
> +#include <linux/delay.h>
>
>   /*
>    * The TWL4030/TW5030/TPS659x0/TWL6030 family chips include power management, a
> @@ -188,6 +188,74 @@ static int twl6030reg_is_enabled(struct regulator_dev *rdev)
>   	return grp && (val == TWL6030_CFG_STATE_ON);
>   }
>
> +#define PB_I2C_BUSY	BIT(0)
> +#define PB_I2C_BWEN	BIT(1)
> +
> +/* Wait until buffer empty/ready to send a word on power bus. */
> +static int twl4030_wait_pb_ready(void)
> +{
> +
> +	int	ret;
> +	int	timeout = 10;
> +	u8	val;
> +
> +	do {
> +		ret = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
> +				      TWL4030_PM_MASTER_PB_CFG);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!(val & PB_I2C_BUSY))
> +			return 0;
> +
> +		mdelay(1);
> +		timeout--;
> +	} while (timeout);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +/* Send a word over the powerbus */
> +static int twl4030_send_pb_msg(unsigned msg)
> +{
> +	u8	val;
> +	int	ret;
> +
> +	/* save powerbus configuration */
> +	ret = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
> +			      TWL4030_PM_MASTER_PB_CFG);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable i2c access to powerbus */
> +	ret = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val | PB_I2C_BWEN,
> +			       TWL4030_PM_MASTER_PB_CFG);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = twl4030_wait_pb_ready();
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, msg >> 8,
> +			       TWL4030_PM_MASTER_PB_WORD_MSB);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = twl_i2c_write_u8(TWL_MODULE_PM_MASTER, msg & 0xff,
> +			       TWL4030_PM_MASTER_PB_WORD_LSB);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = twl4030_wait_pb_ready();
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Restore powerbus configuration */
> +	return twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val,
> +				TWL_MODULE_PM_MASTER);

Hmm, I made a copy/paste error here, this should be:

	return twl_i2c_write_u8(TWL_MODULE_PM_MASTER, val,
				TWL4030_PM_MASTER_PB_CFG);

Will send a new version of the patch.

> +}
> +
>   static int twl4030reg_enable(struct regulator_dev *rdev)
>   {
>   	struct twlreg_info	*info = rdev_get_drvdata(rdev);
> @@ -324,13 +392,7 @@ static int twl4030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
>   	if (!(status & (P3_GRP_4030 | P2_GRP_4030 | P1_GRP_4030)))
>   		return -EACCES;
>
> -	status = twl_i2c_write_u8(TWL_MODULE_PM_MASTER,
> -			message >> 8, TWL4030_PM_MASTER_PB_WORD_MSB);
> -	if (status < 0)
> -		return status;
> -
> -	return twl_i2c_write_u8(TWL_MODULE_PM_MASTER,
> -			message & 0xff, TWL4030_PM_MASTER_PB_WORD_LSB);
> +	return twl4030_send_pb_msg(message);
>   }
>
>   static int twl6030reg_set_mode(struct regulator_dev *rdev, unsigned mode)
>

Ivo
