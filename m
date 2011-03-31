From: Peter Barada <peter.barada@gmail.com>
Subject: Re: Question regarding suspend/resume
Date: Thu, 31 Mar 2011 16:17:12 -0400
Message-ID: <4D94E148.8060905@gmail.com>
References: <4D7FBD31.6050806@gmail.com> <87wrk0gn41.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34471 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab1CaUPx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Mar 2011 16:15:53 -0400
Received: by yxs7 with SMTP id 7so1132881yxs.19
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 13:15:52 -0700 (PDT)
In-Reply-To: <87wrk0gn41.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linux OMAP list <linux-omap@vger.kernel.org>

On 03/15/2011 04:11 PM, Kevin Hilman wrote:
> Peter Barada <peter.barada@gmail.com> writes:
>
>> Is there any reference how to decode the output of
>> /debug/pm_debug/count?  I'm trying to figure out when I resume why it
>> says the core_pwrdm didn't enter the target state, and I'm assuming
>> because a clock used is not disabled in the suspend path, but as fars
>> as I can tell there's no output in the pm_debug code that tells which
>> clocks in a power domain are active at the time of a suspend.
> You're right.
>
> What you need the patch in my pm-wip/debug branch from my pm tree[1].
> With that patch, it takes a snapshot of the PRCM registers just before
> and after suspend.
>
> When you come back from suspend, view the register snapshot just before
> suspend:
>
> # cat /debug/pm_debug/register/1  
>
> and the register snapshot just after
>
> # cat /debug/pm_debug/register/2
>
> the snapshot just before suspend is useful for debugging problems like
> yours, and the snapshot just after can be useful for debugging wakeups.
>
> Feel free to post the register dump if you want some help deciphering
> it.  If you do, please post more details on what kernel you're using as
> well as the bootloader etc.
Kevin,

Thanks for helping me to understand things.

The kernel I'm using is TI's OMAPPSP_03.00.01.06 2.6.32 kernel [1] with their u-boot [2] and x-loader[3], modified to run on Logic's DM3730 board(s) (as we use the Micron mt29c4g48mazapakq-5 POP).  I've added to this kernel a stripped board file (stripped from board-omap3evm.c) that supplies enough to bring up the mmc and serial ports - platform code registers other devices.  Its built with omap3_evm_defconfig with the addition of my MACH_DM3730_SOM_LV/TORPEDO machine description (which causes my board-dm3730logic.c minimal board file to be compiled in):

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
#include "sdram-micron-mt29c4g48mazapakq-5.h"
#include "mmc-twl4030.h"
#include "pm.h"
#include "prm-regbits-34xx.h"
#include "omap3-opp.h"

