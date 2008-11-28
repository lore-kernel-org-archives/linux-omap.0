From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/3] TPS6235x drivers added in drivers/i2c/chips.
Date: Fri, 28 Nov 2008 08:56:05 +0200
Message-ID: <20081128065605.GM23308@gandalf.research.nokia.com>
References: <1227850090-16131-1-git-send-email-mani.pillai@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62224 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591AbYK1G4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 01:56:33 -0500
Content-Disposition: inline
In-Reply-To: <1227850090-16131-1-git-send-email-mani.pillai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Manikandan Pillai <mani.pillai@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 28, 2008 at 10:58:10AM +0530, ext Manikandan Pillai wrote:
> Implements the basic driver for TPS6235x devices populated on the
> PR785 board. tps6235x.c contains the driver code for TPS devices used on 
> PR785 boards. Driver code is added it to the build.

Please, read Documentation/CodingStyle and
Documentation/kernel-doc-nano-HOWTO.txt, fix the issues and resend.

few comments below.

> Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
> ---
>  drivers/i2c/chips/Makefile   |    1 +
>  drivers/i2c/chips/tps6235x.c |  416 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 417 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/i2c/chips/tps6235x.c
> 
> diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
> index cb9f2bb..749f1ec 100644
> --- a/drivers/i2c/chips/Makefile
> +++ b/drivers/i2c/chips/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
>  obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
>  obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
>  obj-$(CONFIG_LP5521)		+= lp5521.o
> +obj-$(CONFIG_TPS6235X)          += tps6235x.o
>  
>  ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
>  EXTRA_CFLAGS += -DDEBUG
> diff --git a/drivers/i2c/chips/tps6235x.c b/drivers/i2c/chips/tps6235x.c
> new file mode 100644
> index 0000000..fd5ee0b
> --- /dev/null
> +++ b/drivers/i2c/chips/tps6235x.c
> @@ -0,0 +1,416 @@
> +/*
> + * drivers/i2c/chips/tps6235x.c
> + *
> + * TI TPS6235x device driver
> + *
> + * Copyright (C) 2008 Texas Instruments Inc
> + *
> + * Contributors:
> + *     Manikandan Pillai <mani.pillai@ti.com>
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +
> +#define	MODULE_NAME	"tps6235x_power"
> +
> +/* Debug functions */
> +#ifdef	DEBUG
> +
> +#define	dump_reg(client, reg, val)					\
> +	do {								\
> +		tps6235x_read_reg(client, reg, &val);			\
> +		dev_dbg(&(client)->dev, "Reg(0x%.2X): 0x%.2X\n", reg, val); \
> +	} while (0)
> +
> +#endif	/* #ifdef DEBUG */
> +
> +/* 2 I2C devices on PR785 board for controlling voltage on CORE and MPU */
> +typedef enum TPS_module_type {
> +	PR785_CORE_PWR,
> +	PR785_MPU_PWR,
> +} TPS_module_type;

no CaMeLcAsE code should accepted. Neither typdefs.

