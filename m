From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Problems while designing TPS65023 regulator driver
Date: Thu, 26 Feb 2009 14:41:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54036 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbZBZJME convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 04:12:04 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1Q9BvYS018865
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 03:12:03 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1Q9BuCx006450
	for <linux-omap@vger.kernel.org>; Thu, 26 Feb 2009 14:41:56 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi,

I am working on TPS65023 PMIC (http://focus.ti.com/docs/prod/folders/print/tps65023.html) regulator driver. It supports 3 step-down converters and 2 LDOs, all connected to the same I2C device. I am facing some design related issues and need your opinion on the same.

Since all the five regulators can be controlled using a single i2c device, I made a single i2c_board_info structure in my platform specific file and put all the regulator_init_data information there:

<<<<<code starts>>>>
/* MPU voltage regulator of DCDC type */
struct regulator_consumer_supply tps65023_mpu_consumers = {
	.supply = "vdd1",
};

/* MMC voltage regulator of LDO type */
struct regulator_consumer_supply tps65023_mmc_consumers = {
	.supply = "mmc",
};

struct regulator_init_data tps_regulator_data[] = {
	{
		.constraints = {
			.min_uV = 800000,
			.max_uV = 1600000,
			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
				REGULATOR_CHANGE_STATUS),
		},
		.num_consumer_supplies  = 1,
		.consumer_supplies      = &tps65023_mpu_consumers,
	},
	.
	.
	.
	{
		.constraints = {
			.min_uV = 1050000,
			.max_uV = 3300000,
			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
				REGULATOR_CHANGE_STATUS),
		},
		.num_consumer_supplies  = 1,
		.consumer_supplies      = &tps65023_mmc_consumers,
	},
};

static struct i2c_board_info __initdata tps_65023_i2c_board_info[] = {
	{
		I2C_BOARD_INFO("tps65023", 0x48),
		.flags = I2C_CLIENT_WAKE,
		.platform_data = &tps_regulator_data[0],
	},
};

static int __init omap3_evm_i2c_init(void)
{
	omap_register_i2c_bus(1, 400, tps_65023_i2c_board_info,
		ARRAY_SIZE(tps_65023_i2c_board_info));
        .
        .
}
<<<<<code ends>>>>

Now, in my regulator driver code, I am creating an array of the available regulators, passing that array as driver_data in my i2c_device_id structure and registering my i2c_driver using i2c_add_driver() during initialization, as shown below:

<<<<<code starts>>>>
#define TPS65023_NUM_DCDC		3
#define TPS65023_NUM_LDO		2
#define TPS65023_NUM_REGULATOR	(TPS65023_NUM_DCDC + TPS65023_NUM_LDO)

struct tps_info {
	const char 	*name;
	unsigned		min_uV;
	unsigned		max_uV;
	bool			fixed;
	u8			table_len;
	const u16		*table;
};

struct tps {
	struct regulator_desc	desc[TPS65023_NUM_REGULATOR];
	struct i2c_client		*client;
	struct regulator_dev	*rdev[TPS65023_NUM_REGULATOR];
	const struct tps_info	*info[TPS65023_NUM_REGULATOR];
};

static const struct tps_info tps65023_regs[] = {
	{
	.name = "VDCDC1",
	.min_uV		=  800000,
	.max_uV		= 1600000,
	.fixed = 0,
	.table_len = ARRAY_SIZE(VDCDC1_VSEL_table),
	.table = VDCDC1_VSEL_table,
	},
	.	
	.
	.
	{
	.name = "LDO2",
	.min_uV		= 1000000,
	.max_uV		= 3150000,
	.fixed = 0,
	.table_len = ARRAY_SIZE(LDO2_VSEL_table),
	.table = LDO2_VSEL_table,
	},
};

static const struct i2c_device_id tps_65023_id = {
	.name = "tps65023",
	.driver_data = (unsigned long) &tps65023_regs[0],
};

MODULE_DEVICE_TABLE(i2c, tps_65023_id);

static struct i2c_driver tps_65023_i2c_driver = {
	.driver = {
		.name	=	"tps_65023_pwr",
		.owner	=	THIS_MODULE,
	},
	.probe		= tps_65023_probe,
	.remove	= __devexit_p(tps_65023_remove),
	.id_table	= &tps_65023_id,
};

/**
 * tps_65023_init
 *
 * Module init function
 */
static int __init tps_65023_init(void)
{
	return i2c_add_driver(&tps_65023_i2c_driver);
}
late_initcall(tps_65023_init);
<<<<<code ends>>>>

Now, the problem is in the tps_65023_probe function. Since it will be called only once as there is only one i2c device, I have to register all the regulators in that only. But I am not able to communicate the same to the regulator core layer. Inside the regulator_register(), variable init_data, which equals to dev->platform_data, is always pointing to the first array member, which is coming from the evm specific file. And it fails to register my second regulator instance, set_consumer_device_supply() specifically failing for the second iteration. Because of this, the probe function fails.

How should I handle this scenario? Am I missing something in my implementation?

Regards,
Anuj Aggarwal