static struct twl4030_hsmmc_info mmc[] = {
    {
        .mmc        = 1,
        .wires        = 4,
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
    twl4030_mmc_init(mmc);

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

#ifdef CONFIG_OMAP_MUX
static struct omap_board_mux board_mux[] __initdata = {
    { .reg_offset = OMAP_MUX_TERMINATOR },
};
#endif

static struct omap_board_config_kernel dm3730logic_config[] __initdata = {
};

static struct omap_opp * _omap37x_mpu_rate_table    = omap37x_mpu_rate_table;
static struct omap_opp * _omap37x_dsp_rate_table    = omap37x_dsp_rate_table;
static struct omap_opp * _omap37x_l3_rate_table        = omap37x_l3_rate_table;

static void __init dm3730logic_init_irq(void)
{

    omap_board_config = dm3730logic_config;
    omap_board_config_size = ARRAY_SIZE(dm3730logic_config);
    omap2_init_common_hw(mt29c4g48mazapakq5_sdrc_params,
            NULL,
            _omap37x_mpu_rate_table,
            _omap37x_dsp_rate_table,
            _omap37x_l3_rate_table);

    omap_init_irq();
    omap_gpio_init();
}

static struct platform_device *dm3730logic_devices[] __initdata = {
};

static void __init dm3730logic_init(void)
{
    omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
    dm3730logic_i2c_init();
    platform_add_devices(dm3730logic_devices,
            ARRAY_SIZE(dm3730logic_devices));
    omap_serial_init();
}

static void __init dm3730logic_map_io(void)
{
    omap2_set_globals_343x();
    omap2_map_common_io();
}

MACHINE_START(DM3730_SOM_LV, "DM3730 SOM LV")
    /* Maintainer: Peter Barada - Logic Product Development */
    .phys_io    = 0x48000000,
    .io_pg_offst    = ((0xfa000000) >> 18) & 0xfffc,
    .boot_params    = 0x80000100,
    .map_io        = dm3730logic_map_io,
    .init_irq    = dm3730logic_init_irq,
    .init_machine    = dm3730logic_init,
    .timer        = &omap_timer,
MACHINE_END

MACHINE_START(DM3730_TORPEDO, "DM3730 Torpedo")
    /* Maintainer: Peter Barada - Logic Product Development */
    .phys_io    = 0x48000000,
    .io_pg_offst    = ((0xfa000000) >> 18) & 0xfffc,
    .boot_params    = 0x80000100,
    .map_io        = dm3730logic_map_io,
    .init_irq    = dm3730logic_init_irq,
    .init_machine    = dm3730logic_init,
    .timer        = &omap_timer,
MACHINE_END

I've verified this kernel boots up (off an SD card) and goes fully into suspend on a DM3730EVM, but when booted on my board(s) shows the following (/debug/pm_debug/register output follow):

[root@arago /]# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
mmc0: card 0007 removed
Powerdomain (core_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
Restarting tasks ... done.
[root@arago /]# mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new high speed SD card at address 0007
mmcblk0: mmc0:0007 SD512 485 MiB
 mmcblk0: p1
[root@arago /]# mkdir /debug
[root@arago /]# mount -t debugfs debug /debug
[root@arago /]# cat /debug/pm_debug/registers/1
MOD: CM_IVA2 (48014000)
  04 => 00000017  20 => 00000001  34 => 00000001  40 => 00080a00
  44 => 00000001  48 => 00000003
MOD: CM_OCP (48004800)
  00 => 00000010  10 => 00000001
MOD: CM_MPU (48004900)
  04 => 00000037  24 => 00000001  34 => 00000001  40 => 00112c0c
  44 => 00000001  48 => 00000003  4c => 00000001
MOD: CM_CORE (48004a00)
  10 => 00000042  20 => ffffffbd  24 => 0000001f  28 => 0000000d
  30 => fffffed9  34 => 0000001f  38 => 0000000c  40 => 0000130a
  48 => 0000003f  4c => 00000003
MOD: CM_SGX (48004b00)
  20 => 00000001  40 => 00000005  48 => 00000003
MOD: CM_WKUP (48004c00)
  00 => 00000001  10 => 0000000d  20 => 000002f2  30 => 0000003f
  40 => 00000014
MOD: CM_CCR (48004d00)
  00 => f8311007  04 => 00000011  20 => 00000001  30 => 00000009
  34 => 00000001  40 => 08c80c00  44 => 0481b00c  48 => 00000009
  4c => 00003c0c  50 => 00000001  70 => 00000003
MOD: CM_DSS (48004e00)
  20 => 00000003  30 => 00000001  40 => 00001009  48 => 00000003
MOD: CM_CAM (48004f00)
  20 => 00000001  30 => 00000001  40 => 00000004  48 => 00000003
MOD: CM_PER (48005000)
  10 => 0003e000  20 => 00041fff  30 => 0003ffff  40 => 000000ff
  44 => 00000006  48 => 00000003  4c => 00000001
MOD: CM_EMU (48005100)
  40 => 03020a50  48 => 00000001
MOD: CM_NEON (48005300)
  48 => 00000003
MOD: CM_USB (48005400)
  20 => 00000003  30 => 00000001  48 => 00000003
MOD: PRM_IVA2 (48316000)
  50 => 00000007  e0 => 00ff0f05  e4 => 00000555  e8 => 00000555
MOD: PRM_OCP (48306800)
  04 => 00000010  14 => 00000001  1c => 00000201
MOD: PRM_MPU (48306900)
  d4 => 00000012  e0 => 00030105  e4 => 000000c7  e8 => 000000c7
MOD: PRM_CORE (48306a00)
  58 => 00000300  a0 => c33ffe18  a4 => c33ffe18  e0 => 000f0315
  e4 => 000000f7  e8 => 000000f7  f0 => 00000004  f8 => 00000004
MOD: PRM_SGX (48306b00)
  e0 => 00030104
MOD: PRM_WKUP (48306c00)
  a0 => 0001010b  a4 => 0000010b  b0 => 00010000
MOD: PRM_CCR (48306d00)
  40 => 00000003
MOD: PRM_DSS (48306e00)
  a0 => 00000001  e0 => 00030105  e4 => 00000001  e8 => 00000001
MOD: PRM_CAM (48306f00)
  58 => 00000001  e0 => 00030105  e4 => 00000001  e8 => 00000001
MOD: PRM_PER (48307000)
  a0 => 0003e807  a4 => 0003e807  c8 => 00000007  e0 => 00030105
  e4 => 00000007  e8 => 00000007
MOD: PRM_EMU (48307100)
  e4 => 00000100
MOD: PRM_GLBL (48307200)
  20 => 00120012  24 => 00010000  2c => 28201e00  30 => 2b201e00
  34 => 00120000  38 => 00000008  54 => 00001006  58 => 00000001
  60 => 00000002  64 => 00000050  70 => 00000048  90 => 0fff0fff
  94 => 000000ff  98 => 000000ff  9c => 00000002  a0 => 000000ff
  b0 => 00202808  b4 => 0001f401  b8 => 0001f404  bc => 4000ffff
  c0 => 00000028  c4 => 00000001  d0 => 00202b08  d4 => 0001f401
  d8 => 0001f404  dc => 2c00ffff  e0 => 0000002b  e4 => 00000001
MOD: PRM_NEON (48307300)
  c8 => 00000002  e0 => 00000005  e4 => 00000003  e8 => 00000003
MOD: PRM_USB (48307400)
  a0 => 00000001  a4 => 00000001  a8 => 00000001  e0 => 00030115
  e4 => 00000001  e8 => 00000001

[root@arago /]# cat /debug/pm_debug/registers/2
MOD: CM_IVA2 (48014000)
  04 => 00000017  20 => 00000001  34 => 00000001  40 => 00080a00
  44 => 00000001  48 => 00000003
MOD: CM_OCP (48004800)
  00 => 00000010  10 => 00000001
MOD: CM_MPU (48004900)
  04 => 00000037  24 => 00000001  34 => 00000001  40 => 00112c0c
  44 => 00000001  48 => 00000003  4c => 00000001
MOD: CM_CORE (48004a00)
  10 => 00000042  20 => ffffffbd  24 => 0000001f  28 => 0000000d
  30 => fffffed9  34 => 0000001f  38 => 0000000c  40 => 0000130a
  48 => 0000003f  4c => 00000003
MOD: CM_SGX (48004b00)
  20 => 00000001  40 => 00000005  48 => 00000003
MOD: CM_WKUP (48004c00)
  00 => 00000001  10 => 0000000d  20 => 000002f2  30 => 0000003f
  40 => 00000014
MOD: CM_CCR (48004d00)
  00 => f8311007  04 => 00000011  20 => 00000001  30 => 00000009
  34 => 00000001  40 => 08c80c00  44 => 0481b00c  48 => 00000009
  4c => 00003c0c  50 => 00000001  70 => 00000003
MOD: CM_DSS (48004e00)
  20 => 00000003  30 => 00000001  40 => 00001009  48 => 00000003
MOD: CM_CAM (48004f00)
  20 => 00000001  30 => 00000001  40 => 00000004  48 => 00000003
MOD: CM_PER (48005000)
  10 => 0003e000  20 => 00041fff  30 => 0003ffff  40 => 000000ff
  44 => 00000006  48 => 00000003  4c => 00000001
MOD: CM_EMU (48005100)
  40 => 03020a50  48 => 00000001
MOD: CM_NEON (48005300)
  48 => 00000003
MOD: CM_USB (48005400)
  20 => 00000003  30 => 00000001  48 => 00000003
MOD: PRM_IVA2 (48316000)
  50 => 00000007  e0 => 00ff0f05  e4 => 00000555  e8 => 00000555
MOD: PRM_OCP (48306800)
  04 => 00000010  14 => 00000001  18 => 00000201  1c => 00000201
MOD: PRM_MPU (48306900)
  d4 => 00000012  e0 => 00030105  e4 => 000000c7  e8 => 00000045
MOD: PRM_CORE (48306a00)
  58 => 00000300  a0 => c33ffe18  a4 => c33ffe18  b0 => 00002000
  e0 => 000f0315  e4 => 000000f7  e8 => 000000f7  f0 => 00000004
  f8 => 00000004
MOD: PRM_SGX (48306b00)
  e0 => 00030104
MOD: PRM_WKUP (48306c00)
  a0 => 0001010b  a4 => 0000010b  b0 => 00010100
MOD: PRM_CCR (48306d00)
  40 => 00000003
MOD: PRM_DSS (48306e00)
  a0 => 00000001  e0 => 00030105  e4 => 00000001  e8 => 00000001
MOD: PRM_CAM (48306f00)
  58 => 00000001  e0 => 00030105  e4 => 00000001  e8 => 00000001
MOD: PRM_PER (48307000)
  a0 => 0003e807  a4 => 0003e807  c8 => 00000007  e0 => 00030105
  e4 => 00000007  e8 => 00000005
MOD: PRM_EMU (48307100)
  e4 => 00000100
MOD: PRM_GLBL (48307200)
  20 => 00120012  24 => 00010000  2c => 28201e00  30 => 2b201e00
  34 => 00120000  38 => 00000008  54 => 00001006  58 => 00000001
  60 => 00000002  64 => 00000050  70 => 00000048  90 => 0fff0fff
  94 => 000000ff  98 => 000000ff  9c => 00000002  a0 => 000000ff
  b0 => 00202808  b4 => 0001f401  b8 => 0001f404  bc => 4000ffff
  c0 => 00000028  c4 => 00000001  d0 => 00202b08  d4 => 0001f401
  d8 => 0001f404  dc => 2c00ffff  e0 => 0000002b  e4 => 00000001
MOD: PRM_NEON (48307300)
  c8 => 00000002  e0 => 00000005  e4 => 00000003  e8 => 00000001
MOD: PRM_USB (48307400)
  a0 => 00000001  a4 => 00000001  a8 => 00000001  e0 => 00030115
  e4 => 00000001  e8 => 00000001
[root@arago /]#

Any help to better understand how to debug the output is appreciated!

[1] http://arago-project.org/git/projects/?p=linux-omap3.git;a=commit;h=89ba11fc993b57bfc33d794621788b5158431a7c
[2] http://arago-project.org/git/projects/?p=u-boot-omap3.git;a=commit;h=7683ca6af43c17cf8214e9a241cd63c0001a59b1
[3] http://arago-project.org/git/projects/?p=x-load-omap3.git;a=commit;h=1d3578a5c6cd5967e067bac63670e88d11b6fe4d
> One of the common root causes for a problem like yours is a bootloader
> that leaves a particular module in a state that it cannot properly
> idle.  If the kernel is not using that particular device and/or has not
> reset that device, the result is the powerdomain for that device can not
> hit idle and you'll have a problem like yours.
>
> Kevin
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git


-- 
Peter Barada
peter.barada@gmail.com

