From: Peter Barada <peter.barada@gmail.com>
Subject: Problems with suspend/resume on DM3730...
Date: Tue, 29 Mar 2011 14:35:29 -0400
Message-ID: <4D922671.8070001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37404 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1C2Seh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Mar 2011 14:34:37 -0400
Received: by ywj3 with SMTP id 3so195986ywj.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Mar 2011 11:34:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP list <linux-omap@vger.kernel.org>, Peter Barada <peter.barada@gmail.com>

I've pulled the latest for-next branch using the following URL:

http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=4fa8eebb045a6d798011f3935a38dd29de30e6c9

and have built it using omap2plus_defconfig (and adding/enabling the following minimal board file):

/*
 * linux/arch/arm/mach-omap2/board-dm3730logic.c
 *
 * Copyright (C) 2011 Logic Product Development
 *
 * Modified from mach-omap2/board-omap3evm.c
 *
 * Initial code: Syed Mohammed Khasim
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/delay.h>
#include <linux/err.h>
#include <linux/clk.h>
#include <linux/gpio.h>
#include <linux/input.h>
#include <linux/interrupt.h>

#include <linux/i2c/twl.h>

#include <linux/regulator/fixed.h>
#include <linux/regulator/machine.h>
#include <linux/mmc/host.h>

#include <mach/hardware.h>
#include <asm/mach-types.h>
#include <asm/mach/arch.h>
#include <asm/mach/map.h>

#include <plat/board.h>
#include <plat/usb.h>
#include <plat/common.h>

#include "mux.h"
#include "hsmmc.h"
#include "sdram-micron-mt29c4g48mazapakq-5.h"

#include "board-dm3730logic.h"

static struct omap2_hsmmc_info mmc[] = {
    {
        .mmc        = 1,
        .caps        = MMC_CAP_4_BIT_DATA,
        .gpio_cd    = -EINVAL,
        .gpio_wp    = -EINVAL,
    },
    {}    /* Terminator */
};

static struct regulator_consumer_supply dm3730logic_vmmc1_supply = {
    .supply            = "vmmc",
};

static int dm3730logic_twl_gpio_setup(struct device *dev,
        unsigned gpio, unsigned ngpio)
{
    omap2_hsmmc_init(mmc);

    /* link regulator to MMC adapter */
    dm3730logic_vmmc1_supply.dev = mmc[0].dev;

    return 0;
}

static struct twl4030_gpio_platform_data dm3730logic_gpio_data = {
    .gpio_base    = OMAP_MAX_GPIO_LINES,
    .irq_base    = TWL4030_GPIO_IRQ_BASE,
    .irq_end    = TWL4030_GPIO_IRQ_END,
    .use_leds    = true,
    .setup        = dm3730logic_twl_gpio_setup,
};

/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
static struct regulator_init_data dm3730logic_vmmc1 = {
    .constraints = {
        .min_uV            = 1850000,
        .max_uV            = 3150000,
        .valid_modes_mask    = REGULATOR_MODE_NORMAL
                    | REGULATOR_MODE_STANDBY,
        .valid_ops_mask        = REGULATOR_CHANGE_VOLTAGE
                    | REGULATOR_CHANGE_MODE
                    | REGULATOR_CHANGE_STATUS,
    },
    .num_consumer_supplies    = 1,
    .consumer_supplies    = &dm3730logic_vmmc1_supply,
};

static struct twl4030_platform_data dm3730logic_twldata = {
    .irq_base    = TWL4030_IRQ_BASE,
    .irq_end    = TWL4030_IRQ_END,

    .gpio        = &dm3730logic_gpio_data,

    /* platform_data for children goes here */
    .vmmc1        = &dm3730logic_vmmc1,
};

static struct i2c_board_info __initdata dm3730logic_i2c_boardinfo[] = {
    {
        I2C_BOARD_INFO("twl4030", 0x48),
        .flags = I2C_CLIENT_WAKE,
        .irq = INT_34XX_SYS_NIRQ,
        .platform_data = &dm3730logic_twldata,
    },
};