> +
> +#define	TPS6235X_REG_VSEL0	0
> +#define	TPS6235X_REG_VSEL1	1
> +#define	TPS6235X_REG_CTRL1	2
> +#define	TPS6235X_REG_CTRL2	3
> +#define	TPS6235X_REG_MAX	TPS6235X_REG_CTRL2
> +
> +/* Device addresses for PR785 card */
> +#define PR785_62352_CORE_ADDR	0x4A
> +#define PR785_62353_MPU_ADDR	0x48
> +
> +/* Minimum and Maximum dc-dc voltage supported by the TPS6235x devices
> +All voltages given in millivolts */
> +#define PR785_MIN_CORE_VOLT	750
> +#define PR785_MAX_CORE_VOLT	1537
> +#define PR785_MIN_MPU_VOLT	750
> +#define PR785_MAX_MPU_VOLT	1537
> +
> +/* Maximum number of bytes to be read in a single read */
> +#define PR785_RETRY_COUNT	0x3
> +
> +/* Register bit settings */
> +#define TPS6235X_EN_DCDC	(0x1 << 0x7)
> +#define TPS6235X_VSM_MSK	(0x3F)
> +#define TPS6235X_EN_SYN_MSK	(0x1 << 0x5)
> +#define TPS6235X_SW_VOLT_MSK	(0x1 << 0x4)
> +#define TPS6235X_PWR_OK_MSK	(0x1 << 0x5)
> +#define TPS6235X_OUT_DIS_MSK	(0x1 << 0x6)
> +#define TPS6235X_GO_MSK		(0x1 << 0x7)
> +
> +struct tps_6235x_info {
> +	unsigned int		state;
> +	enum TPS_module_type	tps_i2c_addr;
> +	struct i2c_client	*client;
> +	struct device		*i2c_dev;
> +	/* platform data holder */
> +	void			*pdata;
> +};
> +
> +static struct tps_6235x_info	tps_6235x_infodata[2];
> +
> +/*
> + * Get client pointer for a particular device
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static struct i2c_client *tps_6235x_get_client(TPS_module_type tps_mod_type)
> +{
> +	if (tps_mod_type == PR785_CORE_PWR)
> +		return tps_6235x_infodata[0].client;
> +	else if (tps_mod_type == PR785_MPU_PWR)
> +		return tps_6235x_infodata[1].client;
> +	else
> +		return NULL;
> +}
> +
> +/*
> + * Read a value from a register in an tps_6235x device.
> + * The value is returned in 'val'.
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static int tps_6235x_read_reg(struct i2c_client *client, u8 reg, u8 *val)
> +{
> +	int err;
> +	struct i2c_msg msg[2];
> +	u8 data;
> +
> +	if (!client->adapter)
> +		return -ENODEV;
> +
> +	/* [MSG1] fill the register address data */
> +	data = reg;
> +	msg[0].addr = client->addr;
> +	msg[0].len = 1;
> +	msg[0].flags = 0;
> +	msg[0].buf = &data;
> +
> +	/* [MSG2] fill the data rx buffer */
> +	msg[1].addr = client->addr;
> +	msg[1].len = 1;			/* only 1 byte */
> +	msg[1].flags = I2C_M_RD;	/* Read the register values */
> +	msg[1].buf = val;
> +	err = i2c_transfer(client->adapter, msg, 2);
> +	if (err >= 0)
> +		return 0;
> +
> +	dev_err(&client->dev,
> +		"read from device 0x%.2x, offset 0x%.2x error %d\n",
> +		client->addr, reg, err);
> +
> +	return err;
> +}
> +
> +/*
> + * Write a value to a register in an tps_6235x device.
> + * Returns zero if successful, or non-zero otherwise.
> + */
> +static int tps_6235x_write_reg(struct i2c_client *client, u8 reg, u8 val)
> +{
> +	int err;
> +	int retry = 0;
> +	struct i2c_msg msg[1];
> +	u8 data[2];
> +
> +	if (!client->adapter)
> +		return -ENODEV;
> +
> +again:
> +	data[0] = reg;		/* Register offset */
> +	data[1] = val;		/* Register value */
> +	msg->addr = client->addr;
> +	msg->len = 2;
> +	msg->flags = 0;		/* write operation */
> +	msg->buf = data;
> +
> +	err = i2c_transfer(client->adapter, msg, 1);
> +	if (err >= 0)
> +		return 0;
> +
> +	dev_err(&client->dev,
> +		"wrote 0x%.2x to offset 0x%.2x error %d\n", val, reg, err);
> +
> +	if (retry <= PR785_RETRY_COUNT) {
> +		dev_info(&client->dev, "retry ... %d\n", retry);
> +		retry++;
> +		schedule_timeout(msecs_to_jiffies(20));
> +		goto again;
> +	}
> +	return err;
> +}
> +
> +/**
> +*  pwr_i2c_read - Allows the caller to read one register from TPS device
> +*                   based on the address given. For the PR785 it reads
> +*                   only 1 byte into a specified register
> +*  tps_mod_type - Enum for the device to be read
> +*  reg          - Register to be read from(value has to be between 0-3
> +*  val          - value read from the reg
> +*  Retval       - 0 -> Success else non-zero
> +**/
> +int pwr_i2c_read(TPS_module_type tps_mod_type, u8 reg, u8 *val)
> +{
> +	struct i2c_client *client;
> +
> +	client = tps_6235x_get_client(tps_mod_type);
> +	/* check if register is less than <= 3 Register is 0 -3 */
> +	if (reg > TPS6235X_REG_MAX)
> +		return -1;
> +
> +	return tps_6235x_read_reg(client, reg, val);
> +}
> +EXPORT_SYMBOL(pwr_i2c_read);
> +
> +/**
> +*  pwr_i2c_write - Allows the caller to write one register from TPS device
> +*		    based on the address given. For the PR785 it writes
> +*		    only 1 byte into a specified register
> +*  tps_mod_type  - Enum for the device to be written
> +*  reg           - Register to be written to(value has to be between 0-3
> +*  val           - value to be written to reg
> +*  Retval        - 0 -> Success else non-zero
> +**/
> +int pwr_i2c_write(TPS_module_type tps_mod_type, u8 reg, u8 val)
> +{
> +	struct i2c_client *client;
> +
> +	client = tps_6235x_get_client(tps_mod_type);
> +
> +	/* check if register is less than <= 3 Register is 0 -3 */
> +	if (reg > TPS6235X_REG_MAX)
> +		return -1;
> +
> +	return tps_6235x_write_reg(client, reg, val);
> +}
> +EXPORT_SYMBOL(pwr_i2c_write);
> +
> +/**
> +*  TPSPR785        - Specific functions
> +*  pr785_enbl_dcdc - Allows the caller to enable or disable the TPS6235x device
> +*                    on the PR785 board. The voltage for PR785 is selected by
> +*                    VSEL1 register since VSEL pin is kept high
> +*
> +*  flag            - 1 == enable 0 == disable
> +*  Retval          - 0 -> Success else non-zero
> +**/
> +int pr785_enbl_dcdc(TPS_module_type tps_mod_type, unsigned int en_flag)
> +{
> +	unsigned char vsel1;
> +	int ret;
> +
> +	ret = pwr_i2c_read(tps_mod_type, TPS6235X_REG_VSEL1, &vsel1);
> +	if (ret == 0) {
> +		if (en_flag)
> +			vsel1 |= TPS6235X_EN_DCDC;
> +		else
> +			vsel1 &= ~(TPS6235X_EN_DCDC);
> +		ret = pwr_i2c_write(tps_mod_type, TPS6235X_REG_VSEL1, vsel1);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(pr785_enbl_dcdc);
> +
> +

one blank line is enough.

> +/**
> +*  TPSPR785            - Specific functions
> +*  pr785_set_dcdc_volt - Allows the caller to set a particular voltage on
> +*                        for CORE or MPU
> +*
> +*  voltage              - voltage to be set in millivolts (75--1537)
> +*  Retval          - 0 -> Success else non-zero
> +**/
> +int pr785_set_dcdc_volt(TPS_module_type tps_mod_type, unsigned int millivolts)
> +{
> +	unsigned char vsel1;
> +	unsigned int volt;
> +
> +	/* check if the millivolts is within range */
> +	if ((millivolts < PR785_MIN_CORE_VOLT) ||
> +		(millivolts > PR785_MAX_CORE_VOLT))
> +		return -1;
> +
> +	/* Output voltage set is = min_op_volt + ( VSM * 12.5mv) */
> +	volt = millivolts - PR785_MIN_CORE_VOLT;
> +	volt /= 25;
> +	volt *= 2;
> +	vsel1 = ((TPS6235X_EN_DCDC) | (volt & TPS6235X_VSM_MSK));
> +	return  pwr_i2c_write(tps_mod_type, TPS6235X_REG_VSEL1, vsel1);
> +}
> +EXPORT_SYMBOL(pr785_set_dcdc_volt);
> +
> +/**
> +*  TPSPR785            - Specific functions
> +*  pr785_get_dcdc_volt - Allows the caller to get the set voltage on a
> +*                        particular TPS 6235x device on PR785 card
> +*
> +*  voltage              - voltage to be set in millivolts (75--1537)
> +*  Retval          - 0 -> Success else non-zero
> +**/
> +int pr785_get_dcdc_volt(TPS_module_type tps_mod_type, unsigned int *millivolts)
> +{
> +	unsigned char vsel1;
> +	unsigned int volt;
> +
> +	/* Read the VSEL1 register to get VSM */
> +	pwr_i2c_read(tps_mod_type, TPS6235X_REG_VSEL1, &vsel1);
> +	/* Output voltage set is = min_op_volt + ( VSM * 12.5mv) */
> +	/* To cut out floating point operation we will multiply by 25
> +	divide by 2 */
> +	volt = (((vsel1 & TPS6235X_VSM_MSK) * 25) / 2) + PR785_MIN_CORE_VOLT;
> +	*millivolts = volt;
> +	return 0;
> +}
> +EXPORT_SYMBOL(pr785_get_dcdc_volt);
> +
> +/**
> + * tps_6235x_probe - TPS6235x driver i2c probe handler
> + * @client: i2c driver client device structure
> + *
> + * Register PR785 as an i2c client device driver
> + */
> +static struct i2c_driver tps_6235x_i2c_driver;
> +
> +static
> +int tps_6235x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	unsigned char reg_val;
> +
> +	printk(KERN_INFO "tps_6235x_probe:TPS addr = %x\n", (int)client->addr);
> +
> +	if (i2c_get_clientdata(client))
> +		return -EBUSY;
> +
> +	/* Device probed is TPS62352 CORE pwr chip if driver_data  = 0 */
> +	/* Device probed is TPS62353 MPU pwr chip if driver_data = 1 */
> +	tps_6235x_infodata[id->driver_data].client = client;
> +	tps_6235x_infodata[id->driver_data].tps_i2c_addr = client->addr;
> +	tps_6235x_infodata[id->driver_data].state = 1;
> +	tps_6235x_infodata[id->driver_data].i2c_dev = &client->dev;
> +
> +	tps_6235x_read_reg(client, TPS6235X_REG_CTRL2, &reg_val);
> +	reg_val |= (TPS6235X_OUT_DIS_MSK | TPS6235X_GO_MSK);
> +	tps_6235x_write_reg(client, TPS6235X_REG_CTRL2, reg_val);
> +	tps_6235x_read_reg(client, TPS6235X_REG_CTRL2, &reg_val);
> +
> +	if (reg_val & TPS6235X_PWR_OK_MSK)
> +		printk(KERN_INFO "Power is OK  %x\n", reg_val);
> +	else
> +		printk(KERN_INFO "Power not within range = %x\n", reg_val);
> +	return 0;
> +}
> +
> +/**
> + * tps_6235x_remove - TPS6235x driver i2c remove handler
> + * @client: i2c driver client device structure
> + *
> + * UnregisterPR785  as an i2c client device driver
> + */
> +static int __exit tps_6235x_remove(struct i2c_client *client)
> +{
> +#ifdef DEBUG
> +	printk(KERN_INFO "tps_6235x_remove invoked\n");
> +#endif
> +
> +	if (!client->adapter)
> +		return -ENODEV;	/* our client isn't attached */
> +
> +	i2c_set_clientdata(client, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id tps_6235x_id[] = {
> +	{ "tps62352_core_pwr", 0},
> +	{ "tps62353_mpu_pwr", 1},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, tps_6235x_id);
> +
> +static struct i2c_driver tps_6235x_i2c_driver = {
> +	.driver = {
> +		.name = "tps6235x_power",
> +		.owner = THIS_MODULE,
> +		},
> +	.probe = tps_6235x_probe,
> +	.remove = __exit_p(tps_6235x_remove),
> +	.id_table = tps_6235x_id,
> +};
> +
> +/**
> + * tps_6235x_init
> + *
> + * Module init function
> + */
> +static int __init tps_6235x_init(void)
> +{
> +	int err;
> +
> +#ifdef DEBUG
> +	printk(KERN_INFO "tps_6235x_init invoked\n");
> +#endif
> +
> +	err = i2c_add_driver(&tps_6235x_i2c_driver);
> +	if (err) {
> +		printk(KERN_ERR "Failed to register " MODULE_NAME ".\n");
> +		return err;
> +	} else {
> +		printk(KERN_INFO "I2c driver registered\n");
> +	}
> +	return 0;
> +}
> +
> +/**
> + * tps_6235x_cleanup
> + *
> + * Module exit function
> + */
> +static void __exit tps_6235x_cleanup(void)
> +{
> +#ifdef DEBUG
> +	printk(KERN_INFO "tps_6235x_cleanup invoked\n");
> +#endif
> +	i2c_del_driver(&tps_6235x_i2c_driver);
> +}
> +
> +late_initcall(tps_6235x_init);
> +module_exit(tps_6235x_cleanup);
> +
> +MODULE_AUTHOR("Texas Instruments");
> +MODULE_DESCRIPTION("TPS6235x based PR785 linux driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
