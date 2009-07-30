From: John Sarman <johnsarman@gmail.com>
Subject: MMC3 Overo
Date: Thu, 30 Jul 2009 11:49:03 -0400
Message-ID: <bb2708720907300849m78b24a3av3721ccf272cbaa5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f183.google.com ([209.85.211.183]:51223 "EHLO
	mail-yw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbZG3P4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 11:56:12 -0400
Received: by ywh13 with SMTP id 13so792433ywh.15
        for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2009 08:56:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

I am trying to use mmc3 on the Overo Gumstix board with no luck.  I
have patched the kernel with the latest changes and have yet to see a
clk pulse, both before and after the patches.
So far I have reconfigured the pins with uboot to GPIO and tested each
pin to verify that the signals are connected properly.  That test
passed.
Then I reconfigured them back to MODE 2(mmc modes) for each pin.  I am
confident that the level transceiver(TXS0108ERGYR) is operating
properly. This transceiver is automatic so no external controls are
necessary.


<u-boot_snip>
 MUX_VAL(CP(ETK_CLK_ES2),       (IDIS | PTU | EN  | M2)) /*MMC3_CLK*/\
 MUX_VAL(CP(ETK_CTL_ES2),       (IEN  | PTU | EN  | M2)) /*MMC3_CMD*/\
 MUX_VAL(CP(ETK_D3_ES2),        (IEN  | PTU | EN  | M2)) /*MMC3_DAT3*/\
 MUX_VAL(CP(ETK_D4_ES2),        (IEN  | PTU | EN  | M2)) /*MMC3_DAT0*/\
 MUX_VAL(CP(ETK_D5_ES2),        (IEN  | PTU | EN  | M2)) /*MMC3_DAT1*/\
 MUX_VAL(CP(ETK_D6_ES2),        (IEN  | PTU | EN  | M2)) /*MMC3_DAT2*/\
</u-boot_snip>

<mmc_params>
// I Switched mmc 2 and 3 in a feeble attempt.  Also I removed 2 in an
earlier attempt and the kernel would not boot ???????
// Also I have tested working gpio connected to CD and WP but not
attempting to tackle that yet.
static struct twl4030_hsmmc_info mmc[] = {
        {
                .mmc            = 1,
                .wires          = 4,
                .gpio_cd        = -EINVAL,
                .gpio_wp        = -EINVAL,
        },
        {
                .mmc            = 3,
                .wires          = 4,
                .gpio_cd        = -EINVAL,
                .gpio_wp        = -EINVAL,
        },
        {
                .mmc            = 2,
                .wires          = 4,
                .gpio_cd        = -EINVAL,
                .gpio_wp        = -EINVAL,
                .transceiver    = true,
                .ocr_mask       = 0x00100000,   /* 3.3V */
        },
        {}      /* Terminator */
};
</mmc_params>

<twl_setup>

static int overo_twl_gpio_setup(struct device *dev,
                unsigned gpio, unsigned ngpio)
{
        twl4030_mmc_init(mmc);        <-- mmc params    passed to init

        overo_vmmc1_supply.dev = mmc[0].dev;

        return 0;
}
static struct twl4030_gpio_platform_data overo_gpio_data = {
        .gpio_base      = OMAP_MAX_GPIO_LINES,
        .irq_base       = TWL4030_GPIO_IRQ_BASE,
        .irq_end        = TWL4030_GPIO_IRQ_END,
        .setup          = overo_twl_gpio_setup,
<-----    setup passed into the twl4030 gpio platform data
};

static struct twl4030_platform_data overo_twldata = {
        .irq_base       = TWL4030_IRQ_BASE,
        .irq_end        = TWL4030_IRQ_END,
        .gpio           = &overo_gpio_data,
<--- gpio data passed into twl4030 plat data
        .usb            = &overo_usb_data,
        .power          = GENERIC3430_T2SCRIPTS_DATA,
        .vmmc1          = &overo_vmmc1,
};

static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
        {
                I2C_BOARD_INFO("tps65950", 0x48),
                .flags = I2C_CLIENT_WAKE,
                .irq = INT_34XX_SYS_NIRQ,
                .platform_data = &overo_twldata,
        },
};

static int __init overo_i2c_init(void)
{
        omap_register_i2c_bus(1, 2600, overo_i2c_boardinfo,
                        ARRAY_SIZE(overo_i2c_boardinfo));
        /* i2c2 pins are used for gpio */
        omap_register_i2c_bus(3, 400, NULL, 0);
        return 0;
}

// i2c_init called first in init.
static void __init overo_init(void)
{
        overo_i2c_init();
 .....
 </twl_setup>


So the way I see it working is i2c is initialized, which sets up the
twl4030.  When the twl4030 configures gpio it initializes the mmc.
mmc0 comes up fine (I have a root File System), but I never get a clk
on mmc3.

Any help would be greatly appreciated.

Thanks
John Sarman
