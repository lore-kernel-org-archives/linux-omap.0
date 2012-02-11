From: Kuzemko Alexandr <kuzemkoa@rambler.ru>
Subject: [Question] How to add other device to OMAP4430 i2c.0 bus?
Date: Sat, 11 Feb 2012 10:32:24 +0000 (UTC)
Message-ID: <loom.20120211T113116-941@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:55125 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753318Ab2BKMGf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 11 Feb 2012 07:06:35 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1RwBO3-0005Cv-Ob
	for linux-omap@vger.kernel.org; Sat, 11 Feb 2012 12:45:04 +0100
Received: from cpe-109-108-249-76.enet.vn.ua ([109.108.249.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 12:45:03 +0100
Received: from kuzemkoa by cpe-109-108-249-76.enet.vn.ua with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 11 Feb 2012 12:45:03 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello all.
I have working kernel 2.6.35 from B@N Nook Tablet. I want port it on the 3.x 
branch. 
On the 2.6 branch I have such i2c bus initialization:

static int __init omap4_i2c_init(void)
{
        omap_i2c_hwspinlock_init(1, 0, &sdp4430_i2c_bus_pdata);
        omap_i2c_hwspinlock_init(2, 1, &sdp4430_i2c_2_bus_pdata);
        omap_i2c_hwspinlock_init(3, 2, &sdp4430_i2c_3_bus_pdata);
        omap_i2c_hwspinlock_init(4, 3, &sdp4430_i2c_4_bus_pdata);

        regulator_has_full_constraints();

        /*
         * Phoenix Audio IC needs I2C1 to
         * start with 400 KHz or less
         */
        omap_register_i2c_bus(1, 400, &sdp4430_i2c_bus_pdata,
                        sdp4430_i2c_boardinfo, ARRAY_SIZE
(sdp4430_i2c_boardinfo));
        omap_register_i2c_bus(2, 400, &sdp4430_i2c_2_bus_pdata,
                        sdp4430_i2c_2_boardinfo, ARRAY_SIZE
(sdp4430_i2c_2_boardinfo));
        omap_register_i2c_bus(3, 400, &sdp4430_i2c_3_bus_pdata,
                        sdp4430_i2c_3_boardinfo, ARRAY_SIZE
(sdp4430_i2c_3_boardinfo));
        omap_register_i2c_bus(4, 400, &sdp4430_i2c_4_bus_pdata,
                        sdp4430_i2c_4_boardinfo, ARRAY_SIZE
(sdp4430_i2c_4_boardinfo));
        return 0;
}
where 
static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
        {
                I2C_BOARD_INFO("twl6030", 0x48),
                .flags = I2C_CLIENT_WAKE,
                .irq = OMAP44XX_IRQ_SYS_1N,
                .platform_data = &sdp4430_twldata,
        },
        {
                I2C_BOARD_INFO(KXTF9_DEVICE_ID, KXTF9_I2C_SLAVE_ADDRESS),
                .platform_data = &kxtf9_platform_data_here,
                .irq = 0,
        },
        {
                I2C_BOARD_INFO(MAX17042_DEVICE_ID, MAX17042_I2C_SLAVE_ADDRESS),
                .platform_data = &max17042_platform_data_here,
                .irq = 0,
        },
};

On 3.2 branch I can see such initialization:

static int __init omap4_i2c_init(void)
{
        omap4_pmic_get_config(&sdp4430_twldata, TWL_COMMON_PDATA_USB,
                        TWL_COMMON_REGULATOR_VDAC |
                        TWL_COMMON_REGULATOR_VAUX2 |
                        TWL_COMMON_REGULATOR_VAUX3 |
                        TWL_COMMON_REGULATOR_VMMC |
                        TWL_COMMON_REGULATOR_VPP |
                        TWL_COMMON_REGULATOR_VANA |
                        TWL_COMMON_REGULATOR_VCXIO |
                        TWL_COMMON_REGULATOR_VUSB |
                        TWL_COMMON_REGULATOR_CLK32KG);
        omap4_pmic_init("twl6030", &sdp4430_twldata);
        omap_register_i2c_bus(2, 400, NULL, 0);
        omap_register_i2c_bus(3, 400, sdp4430_i2c_3_boardinfo,
                                ARRAY_SIZE(sdp4430_i2c_3_boardinfo));
        omap_register_i2c_bus(4, 400, sdp4430_i2c_4_boardinfo,
                                ARRAY_SIZE(sdp4430_i2c_4_boardinfo));
        return 0;
}

How to add other devices to i2c bus 0 (not only twl6030)?