static int __init dm3730logic_i2c_init(void)
{
    omap_register_i2c_bus(1, 2600, dm3730logic_i2c_boardinfo,
            ARRAY_SIZE(dm3730logic_i2c_boardinfo));
    return 0;
}

static void __init dm3730logic_init_early(void)
{
    omap2_init_common_infrastructure();
    omap2_init_common_devices(mt29c4g48mazapakq5_sdrc_params,
                NULL);
}

#ifdef CONFIG_OMAP_MUX
static struct omap_board_mux board_mux[] __initdata = {
    { .reg_offset = OMAP_MUX_TERMINATOR },
};
#endif

static struct platform_device *dm3730logic_devices[] __initdata = {
};

static void __init dm3730logic_init(void)
{
    /* hang on start */
    while (dm3730logic_hang)
        ;

    omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
    dm3730logic_i2c_init();
    platform_add_devices(dm3730logic_devices,
            ARRAY_SIZE(dm3730logic_devices));
    omap_serial_init();
}

MACHINE_START(DM3730_SOM_LV, "DM3730 SOM LV")
    /* Maintainer: Peter Barada - Logic Product Development */
    .boot_params    = 0x80000100,
    .reserve    = omap_reserve,
    .map_io        = omap3_map_io,
    .init_early    = dm3730logic_init_early,
    .init_irq    = omap_init_irq,
    .init_machine    = dm3730logic_init,
    .timer        = &omap_timer,
MACHINE_END

MACHINE_START(DM3730_TORPEDO, "DM3730 Torpedo")
    /* Maintainer: Peter Barada - Logic Product Development */
    .boot_params    = 0x80000100,
    .reserve    = omap_reserve,
    .map_io        = omap3_map_io,
    .init_early    = dm3730logic_init_early,
    .init_irq    = omap_init_irq,
    .init_machine    = dm3730logic_init,
    .timer        = &omap_timer,
MACHINE_END


When I boot the kernel, enter suspend and attempt to resume via hitting a key on the console, it doesn't come back out of suspend.  I get the following output:

DM-37x# mkdir /debug
DM-37x# mount -t debugds debug /debug
mount: mounting debug on /debug failed: No such device
DM-37x# mount -t debugfs debug /debug
DM-37x# grep WAKE /debug/omap_mux/*
DM-37x# echo mem > /sys/power/state
[   45.389373] PM: Syncing filesystems ... done.
[   45.399566] PM: Preparing system for mem sleep
[   45.418609] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   45.445465] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[   45.476623] PM: Entering mem sleep
[   45.485473] omap_device: omap_i2c.1: new worst case activate latency 0: 91552
[   45.499816] PM: suspend of devices complete after 14.770 msecs
[   45.508575] PM: late suspend of devices complete after 2.502 msecs
[   45.515197] Disabling non-boot CPUs ...
[   45.520019] omap_device: omap_uart.2: new worst case deactivate latency 0: 91552

And its dead. If I hook up a BDI and debug it, when I attach after trying to resume, GDB shows the pc at the instruction after wfi in _omap_sram_idle:

(gdb) tar remo abatron:2001
A program is being debugged already.  Kill it? (y or n) y
Remote debugging using abatron:2001
0xc00c35b0 in trace_hardirqs_on_caller (ip=3221677248) at kernel/lockdep.c:2309
(gdb) c
Continuing.
  C-c C-c
Program received signal SIGSTOP, Stopped (signal).
0xfe40f534 in ?? ()
(gdb) where 5
#0  0xfe40f534 in ?? ()
#1  0xc006e028 in omap_sram_idle () at arch/arm/mach-omap2/pm34xx.c:439
#2  0xc0602f28 in omap2_sram_idle ()
#3  0xc0602f28 in omap2_sram_idle ()
Backtrace stopped: previous frame identical to this frame (corrupt stack?)
(gdb) x/4i $pc-4
0xfe40f530:    wfi
0xfe40f534:    nop    {0}
0xfe40f538:    nop    {0}
0xfe40f53c:    nop    {0}
(gdb)

And continuing brings me back to the prompt.

I tried to set /debug/pm_debug/wakeup_timer_second to 10 and suspended again it came back to a prompt after 10 seconds:

DM-37x# echo mem > /sys/power/state
[ 2222.240692] PM: Syncing filesystems ... done.
[ 2222.251098] PM: Preparing system for mem sleep
[ 2222.269958] Freezing user space processes ... (elapsed 0.01 seconds) done.
[ 2222.296844] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[ 2222.328002] PM: Entering mem sleep
[ 2222.343566] PM: suspend of devices complete after 7.141 msecs
[ 2222.352233] PM: late suspend of devices complete after 2.532 msecs
[ 2222.358825] Disabling non-boot CPUs ...
[ 2222.363525] PM: Resume timer in 10.000 secs (327680 ticks at 32768 ticks/sec.)
[ 2222.371337] omap_device: omap_uart.2: new worst case deactivate latency 0: 91552
[ 2232.363708] omap_device: omap_uart.0: new worst case activate latency 0: 61035
[ 2232.371398] Powerdomain (core_pwrdm) didn't enter target state 1
[ 2232.377716] Could not enter target state in pm_suspend
[ 2232.385681] PM: early resume of devices complete after 1.251 msecs
[ 2232.397308] PM: resume of devices complete after 4.821 msecs
[ 2232.408172] PM: Finishing wakeup.
[ 2232.411682] Restarting tasks ... done.


1) Why doesn't sending a key to the console wake up the DM3730 whereas the timer can bring the kernel out of suspend?

After the kernel resumes I looked at the pinmux, and I see the following have WAKEUP enable set:

DM-37x# grep WAKE /debug/omap_mux/*
/debug/omap_mux/gpmc_wait3:mode: OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE1
/debug/omap_mux/uart1_rx:mode: OMAP_PIN_INPUT | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE0
/debug/omap_mux/uart2_rx:mode: OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE7
/debug/omap_mux/uart3_rx_irrx:mode: OMAP_PIN_INPUT | OMAP_PIN_OFF_WAKEUPENABLE | OMAP_MUX_MODE0

2) Why does gpmc_wait3 have WAKEUPENABLE enabled?  Where is that done (grepping doesn't come up with anything)?

When I tried disabling the timer and suspend again it immediately comes back to the prompt and a 3rd attempt to suspend does (but doesn't resume and GDB shows it again at the instruction past the wfi instruction in _omap_sram_idle()):

DM-37x# echo 0 > /debug/pm_debug/wakeup_timer_seconds
DM-37x# echo mem > /sys/power/state
[ 2900.775756] PM: Syncing filesystems ... done.
[ 2900.781768] PM: Preparing system for mem sleep
[ 2900.787902] Freezing user space processes ... (elapsed 0.02 seconds) done.
[ 2900.816925] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) don
e.
[ 2900.848175] PM: Entering mem sleep
[ 2900.861938] PM: suspend of devices complete after 5.890 msecs
[ 2900.870513] PM: late suspend of devices complete after 2.533 msecs
[ 2900.877044] Disabling non-boot CPUs ...
[ 2900.881713] Powerdomain (mpu_pwrdm) didn't enter target state 1
[ 2900.887908] Powerdomain (neon_pwrdm) didn't enter target state 1
[ 2900.894226] Powerdomain (core_pwrdm) didn't enter target state 1
[ 2900.900512] Powerdomain (dss_pwrdm) didn't enter target state 1
[ 2900.906707] Powerdomain (per_pwrdm) didn't enter target state 1
[ 2900.912902] Could not enter target state in pm_suspend
[ 2900.919647] PM: early resume of devices complete after 1.221 msecs
[ 2900.930755] PM: resume of devices complete after 4.394 msecs
[ 2900.941131] PM: Finishing wakeup.
[ 2900.944610] Restarting tasks ... done.

3) Why would disabling the timer cause the suspend/resume to immediately return?

Any help is appreciated!

-- 
Peter Barada
peter.barada@gmail.com

