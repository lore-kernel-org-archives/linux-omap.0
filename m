From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3 1/7] ARM: OMAP4: Remove un-used control
 module headers and defines.
Date: Thu, 28 Jun 2012 12:46:47 +0300
Message-ID: <CAGF5oy9fwvpsgYZmcoRZy=F1yb0AwKpZwLexZ4Ed9y2cww0Q6g@mail.gmail.com>
References: <4FEB4B3F.1090608@dev.rtsoft.ru> <20120628044525.GB2471@besouro>
	<4FEC2306.1030105@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FEC2306.1030105@dev.rtsoft.ru>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, Jun 28, 2012 at 12:25 PM, Konstantin Baydarov
<kbaidarov@dev.rtsoft.ru> wrote:
> =A0Hi, Eduardo.
>
> On 06/28/2012 08:45 AM, Eduardo Valentin wrote:
>> Why the authorship of these patches is changing?
> Did I change Signed-off-by field? Could you clarify.

Signed offs are there. But the From field has switched from Santosh to
Konstantin. Do you use git am to apply patches from ml?

>>
>> For instance this patch, from Santosh, I believe it is the same...
>>
>> On Wed, Jun 27, 2012 at 10:04:47PM +0400, Konstantin Baydarov wrote:
>>> Most of the OMAP4 control module register defines are not used and
>>> can be removed. Keep only needed defines and move them to common
>>> control module header just like other OMAP versions.
>>>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>> ---
>>> =A0arch/arm/mach-omap2/control.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 45 +-
>>> =A0.../include/mach/ctrl_module_core_44xx.h =A0 =A0 =A0 =A0 =A0 | =A039=
1 ------
>>> =A0.../include/mach/ctrl_module_pad_core_44xx.h =A0 =A0 =A0 | 1409 ----=
----------------
>>> =A0.../include/mach/ctrl_module_pad_wkup_44xx.h =A0 =A0 =A0 | =A0236 --=
--
>>> =A0.../include/mach/ctrl_module_wkup_44xx.h =A0 =A0 =A0 =A0 =A0 | =A0 9=
2 --
>>> =A05 files changed, 40 insertions(+), 2133 deletions(-)
>>> =A0delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_core=
_44xx.h
>>> =A0delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_=
core_44xx.h
>>> =A0delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_pad_=
wkup_44xx.h
>>> =A0delete mode 100644 arch/arm/mach-omap2/include/mach/ctrl_module_wkup=
_44xx.h
>>>
>>> diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/contro=
l.h
>>> index a406fd0..dad2903 100644
>>> --- a/arch/arm/mach-omap2/control.h
>>> +++ b/arch/arm/mach-omap2/control.h
>>> @@ -16,11 +16,6 @@
>>> =A0#ifndef __ARCH_ARM_MACH_OMAP2_CONTROL_H
>>> =A0#define __ARCH_ARM_MACH_OMAP2_CONTROL_H
>>>
>>> -#include <mach/ctrl_module_core_44xx.h>
>>> -#include <mach/ctrl_module_wkup_44xx.h>
>>> -#include <mach/ctrl_module_pad_core_44xx.h>
>>> -#include <mach/ctrl_module_pad_wkup_44xx.h>
>>> -
>>> =A0#ifndef __ASSEMBLY__
>>> =A0#define OMAP242X_CTRL_REGADDR(reg) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE + (re=
g))
>>> @@ -183,6 +178,43 @@
>>> =A0#define OMAP3630_CONTROL_FUSE_OPP50_VDD2 =A0 =A0 =A0 =A0(OMAP2_CONTR=
OL_GENERAL + 0x0128)
>>> =A0#define OMAP3630_CONTROL_FUSE_OPP100_VDD2 =A0 =A0 =A0 (OMAP2_CONTROL=
_GENERAL + 0x012C)
>>>
>>> +/* OMAP4 IDCODE CONTROL */
>>> +#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1 =A0 =A0 =A0 =A0 =A0 =
0x0218
>>> +#define OMAP4_CTRL_MODULE_CORE_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02c4
>>> +
>>> +/* CONTROL_I2C_1 */
>>> +#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_1 =A0 =A0 =A0 =A0 =A0 =
=A00x0624
>>> +#define OMAP4_HDMI_DDC_SDA_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 28)
>>> +#define OMAP4_HDMI_DDC_SCL_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 24)
>>> +
>>> +/* DSI CONTROL_DSIPHY */
>>> +#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY =A0 =A0 =A0 =A0 =A0 =
0x0618
>>> +#define OMAP4_DSI2_LANEENABLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 29
>>> +#define OMAP4_DSI2_LANEENABLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 29)
>>> +#define OMAP4_DSI1_LANEENABLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 24
>>> +#define OMAP4_DSI1_LANEENABLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x1f << 24)
>>> +#define OMAP4_DSI1_PIPD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 19
>>> +#define OMAP4_DSI1_PIPD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1f << 19)
>>> +#define OMAP4_DSI2_PIPD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 14
>>> +#define OMAP4_DSI2_PIPD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1f << 14)
>>> +
>>> +/* CONTROL_PBIASLITE */
>>> +#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x0600
>>> +#define OMAP4_MMC1_PWRDNZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 26)
>>> +#define OMAP4_MMC1_PBIASLITE_VMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 21)
>>> +#define OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 22)
>>> +#define OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 23)
>>> +
>>> +/* CONTROL_MMC1 */
>>> +#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MMC1 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0x0628
>>> +#define OMAP4_SDMMC1_PUSTRENGTH_GRP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 31)
>>> +#define OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 30)
>>> +#define OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 29)
>>> +#define OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 28)
>>> +#define OMAP4_SDMMC1_DR0_SPEEDCTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 27)
>>> +#define OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 26)
>>> +#define OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 25)
>>> +
>>> =A0/* OMAP44xx control efuse offsets */
>>> =A0#define OMAP44XX_CONTROL_FUSE_IVA_OPP50 =A0 =A0 =A0 =A0 =A0 =A0 0x22=
C
>>> =A0#define OMAP44XX_CONTROL_FUSE_IVA_OPP100 =A0 =A00x22F
>>> @@ -195,6 +227,9 @@
>>> =A0#define OMAP44XX_CONTROL_FUSE_CORE_OPP50 =A0 =A00x254
>>> =A0#define OMAP44XX_CONTROL_FUSE_CORE_OPP100 =A0 0x257
>>>
>>> +/* OMAP44xx control McBSP padconf */
>>> +#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP =A00x061c
>>> +
>>> =A0/* AM35XX only CONTROL_GENERAL register offsets */
>>> =A0#define AM35XX_CONTROL_MSUSPENDMUX_6 =A0 =A0(OMAP2_CONTROL_GENERAL +=
 0x0038)
>>> =A0#define AM35XX_CONTROL_DEVCONF2 =A0 =A0 =A0 =A0 (OMAP2_CONTROL_GENER=
AL + 0x0310)
>>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h b=
/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
>>> deleted file mode 100644
>>> index 2f7ac70..0000000
>>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_core_44xx.h
>>> +++ /dev/null
>>> @@ -1,391 +0,0 @@
>>> -/*
>>> - * OMAP44xx CTRL_MODULE_CORE registers and bitfields
>>> - *
>>> - * Copyright (C) 2009-2010 Texas Instruments, Inc.
>>> - *
>>> - * Benoit Cousson (b-cousson@ti.com)
>>> - * Santosh Shilimkar (santosh.shilimkar@ti.com)
>>> - *
>>> - * This file is automatically generated from the OMAP hardware databas=
es.
>>> - * We respectfully ask that any modifications to this file be coordina=
ted
>>> - * with the public linux-omap@vger.kernel.org mailing list and the
>>> - * authors above to ensure that the autogeneration scripts are kept
>>> - * up-to-date with the file contents.
>>> - *
>>> - * This program is free software; you can redistribute it and/or modif=
y
>>> - * it under the terms of the GNU General Public License version 2 as
>>> - * published by the Free Software Foundation.
>>> - */
>>> -
>>> -#ifndef __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_CORE_44XX_H
>>> -#define __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_CORE_44XX_H
>>> -
>>> -
>>> -/* Base address */
>>> -#define OMAP4_CTRL_MODULE_CORE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4a002000
>>> -
>>> -/* Registers offset */
>>> -#define OMAP4_CTRL_MODULE_CORE_IP_REVISION =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x0000
>>> -#define OMAP4_CTRL_MODULE_CORE_IP_HWINFO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x0004
>>> -#define OMAP4_CTRL_MODULE_CORE_IP_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0x0010
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_DIE_ID_0 =A0 =A0 =A0 =A0 =A0 =
=A00x0200
>>> -#define OMAP4_CTRL_MODULE_CORE_ID_CODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0204
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_DIE_ID_1 =A0 =A0 =A0 =A0 =A0 =
=A00x0208
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_DIE_ID_2 =A0 =A0 =A0 =A0 =A0 =
=A00x020c
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_DIE_ID_3 =A0 =A0 =A0 =A0 =A0 =
=A00x0210
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_0 =A0 =A0 =A0 =A0 =A0 =
0x0214
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_PROD_ID_1 =A0 =A0 =A0 =A0 =A0 =
0x0218
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_USB_CONF =A0 =A0 =A0 =A0 =A0 =
=A00x021c
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_OPP_VDD_WKUP =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x0228
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_OPP_BGAP =A0 =A0 =A0 =A0 =A0 =
=A00x0260
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_OPP_DPLL_0 =A0 =A0 =A0 =A0 =A0=
0x0264
>>> -#define OMAP4_CTRL_MODULE_CORE_STD_FUSE_OPP_DPLL_1 =A0 =A0 =A0 =A0 =A0=
0x0268
>>> -#define OMAP4_CTRL_MODULE_CORE_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02c4
>>> -#define OMAP4_CTRL_MODULE_CORE_DEV_CONF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0300
>>> -#define OMAP4_CTRL_MODULE_CORE_LDOVBB_IVA_VOLTAGE_CTRL =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0314
>>> -#define OMAP4_CTRL_MODULE_CORE_LDOVBB_MPU_VOLTAGE_CTRL =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0318
>>> -#define OMAP4_CTRL_MODULE_CORE_LDOSRAM_IVA_VOLTAGE_CTRL =A0 =A0 =A0 =
=A0 =A0 =A0 0x0320
>>> -#define OMAP4_CTRL_MODULE_CORE_LDOSRAM_MPU_VOLTAGE_CTRL =A0 =A0 =A0 =
=A0 =A0 =A0 0x0324
>>> -#define OMAP4_CTRL_MODULE_CORE_LDOSRAM_CORE_VOLTAGE_CTRL =A0 =A00x0328
>>> -#define OMAP4_CTRL_MODULE_CORE_TEMP_SENSOR =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x032c
>>> -#define OMAP4_CTRL_MODULE_CORE_DPLL_NWELL_TRIM_0 =A0 =A0 =A0 =A0 =A0 =
=A00x0330
>>> -#define OMAP4_CTRL_MODULE_CORE_DPLL_NWELL_TRIM_1 =A0 =A0 =A0 =A0 =A0 =
=A00x0334
>>> -#define OMAP4_CTRL_MODULE_CORE_USBOTGHS_CONTROL =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0x033c
>>> -#define OMAP4_CTRL_MODULE_CORE_DSS_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00x0340
>>> -#define OMAP4_CTRL_MODULE_CORE_HWOBS_CONTROL =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A00x0350
>>> -#define OMAP4_CTRL_MODULE_CORE_DEBOBS_FINAL_MUX_SEL =A0 =A0 =A0 =A0 0x=
0400
>>> -#define OMAP4_CTRL_MODULE_CORE_DEBOBS_MMR_MPU =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0x0408
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_SDMA_REQ_SEL0 =A0 =A0 =A0 =A0 =A0 =
0x042c
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_SDMA_REQ_SEL1 =A0 =A0 =A0 =A0 =A0 =
0x0430
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_SDMA_REQ_SEL2 =A0 =A0 =A0 =A0 =A0 =
0x0434
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_SDMA_REQ_SEL3 =A0 =A0 =A0 =A0 =A0 =
0x0438
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_CLK_SEL0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A00x0440
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_CLK_SEL1 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A00x0444
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_CLK_SEL2 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A00x0448
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DPLL_FREQLOCK_SEL =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0x044c
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DPLL_TINITZ_SEL =A0 =A0 =A0 =A0 0x=
0450
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DPLL_PHASELOCK_SEL =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0454
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_0 =A0 =A0 =A0 =A0 0x=
0480
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_1 =A0 =A0 =A0 =A0 0x=
0484
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_2 =A0 =A0 =A0 =A0 0x=
0488
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_3 =A0 =A0 =A0 =A0 0x=
048c
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_4 =A0 =A0 =A0 =A0 0x=
0490
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_5 =A0 =A0 =A0 =A0 0x=
0494
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_6 =A0 =A0 =A0 =A0 0x=
0498
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_7 =A0 =A0 =A0 =A0 0x=
049c
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_8 =A0 =A0 =A0 =A0 0x=
04a0
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_9 =A0 =A0 =A0 =A0 0x=
04a4
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_10 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04a8
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_11 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04ac
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_12 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04b0
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_13 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04b4
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_14 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04b8
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_15 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04bc
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_16 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04c0
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_17 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04c4
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_18 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04c8
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_19 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04cc
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_20 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04d0
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_21 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04d4
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_22 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04d8
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_23 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04dc
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_24 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04e0
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_25 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04e4
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_26 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04e8
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_27 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04ec
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_28 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04f0
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_29 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04f4
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_30 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04f8
>>> -#define OMAP4_CTRL_MODULE_CORE_CONF_DEBUG_SEL_TST_31 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x04fc
>>> -
>>> -/* Registers shifts and masks */
>>> -
>>> -/* IP_REVISION */
>>> -#define OMAP4_IP_REV_SCHEME_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
30
>>> -#define OMAP4_IP_REV_SCHEME_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(0x3 << 30)
>>> -#define OMAP4_IP_REV_FUNC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_IP_REV_FUNC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0xfff << 16)
>>> -#define OMAP4_IP_REV_RTL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A011
>>> -#define OMAP4_IP_REV_RTL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x1f << 11)
>>> -#define OMAP4_IP_REV_MAJOR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A08
>>> -#define OMAP4_IP_REV_MAJOR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x7 << 8)
>>> -#define OMAP4_IP_REV_CUSTOM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
6
>>> -#define OMAP4_IP_REV_CUSTOM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(0x3 << 6)
>>> -#define OMAP4_IP_REV_MINOR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00
>>> -#define OMAP4_IP_REV_MINOR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x3f << 0)
>>> -
>>> -/* IP_HWINFO */
>>> -#define OMAP4_IP_HWINFO_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_IP_HWINFO_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* IP_SYSCONFIG */
>>> -#define OMAP4_IP_SYSCONFIG_IDLEMODE_SHIFT =A0 =A0 =A0 =A0 =A0 2
>>> -#define OMAP4_IP_SYSCONFIG_IDLEMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x3 <=
< 2)
>>> -
>>> -/* STD_FUSE_DIE_ID_0 */
>>> -#define OMAP4_STD_FUSE_DIE_ID_0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_DIE_ID_0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* ID_CODE */
>>> -#define OMAP4_STD_FUSE_IDCODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_IDCODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(0xffffffff << 0)
>>> -
>>> -/* STD_FUSE_DIE_ID_1 */
>>> -#define OMAP4_STD_FUSE_DIE_ID_1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_DIE_ID_1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* STD_FUSE_DIE_ID_2 */
>>> -#define OMAP4_STD_FUSE_DIE_ID_2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_DIE_ID_2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* STD_FUSE_DIE_ID_3 */
>>> -#define OMAP4_STD_FUSE_DIE_ID_3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_DIE_ID_3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* STD_FUSE_PROD_ID_0 */
>>> -#define OMAP4_STD_FUSE_PROD_ID_0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00
>>> -#define OMAP4_STD_FUSE_PROD_ID_0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0xffffffff << 0)
>>> -
>>> -/* STD_FUSE_PROD_ID_1 */
>>> -#define OMAP4_STD_FUSE_PROD_ID_1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00
>>> -#define OMAP4_STD_FUSE_PROD_ID_1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0xffffffff << 0)
>>> -
>>> -/* STD_FUSE_USB_CONF */
>>> -#define OMAP4_USB_PROD_ID_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_USB_PROD_ID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0xffff << 16)
>>> -#define OMAP4_USB_VENDOR_ID_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
0
>>> -#define OMAP4_USB_VENDOR_ID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(0xffff << 0)
>>> -
>>> -/* STD_FUSE_OPP_VDD_WKUP */
>>> -#define OMAP4_STD_FUSE_OPP_VDD_WKUP_SHIFT =A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_OPP_VDD_WKUP_MASK =A0 =A0 =A0 =A0 =A0 =A0(0xfff=
fffff << 0)
>>> -
>>> -/* STD_FUSE_OPP_BGAP */
>>> -#define OMAP4_STD_FUSE_OPP_BGAP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_OPP_BGAP_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* STD_FUSE_OPP_DPLL_0 */
>>> -#define OMAP4_STD_FUSE_OPP_DPLL_0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_OPP_DPLL_0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* STD_FUSE_OPP_DPLL_1 */
>>> -#define OMAP4_STD_FUSE_OPP_DPLL_1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_STD_FUSE_OPP_DPLL_1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* STATUS */
>>> -#define OMAP4_ATTILA_CONF_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 11
>>> -#define OMAP4_ATTILA_CONF_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x3 << 11)
>>> -#define OMAP4_DEVICE_TYPE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 8
>>> -#define OMAP4_DEVICE_TYPE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(0x7 << 8)
>>> -#define OMAP4_SYS_BOOT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_SYS_BOOT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0xff << 0)
>>> -
>>> -/* DEV_CONF */
>>> -#define OMAP4_DEV_CONF_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A01
>>> -#define OMAP4_DEV_CONF_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0x7fffffff << 1)
>>> -#define OMAP4_USBPHY_PD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_USBPHY_PD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>>> -
>>> -/* LDOVBB_IVA_VOLTAGE_CTRL */
>>> -#define OMAP4_LDOVBBIVA_RBB_MUX_CTRL_SHIFT =A0 =A0 =A0 =A0 =A026
>>> -#define OMAP4_LDOVBBIVA_RBB_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 (1 << 26=
)
>>> -#define OMAP4_LDOVBBIVA_RBB_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 21
>>> -#define OMAP4_LDOVBBIVA_RBB_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x1f =
<< 21)
>>> -#define OMAP4_LDOVBBIVA_RBB_VSET_OUT_SHIFT =A0 =A0 =A0 =A0 =A016
>>> -#define OMAP4_LDOVBBIVA_RBB_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 (0x1f <<=
 16)
>>> -#define OMAP4_LDOVBBIVA_FBB_MUX_CTRL_SHIFT =A0 =A0 =A0 =A0 =A010
>>> -#define OMAP4_LDOVBBIVA_FBB_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 (1 << 10=
)
>>> -#define OMAP4_LDOVBBIVA_FBB_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 5
>>> -#define OMAP4_LDOVBBIVA_FBB_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x1f =
<< 5)
>>> -#define OMAP4_LDOVBBIVA_FBB_VSET_OUT_SHIFT =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_LDOVBBIVA_FBB_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 (0x1f <<=
 0)
>>> -
>>> -/* LDOVBB_MPU_VOLTAGE_CTRL */
>>> -#define OMAP4_LDOVBBMPU_RBB_MUX_CTRL_SHIFT =A0 =A0 =A0 =A0 =A026
>>> -#define OMAP4_LDOVBBMPU_RBB_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 (1 << 26=
)
>>> -#define OMAP4_LDOVBBMPU_RBB_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 21
>>> -#define OMAP4_LDOVBBMPU_RBB_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x1f =
<< 21)
>>> -#define OMAP4_LDOVBBMPU_RBB_VSET_OUT_SHIFT =A0 =A0 =A0 =A0 =A016
>>> -#define OMAP4_LDOVBBMPU_RBB_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 (0x1f <<=
 16)
>>> -#define OMAP4_LDOVBBMPU_FBB_MUX_CTRL_SHIFT =A0 =A0 =A0 =A0 =A010
>>> -#define OMAP4_LDOVBBMPU_FBB_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 (1 << 10=
)
>>> -#define OMAP4_LDOVBBMPU_FBB_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 5
>>> -#define OMAP4_LDOVBBMPU_FBB_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x1f =
<< 5)
>>> -#define OMAP4_LDOVBBMPU_FBB_VSET_OUT_SHIFT =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_LDOVBBMPU_FBB_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 (0x1f <<=
 0)
>>> -
>>> -/* LDOSRAM_IVA_VOLTAGE_CTRL */
>>> -#define OMAP4_LDOSRAMIVA_RETMODE_MUX_CTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 26
>>> -#define OMAP4_LDOSRAMIVA_RETMODE_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 26)
>>> -#define OMAP4_LDOSRAMIVA_RETMODE_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A021
>>> -#define OMAP4_LDOSRAMIVA_RETMODE_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1f << 21)
>>> -#define OMAP4_LDOSRAMIVA_RETMODE_VSET_OUT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 16
>>> -#define OMAP4_LDOSRAMIVA_RETMODE_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x1f << 16)
>>> -#define OMAP4_LDOSRAMIVA_ACTMODE_MUX_CTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 10
>>> -#define OMAP4_LDOSRAMIVA_ACTMODE_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 10)
>>> -#define OMAP4_LDOSRAMIVA_ACTMODE_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A05
>>> -#define OMAP4_LDOSRAMIVA_ACTMODE_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1f << 5)
>>> -#define OMAP4_LDOSRAMIVA_ACTMODE_VSET_OUT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 0
>>> -#define OMAP4_LDOSRAMIVA_ACTMODE_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x1f << 0)
>>> -
>>> -/* LDOSRAM_MPU_VOLTAGE_CTRL */
>>> -#define OMAP4_LDOSRAMMPU_RETMODE_MUX_CTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 26
>>> -#define OMAP4_LDOSRAMMPU_RETMODE_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 26)
>>> -#define OMAP4_LDOSRAMMPU_RETMODE_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A021
>>> -#define OMAP4_LDOSRAMMPU_RETMODE_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1f << 21)
>>> -#define OMAP4_LDOSRAMMPU_RETMODE_VSET_OUT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 16
>>> -#define OMAP4_LDOSRAMMPU_RETMODE_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x1f << 16)
>>> -#define OMAP4_LDOSRAMMPU_ACTMODE_MUX_CTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 10
>>> -#define OMAP4_LDOSRAMMPU_ACTMODE_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1 << 10)
>>> -#define OMAP4_LDOSRAMMPU_ACTMODE_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A05
>>> -#define OMAP4_LDOSRAMMPU_ACTMODE_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1f << 5)
>>> -#define OMAP4_LDOSRAMMPU_ACTMODE_VSET_OUT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 0
>>> -#define OMAP4_LDOSRAMMPU_ACTMODE_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x1f << 0)
>>> -
>>> -/* LDOSRAM_CORE_VOLTAGE_CTRL */
>>> -#define OMAP4_LDOSRAMCORE_RETMODE_MUX_CTRL_SHIFT =A0 =A026
>>> -#define OMAP4_LDOSRAMCORE_RETMODE_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 26)
>>> -#define OMAP4_LDOSRAMCORE_RETMODE_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 21
>>> -#define OMAP4_LDOSRAMCORE_RETMODE_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x1f << 21)
>>> -#define OMAP4_LDOSRAMCORE_RETMODE_VSET_OUT_SHIFT =A0 =A016
>>> -#define OMAP4_LDOSRAMCORE_RETMODE_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1f << 16)
>>> -#define OMAP4_LDOSRAMCORE_ACTMODE_MUX_CTRL_SHIFT =A0 =A010
>>> -#define OMAP4_LDOSRAMCORE_ACTMODE_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 10)
>>> -#define OMAP4_LDOSRAMCORE_ACTMODE_VSET_IN_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 5
>>> -#define OMAP4_LDOSRAMCORE_ACTMODE_VSET_IN_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x1f << 5)
>>> -#define OMAP4_LDOSRAMCORE_ACTMODE_VSET_OUT_SHIFT =A0 =A00
>>> -#define OMAP4_LDOSRAMCORE_ACTMODE_VSET_OUT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1f << 0)
>>> -
>>> -/* TEMP_SENSOR */
>>> -#define OMAP4_BGAP_TEMPSOFF_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
12
>>> -#define OMAP4_BGAP_TEMPSOFF_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 12)
>>> -#define OMAP4_BGAP_TSHUT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A011
>>> -#define OMAP4_BGAP_TSHUT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 11)
>>> -#define OMAP4_BGAP_TEMP_SENSOR_CONTCONV_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 10
>>> -#define OMAP4_BGAP_TEMP_SENSOR_CONTCONV_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(1 << 10)
>>> -#define OMAP4_BGAP_TEMP_SENSOR_SOC_SHIFT =A0 =A0 =A0 =A0 =A0 =A09
>>> -#define OMAP4_BGAP_TEMP_SENSOR_SOC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 9)
>>> -#define OMAP4_BGAP_TEMP_SENSOR_EOCZ_SHIFT =A0 =A0 =A0 =A0 =A0 8
>>> -#define OMAP4_BGAP_TEMP_SENSOR_EOCZ_MASK =A0 =A0 =A0 =A0 =A0 =A0(1 << =
8)
>>> -#define OMAP4_BGAP_TEMP_SENSOR_DTEMP_SHIFT =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_BGAP_TEMP_SENSOR_DTEMP_MASK =A0 =A0 =A0 =A0 =A0 (0xff <<=
 0)
>>> -
>>> -/* DPLL_NWELL_TRIM_0 */
>>> -#define OMAP4_DPLL_ABE_NWELL_TRIM_MUX_CTRL_SHIFT =A0 =A029
>>> -#define OMAP4_DPLL_ABE_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 29)
>>> -#define OMAP4_DPLL_ABE_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 24
>>> -#define OMAP4_DPLL_ABE_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x1f << 24)
>>> -#define OMAP4_DPLL_PER_NWELL_TRIM_MUX_CTRL_SHIFT =A0 =A023
>>> -#define OMAP4_DPLL_PER_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 23)
>>> -#define OMAP4_DPLL_PER_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 18
>>> -#define OMAP4_DPLL_PER_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x1f << 18)
>>> -#define OMAP4_DPLL_CORE_NWELL_TRIM_MUX_CTRL_SHIFT =A0 17
>>> -#define OMAP4_DPLL_CORE_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0(1 << 17)
>>> -#define OMAP4_DPLL_CORE_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A012
>>> -#define OMAP4_DPLL_CORE_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x1f << 12)
>>> -#define OMAP4_DPLL_IVA_NWELL_TRIM_MUX_CTRL_SHIFT =A0 =A011
>>> -#define OMAP4_DPLL_IVA_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 11)
>>> -#define OMAP4_DPLL_IVA_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 6
>>> -#define OMAP4_DPLL_IVA_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x1f << 6)
>>> -#define OMAP4_DPLL_MPU_NWELL_TRIM_MUX_CTRL_SHIFT =A0 =A05
>>> -#define OMAP4_DPLL_MPU_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 5)
>>> -#define OMAP4_DPLL_MPU_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_DPLL_MPU_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x1f << 0)
>>> -
>>> -/* DPLL_NWELL_TRIM_1 */
>>> -#define OMAP4_DPLL_UNIPRO_NWELL_TRIM_MUX_CTRL_SHIFT 29
>>> -#define OMAP4_DPLL_UNIPRO_NWELL_TRIM_MUX_CTRL_MASK =A0(1 << 29)
>>> -#define OMAP4_DPLL_UNIPRO_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A024
>>> -#define OMAP4_DPLL_UNIPRO_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 (0x1f <<=
 24)
>>> -#define OMAP4_DPLL_USB_NWELL_TRIM_MUX_CTRL_SHIFT =A0 =A023
>>> -#define OMAP4_DPLL_USB_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (1 << 23)
>>> -#define OMAP4_DPLL_USB_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 18
>>> -#define OMAP4_DPLL_USB_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(0x1f << 18)
>>> -#define OMAP4_DPLL_HDMI_NWELL_TRIM_MUX_CTRL_SHIFT =A0 17
>>> -#define OMAP4_DPLL_HDMI_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0(1 << 17)
>>> -#define OMAP4_DPLL_HDMI_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A012
>>> -#define OMAP4_DPLL_HDMI_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x1f << 12)
>>> -#define OMAP4_DPLL_DSI2_NWELL_TRIM_MUX_CTRL_SHIFT =A0 11
>>> -#define OMAP4_DPLL_DSI2_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0(1 << 11)
>>> -#define OMAP4_DPLL_DSI2_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_DPLL_DSI2_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x1f << 6)
>>> -#define OMAP4_DPLL_DSI1_NWELL_TRIM_MUX_CTRL_SHIFT =A0 5
>>> -#define OMAP4_DPLL_DSI1_NWELL_TRIM_MUX_CTRL_MASK =A0 =A0(1 << 5)
>>> -#define OMAP4_DPLL_DSI1_NWELL_TRIM_SHIFT =A0 =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_DPLL_DSI1_NWELL_TRIM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x1f << 0)
>>> -
>>> -/* USBOTGHS_CONTROL */
>>> -#define OMAP4_DISCHRGVBUS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 8
>>> -#define OMAP4_DISCHRGVBUS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(1 << 8)
>>> -#define OMAP4_CHRGVBUS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A07
>>> -#define OMAP4_CHRGVBUS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 7)
>>> -#define OMAP4_DRVVBUS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 6
>>> -#define OMAP4_DRVVBUS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 6)
>>> -#define OMAP4_IDPULLUP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A05
>>> -#define OMAP4_IDPULLUP_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 5)
>>> -#define OMAP4_IDDIG_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 4
>>> -#define OMAP4_IDDIG_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 4)
>>> -#define OMAP4_SESSEND_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 3
>>> -#define OMAP4_SESSEND_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 3)
>>> -#define OMAP4_VBUSVALID_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 2
>>> -#define OMAP4_VBUSVALID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
>>> -#define OMAP4_BVALID_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A01
>>> -#define OMAP4_BVALID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 1)
>>> -#define OMAP4_AVALID_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00
>>> -#define OMAP4_AVALID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 0)
>>> -
>>> -/* DSS_CONTROL */
>>> -#define OMAP4_DSS_MUX6_SELECT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_DSS_MUX6_SELECT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(1 << 0)
>>> -
>>> -/* HWOBS_CONTROL */
>>> -#define OMAP4_HWOBS_CLKDIV_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A03
>>> -#define OMAP4_HWOBS_CLKDIV_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0=
x1f << 3)
>>> -#define OMAP4_HWOBS_ALL_ZERO_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 2
>>> -#define OMAP4_HWOBS_ALL_ZERO_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 2)
>>> -#define OMAP4_HWOBS_ALL_ONE_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A01
>>> -#define OMAP4_HWOBS_ALL_ONE_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 1)
>>> -#define OMAP4_HWOBS_MACRO_ENABLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00
>>> -#define OMAP4_HWOBS_MACRO_ENABLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 0)
>>> -
>>> -/* DEBOBS_FINAL_MUX_SEL */
>>> -#define OMAP4_SELECT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A00
>>> -#define OMAP4_SELECT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0xffffffff << 0)
>>> -
>>> -/* DEBOBS_MMR_MPU */
>>> -#define OMAP4_SELECT_DEBOBS_MMR_MPU_SHIFT =A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_SELECT_DEBOBS_MMR_MPU_MASK =A0 =A0 =A0 =A0 =A0 =A0(0xf <=
< 0)
>>> -
>>> -/* CONF_SDMA_REQ_SEL0 */
>>> -#define OMAP4_MULT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00
>>> -#define OMAP4_MULT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x7f << 0)
>>> -
>>> -/* CONF_CLK_SEL0 */
>>> -#define OMAP4_MULT_CONF_CLK_SEL0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00
>>> -#define OMAP4_MULT_CONF_CLK_SEL0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x7 << 0)
>>> -
>>> -/* CONF_CLK_SEL1 */
>>> -#define OMAP4_MULT_CONF_CLK_SEL1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00
>>> -#define OMAP4_MULT_CONF_CLK_SEL1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x7 << 0)
>>> -
>>> -/* CONF_CLK_SEL2 */
>>> -#define OMAP4_MULT_CONF_CLK_SEL2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00
>>> -#define OMAP4_MULT_CONF_CLK_SEL2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (0x7 << 0)
>>> -
>>> -/* CONF_DPLL_FREQLOCK_SEL */
>>> -#define OMAP4_MULT_CONF_DPLL_FREQLOCK_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 0
>>> -#define OMAP4_MULT_CONF_DPLL_FREQLOCK_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x7 << 0)
>>> -
>>> -/* CONF_DPLL_TINITZ_SEL */
>>> -#define OMAP4_MULT_CONF_DPLL_TINITZ_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0
>>> -#define OMAP4_MULT_CONF_DPLL_TINITZ_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(0x7 << 0)
>>> -
>>> -/* CONF_DPLL_PHASELOCK_SEL */
>>> -#define OMAP4_MULT_CONF_DPLL_PHASELOCK_SEL_SHIFT =A0 =A00
>>> -#define OMAP4_MULT_CONF_DPLL_PHASELOCK_SEL_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 (0x7 << 0)
>>> -
>>> -/* CONF_DEBUG_SEL_TST_0 */
>>> -#define OMAP4_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00
>>> -#define OMAP4_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xf << 0)
>>> -
>>> -#endif
>>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx=
.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
>>> deleted file mode 100644
>>> index c88420d..0000000
>>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
>>> +++ /dev/null
>>> @@ -1,1409 +0,0 @@
>>> -/*
>>> - * OMAP44xx CTRL_MODULE_PAD_CORE registers and bitfields
>>> - *
>>> - * Copyright (C) 2009-2010 Texas Instruments, Inc.
>>> - *
>>> - * Benoit Cousson (b-cousson@ti.com)
>>> - * Santosh Shilimkar (santosh.shilimkar@ti.com)
>>> - *
>>> - * This file is automatically generated from the OMAP hardware databas=
es.
>>> - * We respectfully ask that any modifications to this file be coordina=
ted
>>> - * with the public linux-omap@vger.kernel.org mailing list and the
>>> - * authors above to ensure that the autogeneration scripts are kept
>>> - * up-to-date with the file contents.
>>> - *
>>> - * This program is free software; you can redistribute it and/or modif=
y
>>> - * it under the terms of the GNU General Public License version 2 as
>>> - * published by the Free Software Foundation.
>>> - */
>>> -
>>> -#ifndef __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_PAD_CORE_44XX_H
>>> -#define __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_PAD_CORE_44XX_H
>>> -
>>> -
>>> -/* Base address */
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A00x4a100000
>>> -
>>> -/* Registers offset */
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_IP_REVISION =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x0000
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_IP_HWINFO =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A00x0004
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_IP_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0x0010
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_PADCONF_WAKEUPEVENT_0 =A0 =A00x01d8
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_PADCONF_WAKEUPEVENT_1 =A0 =A00x01dc
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_PADCONF_WAKEUPEVENT_2 =A0 =A00x01e0
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_PADCONF_WAKEUPEVENT_3 =A0 =A00x01e4
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_PADCONF_WAKEUPEVENT_4 =A0 =A00x01e8
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_PADCONF_WAKEUPEVENT_5 =A0 =A00x01ec
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_PADCONF_WAKEUPEVENT_6 =A0 =A00x01f0
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PADCONF_GLOBAL =A0 0x05a0
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PADCONF_MODE =A0 =A0 =A0 =
=A0 =A0 =A0 0x05a4
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART1IO_PADCONF_0 =A0 =A0 =
=A0 0x05a8
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART1IO_PADCONF_1 =A0 =A0 =
=A0 0x05ac
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART2IO_PADCONF_0 =A0 =A0 =
=A0 0x05b0
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART2IO_PADCONF_1 =A0 =A0 =
=A0 0x05b4
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART3IO_PADCONF_0 =A0 =A0 =
=A0 0x05b8
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART3IO_PADCONF_1 =A0 =A0 =
=A0 0x05bc
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART3IO_PADCONF_2 =A0 =A0 =
=A0 0x05c0
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_USBB_HSIC =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x05c4
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SLIMBUS =A0 =A0 =A0 =A0 =A0=
0x05c8
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x0600
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_0 =A0 =A0 =A0 =A0 =A0 =
=A00x0604
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_CAMERA_RX =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A00x0608
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_AVDAC =A0 =A0 =A0 =A0 =A0 =
=A00x060c
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_HDMI_TX_PHY =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0610
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MMC2 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0x0614
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY =A0 =A0 =A0 =A0 =A0 =
0x0618
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MCBSPLP =A0 =A0 =A0 =A0 =A0=
0x061c
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_USB2PHYCORE =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0620
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_1 =A0 =A0 =A0 =A0 =A0 =
=A00x0624
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MMC1 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0x0628
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_HSI =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x062c
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_USB =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x0630
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_HDQ =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x0634
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_LPDDR2IO1_0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0638
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_LPDDR2IO1_1 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x063c
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_LPDDR2IO1_2 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0640
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_LPDDR2IO1_3 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0644
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_LPDDR2IO2_0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0648
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_LPDDR2IO2_1 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x064c
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_LPDDR2IO2_2 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0650
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_LPDDR2IO2_3 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0654
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_BUS_HOLD =A0 =A0 =A0 =A0 0x=
0658
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_C2C =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x065c
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CORE_CONTROL_SPARE_RW =A0 =A00x0660
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CORE_CONTROL_SPARE_R =A0 =A0 =A0 =
=A0 =A0 =A0 0x0664
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CORE_CONTROL_SPARE_R_C0 =A00x0668
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_EFUSE_1 =A0 =A0 =A0 =A0 =A0=
0x0700
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_EFUSE_2 =A0 =A0 =A0 =A0 =A0=
0x0704
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_EFUSE_3 =A0 =A0 =A0 =A0 =A0=
0x0708
>>> -#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_EFUSE_4 =A0 =A0 =A0 =A0 =A0=
0x070c
>>> -
>>> -/* Registers shifts and masks */
>>> -
>>> -/* IP_REVISION */
>>> -#define OMAP4_IP_REV_SCHEME_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 30
>>> -#define OMAP4_IP_REV_SCHEME_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_IP_REV_FUNC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_IP_REV_FUNC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xfff << 16)
>>> -#define OMAP4_IP_REV_RTL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A011
>>> -#define OMAP4_IP_REV_RTL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1f << 11)
>>> -#define OMAP4_IP_REV_MAJOR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_IP_REV_MAJOR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x7 << 8)
>>> -#define OMAP4_IP_REV_CUSTOM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 6
>>> -#define OMAP4_IP_REV_CUSTOM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 6)
>>> -#define OMAP4_IP_REV_MINOR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_IP_REV_MINOR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3f << 0)
>>> -
>>> -/* IP_HWINFO */
>>> -#define OMAP4_IP_HWINFO_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_IP_HWINFO_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* IP_SYSCONFIG */
>>> -#define OMAP4_IP_SYSCONFIG_IDLEMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 2
>>> -#define OMAP4_IP_SYSCONFIG_IDLEMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(0x3 << 2)
>>> -
>>> -/* PADCONF_WAKEUPEVENT_0 */
>>> -#define OMAP4_GPMC_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
31
>>> -#define OMAP4_GPMC_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 31)
>>> -#define OMAP4_GPMC_NWP_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
30
>>> -#define OMAP4_GPMC_NWP_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 30)
>>> -#define OMAP4_GPMC_NCS3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
29
>>> -#define OMAP4_GPMC_NCS3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 29)
>>> -#define OMAP4_GPMC_NCS2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
28
>>> -#define OMAP4_GPMC_NCS2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 28)
>>> -#define OMAP4_GPMC_NCS1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
27
>>> -#define OMAP4_GPMC_NCS1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 27)
>>> -#define OMAP4_GPMC_NCS0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
26
>>> -#define OMAP4_GPMC_NCS0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 26)
>>> -#define OMAP4_GPMC_A25_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
25
>>> -#define OMAP4_GPMC_A25_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 25)
>>> -#define OMAP4_GPMC_A24_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
24
>>> -#define OMAP4_GPMC_A24_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 24)
>>> -#define OMAP4_GPMC_A23_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
23
>>> -#define OMAP4_GPMC_A23_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 23)
>>> -#define OMAP4_GPMC_A22_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
22
>>> -#define OMAP4_GPMC_A22_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 22)
>>> -#define OMAP4_GPMC_A21_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
21
>>> -#define OMAP4_GPMC_A21_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 21)
>>> -#define OMAP4_GPMC_A20_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
20
>>> -#define OMAP4_GPMC_A20_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 20)
>>> -#define OMAP4_GPMC_A19_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
19
>>> -#define OMAP4_GPMC_A19_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 19)
>>> -#define OMAP4_GPMC_A18_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
18
>>> -#define OMAP4_GPMC_A18_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 18)
>>> -#define OMAP4_GPMC_A17_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
17
>>> -#define OMAP4_GPMC_A17_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 17)
>>> -#define OMAP4_GPMC_A16_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
16
>>> -#define OMAP4_GPMC_A16_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 16)
>>> -#define OMAP4_GPMC_AD15_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
15
>>> -#define OMAP4_GPMC_AD15_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 15)
>>> -#define OMAP4_GPMC_AD14_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
14
>>> -#define OMAP4_GPMC_AD14_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 14)
>>> -#define OMAP4_GPMC_AD13_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
13
>>> -#define OMAP4_GPMC_AD13_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 13)
>>> -#define OMAP4_GPMC_AD12_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
12
>>> -#define OMAP4_GPMC_AD12_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 12)
>>> -#define OMAP4_GPMC_AD11_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
11
>>> -#define OMAP4_GPMC_AD11_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 11)
>>> -#define OMAP4_GPMC_AD10_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
10
>>> -#define OMAP4_GPMC_AD10_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 10)
>>> -#define OMAP4_GPMC_AD9_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
9
>>> -#define OMAP4_GPMC_AD9_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 9)
>>> -#define OMAP4_GPMC_AD8_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
8
>>> -#define OMAP4_GPMC_AD8_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 8)
>>> -#define OMAP4_GPMC_AD7_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
7
>>> -#define OMAP4_GPMC_AD7_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 7)
>>> -#define OMAP4_GPMC_AD6_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
6
>>> -#define OMAP4_GPMC_AD6_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 6)
>>> -#define OMAP4_GPMC_AD5_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
5
>>> -#define OMAP4_GPMC_AD5_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 5)
>>> -#define OMAP4_GPMC_AD4_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
4
>>> -#define OMAP4_GPMC_AD4_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 4)
>>> -#define OMAP4_GPMC_AD3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
3
>>> -#define OMAP4_GPMC_AD3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 3)
>>> -#define OMAP4_GPMC_AD2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
2
>>> -#define OMAP4_GPMC_AD2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 2)
>>> -#define OMAP4_GPMC_AD1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
1
>>> -#define OMAP4_GPMC_AD1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 1)
>>> -#define OMAP4_GPMC_AD0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
0
>>> -#define OMAP4_GPMC_AD0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 0)
>>> -
>>> -/* PADCONF_WAKEUPEVENT_1 */
>>> -#define OMAP4_CAM_STROBE_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 31
>>> -#define OMAP4_CAM_STROBE_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 31)
>>> -#define OMAP4_CAM_SHUTTER_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A030
>>> -#define OMAP4_CAM_SHUTTER_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 30)
>>> -#define OMAP4_CSI22_DY1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
29
>>> -#define OMAP4_CSI22_DY1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 29)
>>> -#define OMAP4_CSI22_DX1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
28
>>> -#define OMAP4_CSI22_DX1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 28)
>>> -#define OMAP4_CSI22_DY0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
27
>>> -#define OMAP4_CSI22_DY0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 27)
>>> -#define OMAP4_CSI22_DX0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
26
>>> -#define OMAP4_CSI22_DX0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 26)
>>> -#define OMAP4_CSI21_DY4_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
25
>>> -#define OMAP4_CSI21_DY4_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 25)
>>> -#define OMAP4_CSI21_DX4_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
24
>>> -#define OMAP4_CSI21_DX4_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 24)
>>> -#define OMAP4_CSI21_DY3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
23
>>> -#define OMAP4_CSI21_DY3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 23)
>>> -#define OMAP4_CSI21_DX3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
22
>>> -#define OMAP4_CSI21_DX3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 22)
>>> -#define OMAP4_CSI21_DY2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
21
>>> -#define OMAP4_CSI21_DY2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 21)
>>> -#define OMAP4_CSI21_DX2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
20
>>> -#define OMAP4_CSI21_DX2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 20)
>>> -#define OMAP4_CSI21_DY1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
19
>>> -#define OMAP4_CSI21_DY1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 19)
>>> -#define OMAP4_CSI21_DX1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
18
>>> -#define OMAP4_CSI21_DX1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 18)
>>> -#define OMAP4_CSI21_DY0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
17
>>> -#define OMAP4_CSI21_DY0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 17)
>>> -#define OMAP4_CSI21_DX0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
16
>>> -#define OMAP4_CSI21_DX0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 16)
>>> -#define OMAP4_HDMI_DDC_SDA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 15
>>> -#define OMAP4_HDMI_DDC_SDA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 15)
>>> -#define OMAP4_HDMI_DDC_SCL_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 14
>>> -#define OMAP4_HDMI_DDC_SCL_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 14)
>>> -#define OMAP4_HDMI_CEC_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
13
>>> -#define OMAP4_HDMI_CEC_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 13)
>>> -#define OMAP4_HDMI_HPD_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
12
>>> -#define OMAP4_HDMI_HPD_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 12)
>>> -#define OMAP4_C2C_DATA15_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 11
>>> -#define OMAP4_C2C_DATA15_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 11)
>>> -#define OMAP4_C2C_DATA14_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 10
>>> -#define OMAP4_C2C_DATA14_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 10)
>>> -#define OMAP4_C2C_DATA13_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 9
>>> -#define OMAP4_C2C_DATA13_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 9)
>>> -#define OMAP4_C2C_DATA12_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 8
>>> -#define OMAP4_C2C_DATA12_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 8)
>>> -#define OMAP4_C2C_DATA11_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 7
>>> -#define OMAP4_C2C_DATA11_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 7)
>>> -#define OMAP4_GPMC_WAIT1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 6
>>> -#define OMAP4_GPMC_WAIT1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 6)
>>> -#define OMAP4_GPMC_WAIT0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 5
>>> -#define OMAP4_GPMC_WAIT0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 5)
>>> -#define OMAP4_GPMC_NBE1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
4
>>> -#define OMAP4_GPMC_NBE1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 4)
>>> -#define OMAP4_GPMC_NBE0_CLE_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A03
>>> -#define OMAP4_GPMC_NBE0_CLE_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 3)
>>> -#define OMAP4_GPMC_NWE_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
2
>>> -#define OMAP4_GPMC_NWE_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 2)
>>> -#define OMAP4_GPMC_NOE_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
1
>>> -#define OMAP4_GPMC_NOE_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 1)
>>> -#define OMAP4_GPMC_NADV_ALE_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A00
>>> -#define OMAP4_GPMC_NADV_ALE_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 0)
>>> -
>>> -/* PADCONF_WAKEUPEVENT_2 */
>>> -#define OMAP4_ABE_MCBSP1_CLKX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A031
>>> -#define OMAP4_ABE_MCBSP1_CLKX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_ABE_MCBSP2_FSX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 30
>>> -#define OMAP4_ABE_MCBSP2_FSX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_ABE_MCBSP2_DX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A029
>>> -#define OMAP4_ABE_MCBSP2_DX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 29)
>>> -#define OMAP4_ABE_MCBSP2_DR_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A028
>>> -#define OMAP4_ABE_MCBSP2_DR_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 28)
>>> -#define OMAP4_ABE_MCBSP2_CLKX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A027
>>> -#define OMAP4_ABE_MCBSP2_CLKX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 27)
>>> -#define OMAP4_SDMMC1_DAT7_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A026
>>> -#define OMAP4_SDMMC1_DAT7_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 26)
>>> -#define OMAP4_SDMMC1_DAT6_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A025
>>> -#define OMAP4_SDMMC1_DAT6_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 25)
>>> -#define OMAP4_SDMMC1_DAT5_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A024
>>> -#define OMAP4_SDMMC1_DAT5_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 24)
>>> -#define OMAP4_SDMMC1_DAT4_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A023
>>> -#define OMAP4_SDMMC1_DAT4_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 23)
>>> -#define OMAP4_SDMMC1_DAT3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A022
>>> -#define OMAP4_SDMMC1_DAT3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 22)
>>> -#define OMAP4_SDMMC1_DAT2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A021
>>> -#define OMAP4_SDMMC1_DAT2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 21)
>>> -#define OMAP4_SDMMC1_DAT1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A020
>>> -#define OMAP4_SDMMC1_DAT1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 20)
>>> -#define OMAP4_SDMMC1_DAT0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A019
>>> -#define OMAP4_SDMMC1_DAT0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 19)
>>> -#define OMAP4_SDMMC1_CMD_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 18
>>> -#define OMAP4_SDMMC1_CMD_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 18)
>>> -#define OMAP4_SDMMC1_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 17
>>> -#define OMAP4_SDMMC1_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 17)
>>> -#define OMAP4_USBC1_ICUSB_DM_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 16
>>> -#define OMAP4_USBC1_ICUSB_DM_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 16)
>>> -#define OMAP4_USBC1_ICUSB_DP_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 15
>>> -#define OMAP4_USBC1_ICUSB_DP_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 15)
>>> -#define OMAP4_USBB1_HSIC_STROBE_DUPLICATEWAKEUPEVENT_SHIFT =A014
>>> -#define OMAP4_USBB1_HSIC_STROBE_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 14=
)
>>> -#define OMAP4_USBB1_HSIC_DATA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A013
>>> -#define OMAP4_USBB1_HSIC_DATA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 13)
>>> -#define OMAP4_USBB1_ULPITLL_DAT7_DUPLICATEWAKEUPEVENT_SHIFT 12
>>> -#define OMAP4_USBB1_ULPITLL_DAT7_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 12=
)
>>> -#define OMAP4_USBB1_ULPITLL_DAT6_DUPLICATEWAKEUPEVENT_SHIFT 11
>>> -#define OMAP4_USBB1_ULPITLL_DAT6_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 11=
)
>>> -#define OMAP4_USBB1_ULPITLL_DAT5_DUPLICATEWAKEUPEVENT_SHIFT 10
>>> -#define OMAP4_USBB1_ULPITLL_DAT5_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 10=
)
>>> -#define OMAP4_USBB1_ULPITLL_DAT4_DUPLICATEWAKEUPEVENT_SHIFT 9
>>> -#define OMAP4_USBB1_ULPITLL_DAT4_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 9)
>>> -#define OMAP4_USBB1_ULPITLL_DAT3_DUPLICATEWAKEUPEVENT_SHIFT 8
>>> -#define OMAP4_USBB1_ULPITLL_DAT3_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 8)
>>> -#define OMAP4_USBB1_ULPITLL_DAT2_DUPLICATEWAKEUPEVENT_SHIFT 7
>>> -#define OMAP4_USBB1_ULPITLL_DAT2_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 7)
>>> -#define OMAP4_USBB1_ULPITLL_DAT1_DUPLICATEWAKEUPEVENT_SHIFT 6
>>> -#define OMAP4_USBB1_ULPITLL_DAT1_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 6)
>>> -#define OMAP4_USBB1_ULPITLL_DAT0_DUPLICATEWAKEUPEVENT_SHIFT 5
>>> -#define OMAP4_USBB1_ULPITLL_DAT0_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 5)
>>> -#define OMAP4_USBB1_ULPITLL_NXT_DUPLICATEWAKEUPEVENT_SHIFT =A04
>>> -#define OMAP4_USBB1_ULPITLL_NXT_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 4)
>>> -#define OMAP4_USBB1_ULPITLL_DIR_DUPLICATEWAKEUPEVENT_SHIFT =A03
>>> -#define OMAP4_USBB1_ULPITLL_DIR_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 3)
>>> -#define OMAP4_USBB1_ULPITLL_STP_DUPLICATEWAKEUPEVENT_SHIFT =A02
>>> -#define OMAP4_USBB1_ULPITLL_STP_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 2)
>>> -#define OMAP4_USBB1_ULPITLL_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A01
>>> -#define OMAP4_USBB1_ULPITLL_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 1)
>>> -#define OMAP4_CAM_GLOBALRESET_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A00
>>> -#define OMAP4_CAM_GLOBALRESET_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 0)
>>> -
>>> -/* PADCONF_WAKEUPEVENT_3 */
>>> -#define OMAP4_MCSPI1_CS3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 31
>>> -#define OMAP4_MCSPI1_CS3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 31)
>>> -#define OMAP4_MCSPI1_CS2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_MCSPI1_CS2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 30)
>>> -#define OMAP4_MCSPI1_CS1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 29
>>> -#define OMAP4_MCSPI1_CS1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 29)
>>> -#define OMAP4_MCSPI1_CS0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_MCSPI1_CS0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 28)
>>> -#define OMAP4_MCSPI1_SIMO_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A027
>>> -#define OMAP4_MCSPI1_SIMO_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 27)
>>> -#define OMAP4_MCSPI1_SOMI_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A026
>>> -#define OMAP4_MCSPI1_SOMI_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 26)
>>> -#define OMAP4_MCSPI1_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 25
>>> -#define OMAP4_MCSPI1_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 25)
>>> -#define OMAP4_I2C4_SDA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
24
>>> -#define OMAP4_I2C4_SDA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 24)
>>> -#define OMAP4_I2C4_SCL_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
23
>>> -#define OMAP4_I2C4_SCL_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 23)
>>> -#define OMAP4_I2C3_SDA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
22
>>> -#define OMAP4_I2C3_SDA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 22)
>>> -#define OMAP4_I2C3_SCL_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
21
>>> -#define OMAP4_I2C3_SCL_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 21)
>>> -#define OMAP4_I2C2_SDA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
20
>>> -#define OMAP4_I2C2_SDA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 20)
>>> -#define OMAP4_I2C2_SCL_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
19
>>> -#define OMAP4_I2C2_SCL_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 19)
>>> -#define OMAP4_I2C1_SDA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
18
>>> -#define OMAP4_I2C1_SDA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 18)
>>> -#define OMAP4_I2C1_SCL_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
17
>>> -#define OMAP4_I2C1_SCL_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 17)
>>> -#define OMAP4_HDQ_SIO_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A016
>>> -#define OMAP4_HDQ_SIO_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 16)
>>> -#define OMAP4_UART2_TX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
15
>>> -#define OMAP4_UART2_TX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 15)
>>> -#define OMAP4_UART2_RX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
14
>>> -#define OMAP4_UART2_RX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 14)
>>> -#define OMAP4_UART2_RTS_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
13
>>> -#define OMAP4_UART2_RTS_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 13)
>>> -#define OMAP4_UART2_CTS_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
12
>>> -#define OMAP4_UART2_CTS_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 12)
>>> -#define OMAP4_ABE_DMIC_DIN3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A011
>>> -#define OMAP4_ABE_DMIC_DIN3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 11)
>>> -#define OMAP4_ABE_DMIC_DIN2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A010
>>> -#define OMAP4_ABE_DMIC_DIN2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 10)
>>> -#define OMAP4_ABE_DMIC_DIN1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A09
>>> -#define OMAP4_ABE_DMIC_DIN1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 9)
>>> -#define OMAP4_ABE_DMIC_CLK1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A08
>>> -#define OMAP4_ABE_DMIC_CLK1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 8)
>>> -#define OMAP4_ABE_CLKS_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
7
>>> -#define OMAP4_ABE_CLKS_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 7)
>>> -#define OMAP4_ABE_PDM_LB_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 6
>>> -#define OMAP4_ABE_PDM_LB_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 6)
>>> -#define OMAP4_ABE_PDM_FRAME_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A05
>>> -#define OMAP4_ABE_PDM_FRAME_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 5)
>>> -#define OMAP4_ABE_PDM_DL_DATA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A04
>>> -#define OMAP4_ABE_PDM_DL_DATA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 4)
>>> -#define OMAP4_ABE_PDM_UL_DATA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A03
>>> -#define OMAP4_ABE_PDM_UL_DATA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 3)
>>> -#define OMAP4_ABE_MCBSP1_FSX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 2
>>> -#define OMAP4_ABE_MCBSP1_FSX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 2)
>>> -#define OMAP4_ABE_MCBSP1_DX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A01
>>> -#define OMAP4_ABE_MCBSP1_DX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 1)
>>> -#define OMAP4_ABE_MCBSP1_DR_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A00
>>> -#define OMAP4_ABE_MCBSP1_DR_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 0)
>>> -
>>> -/* PADCONF_WAKEUPEVENT_4 */
>>> -#define OMAP4_UNIPRO_TY0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 31
>>> -#define OMAP4_UNIPRO_TY0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 31)
>>> -#define OMAP4_UNIPRO_TX0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_UNIPRO_TX0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 30)
>>> -#define OMAP4_USBB2_HSIC_STROBE_DUPLICATEWAKEUPEVENT_SHIFT =A029
>>> -#define OMAP4_USBB2_HSIC_STROBE_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 29=
)
>>> -#define OMAP4_USBB2_HSIC_DATA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A028
>>> -#define OMAP4_USBB2_HSIC_DATA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 28)
>>> -#define OMAP4_USBB2_ULPITLL_DAT7_DUPLICATEWAKEUPEVENT_SHIFT 27
>>> -#define OMAP4_USBB2_ULPITLL_DAT7_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 27=
)
>>> -#define OMAP4_USBB2_ULPITLL_DAT6_DUPLICATEWAKEUPEVENT_SHIFT 26
>>> -#define OMAP4_USBB2_ULPITLL_DAT6_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 26=
)
>>> -#define OMAP4_USBB2_ULPITLL_DAT5_DUPLICATEWAKEUPEVENT_SHIFT 25
>>> -#define OMAP4_USBB2_ULPITLL_DAT5_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 25=
)
>>> -#define OMAP4_USBB2_ULPITLL_DAT4_DUPLICATEWAKEUPEVENT_SHIFT 24
>>> -#define OMAP4_USBB2_ULPITLL_DAT4_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 24=
)
>>> -#define OMAP4_USBB2_ULPITLL_DAT3_DUPLICATEWAKEUPEVENT_SHIFT 23
>>> -#define OMAP4_USBB2_ULPITLL_DAT3_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 23=
)
>>> -#define OMAP4_USBB2_ULPITLL_DAT2_DUPLICATEWAKEUPEVENT_SHIFT 22
>>> -#define OMAP4_USBB2_ULPITLL_DAT2_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 22=
)
>>> -#define OMAP4_USBB2_ULPITLL_DAT1_DUPLICATEWAKEUPEVENT_SHIFT 21
>>> -#define OMAP4_USBB2_ULPITLL_DAT1_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 21=
)
>>> -#define OMAP4_USBB2_ULPITLL_DAT0_DUPLICATEWAKEUPEVENT_SHIFT 20
>>> -#define OMAP4_USBB2_ULPITLL_DAT0_DUPLICATEWAKEUPEVENT_MASK =A0(1 << 20=
)
>>> -#define OMAP4_USBB2_ULPITLL_NXT_DUPLICATEWAKEUPEVENT_SHIFT =A019
>>> -#define OMAP4_USBB2_ULPITLL_NXT_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 19=
)
>>> -#define OMAP4_USBB2_ULPITLL_DIR_DUPLICATEWAKEUPEVENT_SHIFT =A018
>>> -#define OMAP4_USBB2_ULPITLL_DIR_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 18=
)
>>> -#define OMAP4_USBB2_ULPITLL_STP_DUPLICATEWAKEUPEVENT_SHIFT =A017
>>> -#define OMAP4_USBB2_ULPITLL_STP_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 17=
)
>>> -#define OMAP4_USBB2_ULPITLL_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A016
>>> -#define OMAP4_USBB2_ULPITLL_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 (1 << 16=
)
>>> -#define OMAP4_UART4_TX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
15
>>> -#define OMAP4_UART4_TX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 15)
>>> -#define OMAP4_UART4_RX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
14
>>> -#define OMAP4_UART4_RX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 14)
>>> -#define OMAP4_MCSPI4_CS0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 13
>>> -#define OMAP4_MCSPI4_CS0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 13)
>>> -#define OMAP4_MCSPI4_SOMI_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A012
>>> -#define OMAP4_MCSPI4_SOMI_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 12)
>>> -#define OMAP4_MCSPI4_SIMO_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A011
>>> -#define OMAP4_MCSPI4_SIMO_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 11)
>>> -#define OMAP4_MCSPI4_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 10
>>> -#define OMAP4_MCSPI4_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 10)
>>> -#define OMAP4_SDMMC5_DAT3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A09
>>> -#define OMAP4_SDMMC5_DAT3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 9)
>>> -#define OMAP4_SDMMC5_DAT2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A08
>>> -#define OMAP4_SDMMC5_DAT2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 8)
>>> -#define OMAP4_SDMMC5_DAT1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A07
>>> -#define OMAP4_SDMMC5_DAT1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 7)
>>> -#define OMAP4_SDMMC5_DAT0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A06
>>> -#define OMAP4_SDMMC5_DAT0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 6)
>>> -#define OMAP4_SDMMC5_CMD_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 5
>>> -#define OMAP4_SDMMC5_CMD_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 5)
>>> -#define OMAP4_SDMMC5_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 4
>>> -#define OMAP4_SDMMC5_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 4)
>>> -#define OMAP4_UART3_TX_IRTX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A03
>>> -#define OMAP4_UART3_TX_IRTX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 3)
>>> -#define OMAP4_UART3_RX_IRRX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A02
>>> -#define OMAP4_UART3_RX_IRRX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 2)
>>> -#define OMAP4_UART3_RTS_SD_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 1
>>> -#define OMAP4_UART3_RTS_SD_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 1)
>>> -#define OMAP4_UART3_CTS_RCTX_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 0
>>> -#define OMAP4_UART3_CTS_RCTX_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 0)
>>> -
>>> -/* PADCONF_WAKEUPEVENT_5 */
>>> -#define OMAP4_DPM_EMU11_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
31
>>> -#define OMAP4_DPM_EMU11_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 31)
>>> -#define OMAP4_DPM_EMU10_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
30
>>> -#define OMAP4_DPM_EMU10_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 30)
>>> -#define OMAP4_DPM_EMU9_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
29
>>> -#define OMAP4_DPM_EMU9_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 29)
>>> -#define OMAP4_DPM_EMU8_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
28
>>> -#define OMAP4_DPM_EMU8_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 28)
>>> -#define OMAP4_DPM_EMU7_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
27
>>> -#define OMAP4_DPM_EMU7_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 27)
>>> -#define OMAP4_DPM_EMU6_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
26
>>> -#define OMAP4_DPM_EMU6_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 26)
>>> -#define OMAP4_DPM_EMU5_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
25
>>> -#define OMAP4_DPM_EMU5_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 25)
>>> -#define OMAP4_DPM_EMU4_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
24
>>> -#define OMAP4_DPM_EMU4_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 24)
>>> -#define OMAP4_DPM_EMU3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
23
>>> -#define OMAP4_DPM_EMU3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 23)
>>> -#define OMAP4_DPM_EMU2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
22
>>> -#define OMAP4_DPM_EMU2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 22)
>>> -#define OMAP4_DPM_EMU1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
21
>>> -#define OMAP4_DPM_EMU1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 21)
>>> -#define OMAP4_DPM_EMU0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
20
>>> -#define OMAP4_DPM_EMU0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 20)
>>> -#define OMAP4_SYS_BOOT5_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
19
>>> -#define OMAP4_SYS_BOOT5_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 19)
>>> -#define OMAP4_SYS_BOOT4_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
18
>>> -#define OMAP4_SYS_BOOT4_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 18)
>>> -#define OMAP4_SYS_BOOT3_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
17
>>> -#define OMAP4_SYS_BOOT3_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 17)
>>> -#define OMAP4_SYS_BOOT2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
16
>>> -#define OMAP4_SYS_BOOT2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 16)
>>> -#define OMAP4_SYS_BOOT1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
15
>>> -#define OMAP4_SYS_BOOT1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 15)
>>> -#define OMAP4_SYS_BOOT0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
14
>>> -#define OMAP4_SYS_BOOT0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 14)
>>> -#define OMAP4_SYS_NIRQ2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
13
>>> -#define OMAP4_SYS_NIRQ2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 13)
>>> -#define OMAP4_SYS_NIRQ1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
12
>>> -#define OMAP4_SYS_NIRQ1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 12)
>>> -#define OMAP4_FREF_CLK2_OUT_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A011
>>> -#define OMAP4_FREF_CLK2_OUT_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 11)
>>> -#define OMAP4_FREF_CLK1_OUT_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A010
>>> -#define OMAP4_FREF_CLK1_OUT_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 10)
>>> -#define OMAP4_UNIPRO_RY2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 9
>>> -#define OMAP4_UNIPRO_RY2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 9)
>>> -#define OMAP4_UNIPRO_RX2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 8
>>> -#define OMAP4_UNIPRO_RX2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 8)
>>> -#define OMAP4_UNIPRO_RY1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 7
>>> -#define OMAP4_UNIPRO_RY1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 7)
>>> -#define OMAP4_UNIPRO_RX1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 6
>>> -#define OMAP4_UNIPRO_RX1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 6)
>>> -#define OMAP4_UNIPRO_RY0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 5
>>> -#define OMAP4_UNIPRO_RY0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 5)
>>> -#define OMAP4_UNIPRO_RX0_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 4
>>> -#define OMAP4_UNIPRO_RX0_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 4)
>>> -#define OMAP4_UNIPRO_TY2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 3
>>> -#define OMAP4_UNIPRO_TY2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 3)
>>> -#define OMAP4_UNIPRO_TX2_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 2
>>> -#define OMAP4_UNIPRO_TX2_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 2)
>>> -#define OMAP4_UNIPRO_TY1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 1
>>> -#define OMAP4_UNIPRO_TY1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 1)
>>> -#define OMAP4_UNIPRO_TX1_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_UNIPRO_TX1_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 0)
>>> -
>>> -/* PADCONF_WAKEUPEVENT_6 */
>>> -#define OMAP4_DPM_EMU19_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
7
>>> -#define OMAP4_DPM_EMU19_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 7)
>>> -#define OMAP4_DPM_EMU18_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
6
>>> -#define OMAP4_DPM_EMU18_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 6)
>>> -#define OMAP4_DPM_EMU17_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
5
>>> -#define OMAP4_DPM_EMU17_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 5)
>>> -#define OMAP4_DPM_EMU16_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
4
>>> -#define OMAP4_DPM_EMU16_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 4)
>>> -#define OMAP4_DPM_EMU15_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
3
>>> -#define OMAP4_DPM_EMU15_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 3)
>>> -#define OMAP4_DPM_EMU14_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
2
>>> -#define OMAP4_DPM_EMU14_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 2)
>>> -#define OMAP4_DPM_EMU13_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
1
>>> -#define OMAP4_DPM_EMU13_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 1)
>>> -#define OMAP4_DPM_EMU12_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
0
>>> -#define OMAP4_DPM_EMU12_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 0)
>>> -
>>> -/* CONTROL_PADCONF_GLOBAL */
>>> -#define OMAP4_FORCE_OFFMODE_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_FORCE_OFFMODE_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 31)
>>> -
>>> -/* CONTROL_PADCONF_MODE */
>>> -#define OMAP4_VDDS_DV_BANK0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 31
>>> -#define OMAP4_VDDS_DV_BANK0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_VDDS_DV_BANK1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 30
>>> -#define OMAP4_VDDS_DV_BANK1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_VDDS_DV_BANK3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 29
>>> -#define OMAP4_VDDS_DV_BANK3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 29)
>>> -#define OMAP4_VDDS_DV_BANK4_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 28
>>> -#define OMAP4_VDDS_DV_BANK4_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_VDDS_DV_BANK5_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 27
>>> -#define OMAP4_VDDS_DV_BANK5_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 27)
>>> -#define OMAP4_VDDS_DV_BANK6_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 26
>>> -#define OMAP4_VDDS_DV_BANK6_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 26)
>>> -#define OMAP4_VDDS_DV_C2C_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 25
>>> -#define OMAP4_VDDS_DV_C2C_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 25)
>>> -#define OMAP4_VDDS_DV_CAM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_VDDS_DV_CAM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>>> -#define OMAP4_VDDS_DV_GPMC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A023
>>> -#define OMAP4_VDDS_DV_GPMC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 23)
>>> -#define OMAP4_VDDS_DV_SDMMC2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A022
>>> -#define OMAP4_VDDS_DV_SDMMC2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 22)
>>> -
>>> -/* CONTROL_SMART1IO_PADCONF_0 */
>>> -#define OMAP4_ABE_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_ABE_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 30)
>>> -#define OMAP4_CAM_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A028
>>> -#define OMAP4_CAM_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 28)
>>> -#define OMAP4_FREF_DR2_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26
>>> -#define OMAP4_FREF_DR2_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 26)
>>> -#define OMAP4_FREF_DR3_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_FREF_DR3_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 24)
>>> -#define OMAP4_GPIO_DR8_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_GPIO_DR8_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_GPIO_DR9_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 20
>>> -#define OMAP4_GPIO_DR9_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 20)
>>> -#define OMAP4_GPMC_DR2_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 18
>>> -#define OMAP4_GPMC_DR2_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 18)
>>> -#define OMAP4_GPMC_DR3_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_GPMC_DR3_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 16)
>>> -#define OMAP4_GPMC_DR6_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 14
>>> -#define OMAP4_GPMC_DR6_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 14)
>>> -#define OMAP4_HDMI_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 12
>>> -#define OMAP4_HDMI_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 12)
>>> -#define OMAP4_MCSPI1_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 10
>>> -#define OMAP4_MCSPI1_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 10)
>>> -#define OMAP4_UART1_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_UART1_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 8)
>>> -#define OMAP4_UART3_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_UART3_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 6)
>>> -#define OMAP4_UART3_DR1_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A04
>>> -#define OMAP4_UART3_DR1_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 4)
>>> -#define OMAP4_UNIPRO_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 2
>>> -#define OMAP4_UNIPRO_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 2)
>>> -#define OMAP4_UNIPRO_DR1_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 0
>>> -#define OMAP4_UNIPRO_DR1_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 0)
>>> -
>>> -/* CONTROL_SMART1IO_PADCONF_1 */
>>> -#define OMAP4_ABE_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_ABE_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 30)
>>> -#define OMAP4_CAM_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A028
>>> -#define OMAP4_CAM_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 28)
>>> -#define OMAP4_FREF_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26
>>> -#define OMAP4_FREF_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 26)
>>> -#define OMAP4_FREF_DR3_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_FREF_DR3_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 24)
>>> -#define OMAP4_GPIO_DR8_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_GPIO_DR8_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_GPIO_DR9_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 20
>>> -#define OMAP4_GPIO_DR9_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 20)
>>> -#define OMAP4_GPMC_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 18
>>> -#define OMAP4_GPMC_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 18)
>>> -#define OMAP4_GPMC_DR3_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_GPMC_DR3_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 16)
>>> -#define OMAP4_GPMC_DR6_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 14
>>> -#define OMAP4_GPMC_DR6_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 14)
>>> -#define OMAP4_HDMI_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 12
>>> -#define OMAP4_HDMI_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 12)
>>> -#define OMAP4_MCSPI1_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 10
>>> -#define OMAP4_MCSPI1_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 10)
>>> -#define OMAP4_UART1_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_UART1_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 8)
>>> -#define OMAP4_UART3_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_UART3_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 6)
>>> -#define OMAP4_UART3_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A04
>>> -#define OMAP4_UART3_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 4)
>>> -#define OMAP4_UNIPRO_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 2
>>> -#define OMAP4_UNIPRO_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 2)
>>> -#define OMAP4_UNIPRO_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 0
>>> -#define OMAP4_UNIPRO_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 0)
>>> -
>>> -/* CONTROL_SMART2IO_PADCONF_0 */
>>> -#define OMAP4_C2C_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_C2C_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_DPM_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_DPM_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 30)
>>> -#define OMAP4_DPM_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_DPM_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 29)
>>> -#define OMAP4_DPM_DR3_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A028
>>> -#define OMAP4_DPM_DR3_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 28)
>>> -#define OMAP4_GPIO_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 27
>>> -#define OMAP4_GPIO_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 27)
>>> -#define OMAP4_GPIO_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26
>>> -#define OMAP4_GPIO_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 26)
>>> -#define OMAP4_GPIO_DR10_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_GPIO_DR10_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 25)
>>> -#define OMAP4_GPIO_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_GPIO_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>>> -#define OMAP4_GPMC_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 23
>>> -#define OMAP4_GPMC_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 23)
>>> -#define OMAP4_GPMC_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_GPMC_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 22)
>>> -#define OMAP4_GPMC_DR4_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 21
>>> -#define OMAP4_GPMC_DR4_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
>>> -#define OMAP4_GPMC_DR5_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 20
>>> -#define OMAP4_GPMC_DR5_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 20)
>>> -#define OMAP4_GPMC_DR7_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 19
>>> -#define OMAP4_GPMC_DR7_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 19)
>>> -#define OMAP4_HSI2_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 18
>>> -#define OMAP4_HSI2_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 18)
>>> -#define OMAP4_HSI2_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 17
>>> -#define OMAP4_HSI2_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 17)
>>> -#define OMAP4_HSI2_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_HSI2_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
>>> -#define OMAP4_KPD_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A015
>>> -#define OMAP4_KPD_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 15)
>>> -#define OMAP4_KPD_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_KPD_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 14)
>>> -#define OMAP4_PDM_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A013
>>> -#define OMAP4_PDM_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 13)
>>> -#define OMAP4_SDMMC2_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 12
>>> -#define OMAP4_SDMMC2_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 12)
>>> -#define OMAP4_SDMMC3_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 11
>>> -#define OMAP4_SDMMC3_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 11)
>>> -#define OMAP4_SDMMC4_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 10
>>> -#define OMAP4_SDMMC4_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 10)
>>> -#define OMAP4_SDMMC4_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 9
>>> -#define OMAP4_SDMMC4_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 9)
>>> -#define OMAP4_SPI3_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8
>>> -#define OMAP4_SPI3_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 8)
>>> -#define OMAP4_SPI3_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 7
>>> -#define OMAP4_SPI3_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7)
>>> -#define OMAP4_UART3_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_UART3_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 6)
>>> -#define OMAP4_UART3_DR3_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A05
>>> -#define OMAP4_UART3_DR3_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5)
>>> -#define OMAP4_UART3_DR4_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A04
>>> -#define OMAP4_UART3_DR4_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
>>> -#define OMAP4_UART3_DR5_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A03
>>> -#define OMAP4_UART3_DR5_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3)
>>> -#define OMAP4_USBA0_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A02
>>> -#define OMAP4_USBA0_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 2)
>>> -#define OMAP4_USBA_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
>>> -#define OMAP4_USBA_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>>> -
>>> -/* CONTROL_SMART2IO_PADCONF_1 */
>>> -#define OMAP4_USBB1_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_USBB1_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_USBB2_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_USBB2_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 30)
>>> -#define OMAP4_USBA0_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_USBA0_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 29)
>>> -
>>> -/* CONTROL_SMART3IO_PADCONF_0 */
>>> -#define OMAP4_DMIC_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_DMIC_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_GPIO_DR3_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_GPIO_DR3_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 28)
>>> -#define OMAP4_GPIO_DR4_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26
>>> -#define OMAP4_GPIO_DR4_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 26)
>>> -#define OMAP4_GPIO_DR5_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_GPIO_DR5_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 24)
>>> -#define OMAP4_GPIO_DR6_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_GPIO_DR6_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_HSI_DR1_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A020
>>> -#define OMAP4_HSI_DR1_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 20)
>>> -#define OMAP4_HSI_DR2_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A018
>>> -#define OMAP4_HSI_DR2_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 18)
>>> -#define OMAP4_HSI_DR3_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
>>> -#define OMAP4_HSI_DR3_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 16)
>>> -#define OMAP4_MCBSP2_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 14
>>> -#define OMAP4_MCBSP2_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 14)
>>> -#define OMAP4_MCSPI4_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 12
>>> -#define OMAP4_MCSPI4_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 12)
>>> -#define OMAP4_MCSPI4_DR1_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 10
>>> -#define OMAP4_MCSPI4_DR1_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 10)
>>> -#define OMAP4_SDMMC3_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 8
>>> -#define OMAP4_SDMMC3_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 8)
>>> -#define OMAP4_SPI2_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_SPI2_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 0)
>>> -
>>> -/* CONTROL_SMART3IO_PADCONF_1 */
>>> -#define OMAP4_SPI2_DR1_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_SPI2_DR1_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_SPI2_DR2_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_SPI2_DR2_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 28)
>>> -#define OMAP4_UART2_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A026
>>> -#define OMAP4_UART2_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 26)
>>> -#define OMAP4_UART2_DR1_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A024
>>> -#define OMAP4_UART2_DR1_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 24)
>>> -#define OMAP4_UART4_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A022
>>> -#define OMAP4_UART4_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 22)
>>> -#define OMAP4_HSI_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A020
>>> -#define OMAP4_HSI_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 20)
>>> -
>>> -/* CONTROL_SMART3IO_PADCONF_2 */
>>> -#define OMAP4_DMIC_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 31
>>> -#define OMAP4_DMIC_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_GPIO_DR3_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_GPIO_DR3_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_GPIO_DR4_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 29
>>> -#define OMAP4_GPIO_DR4_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 29)
>>> -#define OMAP4_GPIO_DR5_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_GPIO_DR5_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_GPIO_DR6_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 27
>>> -#define OMAP4_GPIO_DR6_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 27)
>>> -#define OMAP4_HSI_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A026
>>> -#define OMAP4_HSI_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 26)
>>> -#define OMAP4_HSI_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_HSI_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 25)
>>> -#define OMAP4_HSI_DR3_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A024
>>> -#define OMAP4_HSI_DR3_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 24)
>>> -#define OMAP4_MCBSP2_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 23
>>> -#define OMAP4_MCBSP2_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 23)
>>> -#define OMAP4_MCSPI4_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 22
>>> -#define OMAP4_MCSPI4_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 22)
>>> -#define OMAP4_MCSPI4_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 21
>>> -#define OMAP4_MCSPI4_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 21)
>>> -#define OMAP4_SLIMBUS2_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 18
>>> -#define OMAP4_SLIMBUS2_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 18)
>>> -#define OMAP4_SPI2_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_SPI2_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
>>> -#define OMAP4_SPI2_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 15
>>> -#define OMAP4_SPI2_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 15)
>>> -#define OMAP4_SPI2_DR2_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 14
>>> -#define OMAP4_SPI2_DR2_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 14)
>>> -#define OMAP4_UART2_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A013
>>> -#define OMAP4_UART2_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 13)
>>> -#define OMAP4_UART2_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A012
>>> -#define OMAP4_UART2_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 12)
>>> -#define OMAP4_UART4_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A011
>>> -#define OMAP4_UART4_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 11)
>>> -#define OMAP4_HSI_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A010
>>> -#define OMAP4_HSI_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 10)
>>> -
>>> -/* CONTROL_USBB_HSIC */
>>> -#define OMAP4_USBB2_DR1_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_USBB2_DR1_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 30)
>>> -#define OMAP4_USBB2_DR1_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 27
>>> -#define OMAP4_USBB2_DR1_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7 << 27)
>>> -#define OMAP4_USBB1_DR1_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_USBB1_DR1_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 25)
>>> -#define OMAP4_USBB1_DR1_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_USBB1_DR1_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7 << 22)
>>> -#define OMAP4_USBB1_HSIC_DATA_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A020
>>> -#define OMAP4_USBB1_HSIC_DATA_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 20)
>>> -#define OMAP4_USBB1_HSIC_STROBE_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A018
>>> -#define OMAP4_USBB1_HSIC_STROBE_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 18)
>>> -#define OMAP4_USBB2_HSIC_DATA_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A016
>>> -#define OMAP4_USBB2_HSIC_DATA_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 16)
>>> -#define OMAP4_USBB2_HSIC_STROBE_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A014
>>> -#define OMAP4_USBB2_HSIC_STROBE_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_USBB1_HSIC_DATA_OFFMODE_WD_ENABLE_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 13
>>> -#define OMAP4_USBB1_HSIC_DATA_OFFMODE_WD_ENABLE_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 13)
>>> -#define OMAP4_USBB1_HSIC_DATA_OFFMODE_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A011
>>> -#define OMAP4_USBB1_HSIC_DATA_OFFMODE_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x3 << 11)
>>> -#define OMAP4_USBB1_HSIC_STROBE_OFFMODE_WD_ENABLE_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 10
>>> -#define OMAP4_USBB1_HSIC_STROBE_OFFMODE_WD_ENABLE_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 10)
>>> -#define OMAP4_USBB1_HSIC_STROBE_OFFMODE_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A08
>>> -#define OMAP4_USBB1_HSIC_STROBE_OFFMODE_WD_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x3 << 8)
>>> -#define OMAP4_USBB2_HSIC_DATA_OFFMODE_WD_ENABLE_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 7
>>> -#define OMAP4_USBB2_HSIC_DATA_OFFMODE_WD_ENABLE_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 7)
>>> -#define OMAP4_USBB2_HSIC_DATA_OFFMODE_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A05
>>> -#define OMAP4_USBB2_HSIC_DATA_OFFMODE_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x3 << 5)
>>> -#define OMAP4_USBB2_HSIC_STROBE_OFFMODE_WD_ENABLE_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 4
>>> -#define OMAP4_USBB2_HSIC_STROBE_OFFMODE_WD_ENABLE_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 4)
>>> -#define OMAP4_USBB2_HSIC_STROBE_OFFMODE_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A02
>>> -#define OMAP4_USBB2_HSIC_STROBE_OFFMODE_WD_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (0x3 << 2)
>>> -
>>> -/* CONTROL_SLIMBUS */
>>> -#define OMAP4_SLIMBUS1_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 30
>>> -#define OMAP4_SLIMBUS1_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_SLIMBUS1_DR1_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 28
>>> -#define OMAP4_SLIMBUS1_DR1_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x3 << 28)
>>> -#define OMAP4_SLIMBUS2_DR0_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 26
>>> -#define OMAP4_SLIMBUS2_DR0_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x3 << 26)
>>> -#define OMAP4_SLIMBUS2_DR1_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 24
>>> -#define OMAP4_SLIMBUS2_DR1_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x3 << 24)
>>> -#define OMAP4_SLIMBUS2_DR2_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 22
>>> -#define OMAP4_SLIMBUS2_DR2_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_SLIMBUS2_DR3_MB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 20
>>> -#define OMAP4_SLIMBUS2_DR3_MB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x3 << 20)
>>> -#define OMAP4_SLIMBUS1_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 19
>>> -#define OMAP4_SLIMBUS1_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 19)
>>> -#define OMAP4_SLIMBUS2_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 18
>>> -#define OMAP4_SLIMBUS2_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 18)
>>> -
>>> -/* CONTROL_PBIASLITE */
>>> -#define OMAP4_USIM_PBIASLITE_HIZ_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 31
>>> -#define OMAP4_USIM_PBIASLITE_HIZ_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 31)
>>> -#define OMAP4_USIM_PBIASLITE_SUPPLY_HI_OUT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A030
>>> -#define OMAP4_USIM_PBIASLITE_SUPPLY_HI_OUT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 30)
>>> -#define OMAP4_USIM_PBIASLITE_VMODE_ERROR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_USIM_PBIASLITE_VMODE_ERROR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 29)
>>> -#define OMAP4_USIM_PBIASLITE_PWRDNZ_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 28
>>> -#define OMAP4_USIM_PBIASLITE_PWRDNZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_USIM_PBIASLITE_VMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A027
>>> -#define OMAP4_USIM_PBIASLITE_VMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 27)
>>> -#define OMAP4_MMC1_PWRDNZ_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26
>>> -#define OMAP4_MMC1_PWRDNZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 26)
>>> -#define OMAP4_MMC1_PBIASLITE_HIZ_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 25
>>> -#define OMAP4_MMC1_PBIASLITE_HIZ_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 25)
>>> -#define OMAP4_MMC1_PBIASLITE_SUPPLY_HI_OUT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A024
>>> -#define OMAP4_MMC1_PBIASLITE_SUPPLY_HI_OUT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 24)
>>> -#define OMAP4_MMC1_PBIASLITE_VMODE_ERROR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A023
>>> -#define OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 23)
>>> -#define OMAP4_MMC1_PBIASLITE_PWRDNZ_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 22
>>> -#define OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 22)
>>> -#define OMAP4_MMC1_PBIASLITE_VMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A021
>>> -#define OMAP4_MMC1_PBIASLITE_VMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 21)
>>> -#define OMAP4_USBC1_ICUSB_PWRDNZ_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A020
>>> -#define OMAP4_USBC1_ICUSB_PWRDNZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 20)
>>> -
>>> -/* CONTROL_I2C_0 */
>>> -#define OMAP4_I2C4_SDA_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 31
>>> -#define OMAP4_I2C4_SDA_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_I2C4_SDA_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_I2C4_SDA_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 29)
>>> -#define OMAP4_I2C4_SDA_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_I2C4_SDA_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_I2C3_SDA_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 27
>>> -#define OMAP4_I2C3_SDA_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 27)
>>> -#define OMAP4_I2C3_SDA_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_I2C3_SDA_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 25)
>>> -#define OMAP4_I2C3_SDA_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_I2C3_SDA_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>>> -#define OMAP4_I2C2_SDA_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 23
>>> -#define OMAP4_I2C2_SDA_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 23)
>>> -#define OMAP4_I2C2_SDA_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A021
>>> -#define OMAP4_I2C2_SDA_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 21)
>>> -#define OMAP4_I2C2_SDA_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 20
>>> -#define OMAP4_I2C2_SDA_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 20)
>>> -#define OMAP4_I2C1_SDA_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 19
>>> -#define OMAP4_I2C1_SDA_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 19)
>>> -#define OMAP4_I2C1_SDA_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A017
>>> -#define OMAP4_I2C1_SDA_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 17)
>>> -#define OMAP4_I2C1_SDA_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_I2C1_SDA_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
>>> -#define OMAP4_I2C4_SCL_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 15
>>> -#define OMAP4_I2C4_SCL_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 15)
>>> -#define OMAP4_I2C4_SCL_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A013
>>> -#define OMAP4_I2C4_SCL_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 13)
>>> -#define OMAP4_I2C4_SCL_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 12
>>> -#define OMAP4_I2C4_SCL_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 12)
>>> -#define OMAP4_I2C3_SCL_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 11
>>> -#define OMAP4_I2C3_SCL_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 11)
>>> -#define OMAP4_I2C3_SCL_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A09
>>> -#define OMAP4_I2C3_SCL_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 9)
>>> -#define OMAP4_I2C3_SCL_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 8
>>> -#define OMAP4_I2C3_SCL_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 8)
>>> -#define OMAP4_I2C2_SCL_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 7
>>> -#define OMAP4_I2C2_SCL_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 7)
>>> -#define OMAP4_I2C2_SCL_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A05
>>> -#define OMAP4_I2C2_SCL_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 5)
>>> -#define OMAP4_I2C2_SCL_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 4
>>> -#define OMAP4_I2C2_SCL_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 4)
>>> -#define OMAP4_I2C1_SCL_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 3
>>> -#define OMAP4_I2C1_SCL_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 3)
>>> -#define OMAP4_I2C1_SCL_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>>> -#define OMAP4_I2C1_SCL_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 1)
>>> -#define OMAP4_I2C1_SCL_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_I2C1_SCL_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>>> -
>>> -/* CONTROL_CAMERA_RX */
>>> -#define OMAP4_CAMERARX_UNIPRO_CTRLCLKEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 31
>>> -#define OMAP4_CAMERARX_UNIPRO_CTRLCLKEN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_CAMERARX_CSI22_LANEENABLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 29
>>> -#define OMAP4_CAMERARX_CSI22_LANEENABLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(0x3 << 29)
>>> -#define OMAP4_CAMERARX_CSI21_LANEENABLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_CAMERARX_CSI21_LANEENABLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(0x1f << 24)
>>> -#define OMAP4_CAMERARX_UNIPRO_CAMMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 22
>>> -#define OMAP4_CAMERARX_UNIPRO_CAMMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_CAMERARX_CSI22_CTRLCLKEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A021
>>> -#define OMAP4_CAMERARX_CSI22_CTRLCLKEN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 21)
>>> -#define OMAP4_CAMERARX_CSI22_CAMMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A019
>>> -#define OMAP4_CAMERARX_CSI22_CAMMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0x3 << 19)
>>> -#define OMAP4_CAMERARX_CSI21_CTRLCLKEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A018
>>> -#define OMAP4_CAMERARX_CSI21_CTRLCLKEN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 18)
>>> -#define OMAP4_CAMERARX_CSI21_CAMMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A016
>>> -#define OMAP4_CAMERARX_CSI21_CAMMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0x3 << 16)
>>> -
>>> -/* CONTROL_AVDAC */
>>> -#define OMAP4_AVDAC_ACEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_AVDAC_ACEN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_AVDAC_TVOUTBYPASS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_AVDAC_TVOUTBYPASS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_AVDAC_INPUTINV_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A029
>>> -#define OMAP4_AVDAC_INPUTINV_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 29)
>>> -#define OMAP4_AVDAC_CTL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 13
>>> -#define OMAP4_AVDAC_CTL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xffff << 13)
>>> -#define OMAP4_AVDAC_CTL_WR_ACK_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A012
>>> -#define OMAP4_AVDAC_CTL_WR_ACK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 12)
>>> -
>>> -/* CONTROL_HDMI_TX_PHY */
>>> -#define OMAP4_HDMITXPHY_PADORDER_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_HDMITXPHY_PADORDER_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_HDMITXPHY_TXVALID_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_HDMITXPHY_TXVALID_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_HDMITXPHY_ENBYPASSCLK_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 29
>>> -#define OMAP4_HDMITXPHY_ENBYPASSCLK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 29)
>>> -#define OMAP4_HDMITXPHY_PD_PULLUPDET_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A028
>>> -#define OMAP4_HDMITXPHY_PD_PULLUPDET_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 28)
>>> -
>>> -/* CONTROL_MMC2 */
>>> -#define OMAP4_MMC2_FEEDBACK_CLK_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 31
>>> -#define OMAP4_MMC2_FEEDBACK_CLK_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 31)
>>> -
>>> -/* CONTROL_DSIPHY */
>>> -#define OMAP4_DSI2_LANEENABLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 29
>>> -#define OMAP4_DSI2_LANEENABLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 29)
>>> -#define OMAP4_DSI1_LANEENABLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 24
>>> -#define OMAP4_DSI1_LANEENABLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x1f << 24)
>>> -#define OMAP4_DSI1_PIPD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 19
>>> -#define OMAP4_DSI1_PIPD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1f << 19)
>>> -#define OMAP4_DSI2_PIPD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 14
>>> -#define OMAP4_DSI2_PIPD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1f << 14)
>>> -
>>> -/* CONTROL_MCBSPLP */
>>> -#define OMAP4_ALBCTRLRX_FSX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 31
>>> -#define OMAP4_ALBCTRLRX_FSX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_ALBCTRLRX_CLKX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A030
>>> -#define OMAP4_ALBCTRLRX_CLKX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 30)
>>> -#define OMAP4_ABE_MCBSP1_DR_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_ABE_MCBSP1_DR_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 29)
>>> -
>>> -/* CONTROL_USB2PHYCORE */
>>> -#define OMAP4_USB2PHY_AUTORESUME_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 31
>>> -#define OMAP4_USB2PHY_AUTORESUME_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_USB2PHY_DISCHGDET_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_USB2PHY_DISCHGDET_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_USB2PHY_GPIOMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_USB2PHY_GPIOMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 29)
>>> -#define OMAP4_USB2PHY_CHG_DET_EXT_CTL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 28
>>> -#define OMAP4_USB2PHY_CHG_DET_EXT_CTL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 28)
>>> -#define OMAP4_USB2PHY_RDM_PD_CHGDET_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A027
>>> -#define OMAP4_USB2PHY_RDM_PD_CHGDET_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 27)
>>> -#define OMAP4_USB2PHY_RDP_PU_CHGDET_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A026
>>> -#define OMAP4_USB2PHY_RDP_PU_CHGDET_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 26)
>>> -#define OMAP4_USB2PHY_CHG_VSRC_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 25
>>> -#define OMAP4_USB2PHY_CHG_VSRC_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 25)
>>> -#define OMAP4_USB2PHY_CHG_ISINK_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A024
>>> -#define OMAP4_USB2PHY_CHG_ISINK_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 24)
>>> -#define OMAP4_USB2PHY_CHG_DET_STATUS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A021
>>> -#define OMAP4_USB2PHY_CHG_DET_STATUS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0x7 << 21)
>>> -#define OMAP4_USB2PHY_CHG_DET_DM_COMP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 20
>>> -#define OMAP4_USB2PHY_CHG_DET_DM_COMP_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 20)
>>> -#define OMAP4_USB2PHY_CHG_DET_DP_COMP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 19
>>> -#define OMAP4_USB2PHY_CHG_DET_DP_COMP_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 19)
>>> -#define OMAP4_USB2PHY_DATADET_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 18
>>> -#define OMAP4_USB2PHY_DATADET_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 18)
>>> -#define OMAP4_USB2PHY_SINKONDP_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017
>>> -#define OMAP4_USB2PHY_SINKONDP_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 17)
>>> -#define OMAP4_USB2PHY_SRCONDM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 16
>>> -#define OMAP4_USB2PHY_SRCONDM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 16)
>>> -#define OMAP4_USB2PHY_RESTARTCHGDET_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 15
>>> -#define OMAP4_USB2PHY_RESTARTCHGDET_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 15)
>>> -#define OMAP4_USB2PHY_CHGDETDONE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_USB2PHY_CHGDETDONE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 14)
>>> -#define OMAP4_USB2PHY_CHGDETECTED_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 13
>>> -#define OMAP4_USB2PHY_CHGDETECTED_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 13)
>>> -#define OMAP4_USB2PHY_MCPCPUEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A012
>>> -#define OMAP4_USB2PHY_MCPCPUEN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 12)
>>> -#define OMAP4_USB2PHY_MCPCMODEEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A011
>>> -#define OMAP4_USB2PHY_MCPCMODEEN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 11)
>>> -#define OMAP4_USB2PHY_RESETDONEMCLK_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 10
>>> -#define OMAP4_USB2PHY_RESETDONEMCLK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 10)
>>> -#define OMAP4_USB2PHY_UTMIRESETDONE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 9
>>> -#define OMAP4_USB2PHY_UTMIRESETDONE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 9)
>>> -#define OMAP4_USB2PHY_TXBITSTUFFENABLE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_USB2PHY_TXBITSTUFFENABLE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 8)
>>> -#define OMAP4_USB2PHY_DATAPOLARITYN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 7
>>> -#define OMAP4_USB2PHY_DATAPOLARITYN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 7)
>>> -#define OMAP4_USBDPLL_FREQLOCK_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_USBDPLL_FREQLOCK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 6)
>>> -#define OMAP4_USB2PHY_RESETDONETCLK_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 5
>>> -#define OMAP4_USB2PHY_RESETDONETCLK_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 5)
>>> -
>>> -/* CONTROL_I2C_1 */
>>> -#define OMAP4_HDMI_DDC_SDA_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 31
>>> -#define OMAP4_HDMI_DDC_SDA_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_HDMI_DDC_SDA_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A029
>>> -#define OMAP4_HDMI_DDC_SDA_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0x3 << 29)
>>> -#define OMAP4_HDMI_DDC_SDA_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 28
>>> -#define OMAP4_HDMI_DDC_SDA_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 28)
>>> -#define OMAP4_HDMI_DDC_SCL_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 27
>>> -#define OMAP4_HDMI_DDC_SCL_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 27)
>>> -#define OMAP4_HDMI_DDC_SCL_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A025
>>> -#define OMAP4_HDMI_DDC_SCL_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (0x3 << 25)
>>> -#define OMAP4_HDMI_DDC_SCL_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 24
>>> -#define OMAP4_HDMI_DDC_SCL_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 24)
>>> -#define OMAP4_HDMI_DDC_SDA_HSMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 23
>>> -#define OMAP4_HDMI_DDC_SDA_HSMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 23)
>>> -#define OMAP4_HDMI_DDC_SDA_NMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A022
>>> -#define OMAP4_HDMI_DDC_SDA_NMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 22)
>>> -#define OMAP4_HDMI_DDC_SCL_HSMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 21
>>> -#define OMAP4_HDMI_DDC_SCL_HSMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
>>> -#define OMAP4_HDMI_DDC_SCL_NMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A020
>>> -#define OMAP4_HDMI_DDC_SCL_NMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 20)
>>> -
>>> -/* CONTROL_MMC1 */
>>> -#define OMAP4_SDMMC1_PUSTRENGTH_GRP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A031
>>> -#define OMAP4_SDMMC1_PUSTRENGTH_GRP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 31)
>>> -#define OMAP4_SDMMC1_PUSTRENGTH_GRP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A030
>>> -#define OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 30)
>>> -#define OMAP4_SDMMC1_PUSTRENGTH_GRP2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A029
>>> -#define OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 29)
>>> -#define OMAP4_SDMMC1_PUSTRENGTH_GRP3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A028
>>> -#define OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 28)
>>> -#define OMAP4_SDMMC1_DR0_SPEEDCTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A027
>>> -#define OMAP4_SDMMC1_DR0_SPEEDCTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 27)
>>> -#define OMAP4_SDMMC1_DR1_SPEEDCTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A026
>>> -#define OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 26)
>>> -#define OMAP4_SDMMC1_DR2_SPEEDCTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A025
>>> -#define OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 25)
>>> -#define OMAP4_USBC1_DR0_SPEEDCTRL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_USBC1_DR0_SPEEDCTRL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>>> -#define OMAP4_USB_FD_CDEN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 23
>>> -#define OMAP4_USB_FD_CDEN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 23)
>>> -#define OMAP4_USBC1_ICUSB_DP_PDDIS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A022
>>> -#define OMAP4_USBC1_ICUSB_DP_PDDIS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 22)
>>> -#define OMAP4_USBC1_ICUSB_DM_PDDIS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A021
>>> -#define OMAP4_USBC1_ICUSB_DM_PDDIS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 21)
>>> -
>>> -/* CONTROL_HSI */
>>> -#define OMAP4_HSI1_CALLOOP_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_HSI1_CALLOOP_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_HSI1_CALMUX_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 30
>>> -#define OMAP4_HSI1_CALMUX_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_HSI2_CALLOOP_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_HSI2_CALLOOP_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 29)
>>> -#define OMAP4_HSI2_CALMUX_SEL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 28
>>> -#define OMAP4_HSI2_CALMUX_SEL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(1 << 28)
>>> -
>>> -/* CONTROL_USB */
>>> -#define OMAP4_CARKIT_USBA0_ULPIPHY_DAT0_AUTO_EN_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 31
>>> -#define OMAP4_CARKIT_USBA0_ULPIPHY_DAT0_AUTO_EN_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_CARKIT_USBA0_ULPIPHY_DAT1_AUTO_EN_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 30
>>> -#define OMAP4_CARKIT_USBA0_ULPIPHY_DAT1_AUTO_EN_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 30)
>>> -
>>> -/* CONTROL_HDQ */
>>> -#define OMAP4_HDQ_SIO_PWRDNZ_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A031
>>> -#define OMAP4_HDQ_SIO_PWRDNZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 31)
>>> -
>>> -/* CONTROL_LPDDR2IO1_0 */
>>> -#define OMAP4_LPDDR2IO1_GR4_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_LPDDR2IO1_GR4_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 30)
>>> -#define OMAP4_LPDDR2IO1_GR4_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 27
>>> -#define OMAP4_LPDDR2IO1_GR4_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 27)
>>> -#define OMAP4_LPDDR2IO1_GR4_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_LPDDR2IO1_GR4_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 25)
>>> -#define OMAP4_LPDDR2IO1_GR3_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A022
>>> -#define OMAP4_LPDDR2IO1_GR3_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 22)
>>> -#define OMAP4_LPDDR2IO1_GR3_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 19
>>> -#define OMAP4_LPDDR2IO1_GR3_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 19)
>>> -#define OMAP4_LPDDR2IO1_GR3_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017
>>> -#define OMAP4_LPDDR2IO1_GR3_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 17)
>>> -#define OMAP4_LPDDR2IO1_GR2_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_LPDDR2IO1_GR2_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_LPDDR2IO1_GR2_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 11
>>> -#define OMAP4_LPDDR2IO1_GR2_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 11)
>>> -#define OMAP4_LPDDR2IO1_GR2_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A09
>>> -#define OMAP4_LPDDR2IO1_GR2_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 9)
>>> -#define OMAP4_LPDDR2IO1_GR1_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_LPDDR2IO1_GR1_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 6)
>>> -#define OMAP4_LPDDR2IO1_GR1_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 3
>>> -#define OMAP4_LPDDR2IO1_GR1_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 3)
>>> -#define OMAP4_LPDDR2IO1_GR1_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>>> -#define OMAP4_LPDDR2IO1_GR1_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 1)
>>> -
>>> -/* CONTROL_LPDDR2IO1_1 */
>>> -#define OMAP4_LPDDR2IO1_GR8_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_LPDDR2IO1_GR8_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 30)
>>> -#define OMAP4_LPDDR2IO1_GR8_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 27
>>> -#define OMAP4_LPDDR2IO1_GR8_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 27)
>>> -#define OMAP4_LPDDR2IO1_GR8_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_LPDDR2IO1_GR8_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 25)
>>> -#define OMAP4_LPDDR2IO1_GR7_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A022
>>> -#define OMAP4_LPDDR2IO1_GR7_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 22)
>>> -#define OMAP4_LPDDR2IO1_GR7_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 19
>>> -#define OMAP4_LPDDR2IO1_GR7_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 19)
>>> -#define OMAP4_LPDDR2IO1_GR7_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017
>>> -#define OMAP4_LPDDR2IO1_GR7_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 17)
>>> -#define OMAP4_LPDDR2IO1_GR6_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_LPDDR2IO1_GR6_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_LPDDR2IO1_GR6_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 11
>>> -#define OMAP4_LPDDR2IO1_GR6_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 11)
>>> -#define OMAP4_LPDDR2IO1_GR6_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A09
>>> -#define OMAP4_LPDDR2IO1_GR6_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 9)
>>> -#define OMAP4_LPDDR2IO1_GR5_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_LPDDR2IO1_GR5_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 6)
>>> -#define OMAP4_LPDDR2IO1_GR5_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 3
>>> -#define OMAP4_LPDDR2IO1_GR5_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 3)
>>> -#define OMAP4_LPDDR2IO1_GR5_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>>> -#define OMAP4_LPDDR2IO1_GR5_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 1)
>>> -
>>> -/* CONTROL_LPDDR2IO1_2 */
>>> -#define OMAP4_LPDDR2IO1_GR11_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_LPDDR2IO1_GR11_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_LPDDR2IO1_GR11_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A027
>>> -#define OMAP4_LPDDR2IO1_GR11_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x7 << 27)
>>> -#define OMAP4_LPDDR2IO1_GR11_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 25
>>> -#define OMAP4_LPDDR2IO1_GR11_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 25)
>>> -#define OMAP4_LPDDR2IO1_GR10_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_LPDDR2IO1_GR10_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_LPDDR2IO1_GR10_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A019
>>> -#define OMAP4_LPDDR2IO1_GR10_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x7 << 19)
>>> -#define OMAP4_LPDDR2IO1_GR10_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 17
>>> -#define OMAP4_LPDDR2IO1_GR10_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 17)
>>> -#define OMAP4_LPDDR2IO1_GR9_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_LPDDR2IO1_GR9_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_LPDDR2IO1_GR9_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 11
>>> -#define OMAP4_LPDDR2IO1_GR9_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 11)
>>> -#define OMAP4_LPDDR2IO1_GR9_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A09
>>> -#define OMAP4_LPDDR2IO1_GR9_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 9)
>>> -
>>> -/* CONTROL_LPDDR2IO1_3 */
>>> -#define OMAP4_LPDDR21_VREF_CA_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 31
>>> -#define OMAP4_LPDDR21_VREF_CA_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_LPDDR21_VREF_CA_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 30
>>> -#define OMAP4_LPDDR21_VREF_CA_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_LPDDR21_VREF_CA_INT_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 29
>>> -#define OMAP4_LPDDR21_VREF_CA_INT_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 29)
>>> -#define OMAP4_LPDDR21_VREF_CA_INT_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_LPDDR21_VREF_CA_INT_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_LPDDR21_VREF_CA_INT_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A027
>>> -#define OMAP4_LPDDR21_VREF_CA_INT_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 27)
>>> -#define OMAP4_LPDDR21_VREF_CA_INT_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A026
>>> -#define OMAP4_LPDDR21_VREF_CA_INT_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 26)
>>> -#define OMAP4_LPDDR21_VREF_CA_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A025
>>> -#define OMAP4_LPDDR21_VREF_CA_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 25)
>>> -#define OMAP4_LPDDR21_VREF_CA_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A024
>>> -#define OMAP4_LPDDR21_VREF_CA_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 24)
>>> -#define OMAP4_LPDDR21_VREF_DQ0_INT_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A023
>>> -#define OMAP4_LPDDR21_VREF_DQ0_INT_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 23)
>>> -#define OMAP4_LPDDR21_VREF_DQ0_INT_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A022
>>> -#define OMAP4_LPDDR21_VREF_DQ0_INT_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 22)
>>> -#define OMAP4_LPDDR21_VREF_DQ0_INT_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 21
>>> -#define OMAP4_LPDDR21_VREF_DQ0_INT_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
>>> -#define OMAP4_LPDDR21_VREF_DQ0_INT_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 20
>>> -#define OMAP4_LPDDR21_VREF_DQ0_INT_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 20)
>>> -#define OMAP4_LPDDR21_VREF_DQ1_INT_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A019
>>> -#define OMAP4_LPDDR21_VREF_DQ1_INT_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 19)
>>> -#define OMAP4_LPDDR21_VREF_DQ1_INT_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A018
>>> -#define OMAP4_LPDDR21_VREF_DQ1_INT_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 18)
>>> -#define OMAP4_LPDDR21_VREF_DQ1_INT_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 17
>>> -#define OMAP4_LPDDR21_VREF_DQ1_INT_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 17)
>>> -#define OMAP4_LPDDR21_VREF_DQ1_INT_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_LPDDR21_VREF_DQ1_INT_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
>>> -#define OMAP4_LPDDR21_VREF_DQ_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 15
>>> -#define OMAP4_LPDDR21_VREF_DQ_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 15)
>>> -#define OMAP4_LPDDR21_VREF_DQ_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 14
>>> -#define OMAP4_LPDDR21_VREF_DQ_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 14)
>>> -#define OMAP4_LPDDR21_VREF_DQ_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A013
>>> -#define OMAP4_LPDDR21_VREF_DQ_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 13)
>>> -#define OMAP4_LPDDR21_VREF_DQ_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A012
>>> -#define OMAP4_LPDDR21_VREF_DQ_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 12)
>>> -
>>> -/* CONTROL_LPDDR2IO2_0 */
>>> -#define OMAP4_LPDDR2IO2_GR4_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_LPDDR2IO2_GR4_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 30)
>>> -#define OMAP4_LPDDR2IO2_GR4_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 27
>>> -#define OMAP4_LPDDR2IO2_GR4_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 27)
>>> -#define OMAP4_LPDDR2IO2_GR4_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_LPDDR2IO2_GR4_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 25)
>>> -#define OMAP4_LPDDR2IO2_GR3_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A022
>>> -#define OMAP4_LPDDR2IO2_GR3_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 22)
>>> -#define OMAP4_LPDDR2IO2_GR3_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 19
>>> -#define OMAP4_LPDDR2IO2_GR3_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 19)
>>> -#define OMAP4_LPDDR2IO2_GR3_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017
>>> -#define OMAP4_LPDDR2IO2_GR3_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 17)
>>> -#define OMAP4_LPDDR2IO2_GR2_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_LPDDR2IO2_GR2_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_LPDDR2IO2_GR2_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 11
>>> -#define OMAP4_LPDDR2IO2_GR2_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 11)
>>> -#define OMAP4_LPDDR2IO2_GR2_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A09
>>> -#define OMAP4_LPDDR2IO2_GR2_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 9)
>>> -#define OMAP4_LPDDR2IO2_GR1_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_LPDDR2IO2_GR1_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 6)
>>> -#define OMAP4_LPDDR2IO2_GR1_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 3
>>> -#define OMAP4_LPDDR2IO2_GR1_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 3)
>>> -#define OMAP4_LPDDR2IO2_GR1_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>>> -#define OMAP4_LPDDR2IO2_GR1_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 1)
>>> -
>>> -/* CONTROL_LPDDR2IO2_1 */
>>> -#define OMAP4_LPDDR2IO2_GR8_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A030
>>> -#define OMAP4_LPDDR2IO2_GR8_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 30)
>>> -#define OMAP4_LPDDR2IO2_GR8_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 27
>>> -#define OMAP4_LPDDR2IO2_GR8_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 27)
>>> -#define OMAP4_LPDDR2IO2_GR8_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_LPDDR2IO2_GR8_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 25)
>>> -#define OMAP4_LPDDR2IO2_GR7_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A022
>>> -#define OMAP4_LPDDR2IO2_GR7_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 22)
>>> -#define OMAP4_LPDDR2IO2_GR7_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 19
>>> -#define OMAP4_LPDDR2IO2_GR7_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 19)
>>> -#define OMAP4_LPDDR2IO2_GR7_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017
>>> -#define OMAP4_LPDDR2IO2_GR7_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 17)
>>> -#define OMAP4_LPDDR2IO2_GR6_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_LPDDR2IO2_GR6_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_LPDDR2IO2_GR6_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 11
>>> -#define OMAP4_LPDDR2IO2_GR6_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 11)
>>> -#define OMAP4_LPDDR2IO2_GR6_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A09
>>> -#define OMAP4_LPDDR2IO2_GR6_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 9)
>>> -#define OMAP4_LPDDR2IO2_GR5_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A06
>>> -#define OMAP4_LPDDR2IO2_GR5_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 6)
>>> -#define OMAP4_LPDDR2IO2_GR5_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 3
>>> -#define OMAP4_LPDDR2IO2_GR5_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 3)
>>> -#define OMAP4_LPDDR2IO2_GR5_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>>> -#define OMAP4_LPDDR2IO2_GR5_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 1)
>>> -
>>> -/* CONTROL_LPDDR2IO2_2 */
>>> -#define OMAP4_LPDDR2IO2_GR11_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_LPDDR2IO2_GR11_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_LPDDR2IO2_GR11_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A027
>>> -#define OMAP4_LPDDR2IO2_GR11_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x7 << 27)
>>> -#define OMAP4_LPDDR2IO2_GR11_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 25
>>> -#define OMAP4_LPDDR2IO2_GR11_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 25)
>>> -#define OMAP4_LPDDR2IO2_GR10_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_LPDDR2IO2_GR10_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_LPDDR2IO2_GR10_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A019
>>> -#define OMAP4_LPDDR2IO2_GR10_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x7 << 19)
>>> -#define OMAP4_LPDDR2IO2_GR10_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 17
>>> -#define OMAP4_LPDDR2IO2_GR10_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 17)
>>> -#define OMAP4_LPDDR2IO2_GR9_SR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_LPDDR2IO2_GR9_SR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_LPDDR2IO2_GR9_I_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 11
>>> -#define OMAP4_LPDDR2IO2_GR9_I_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0(0x7 << 11)
>>> -#define OMAP4_LPDDR2IO2_GR9_WD_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A09
>>> -#define OMAP4_LPDDR2IO2_GR9_WD_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 9)
>>> -
>>> -/* CONTROL_LPDDR2IO2_3 */
>>> -#define OMAP4_LPDDR22_VREF_CA_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 31
>>> -#define OMAP4_LPDDR22_VREF_CA_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_LPDDR22_VREF_CA_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 30
>>> -#define OMAP4_LPDDR22_VREF_CA_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_LPDDR22_VREF_CA_INT_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 29
>>> -#define OMAP4_LPDDR22_VREF_CA_INT_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 29)
>>> -#define OMAP4_LPDDR22_VREF_CA_INT_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_LPDDR22_VREF_CA_INT_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_LPDDR22_VREF_CA_INT_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A027
>>> -#define OMAP4_LPDDR22_VREF_CA_INT_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 27)
>>> -#define OMAP4_LPDDR22_VREF_CA_INT_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A026
>>> -#define OMAP4_LPDDR22_VREF_CA_INT_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (1 << 26)
>>> -#define OMAP4_LPDDR22_VREF_CA_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A025
>>> -#define OMAP4_LPDDR22_VREF_CA_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 25)
>>> -#define OMAP4_LPDDR22_VREF_CA_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A024
>>> -#define OMAP4_LPDDR22_VREF_CA_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 24)
>>> -#define OMAP4_LPDDR22_VREF_DQ0_INT_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A023
>>> -#define OMAP4_LPDDR22_VREF_DQ0_INT_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 23)
>>> -#define OMAP4_LPDDR22_VREF_DQ0_INT_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A022
>>> -#define OMAP4_LPDDR22_VREF_DQ0_INT_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 22)
>>> -#define OMAP4_LPDDR22_VREF_DQ0_INT_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 21
>>> -#define OMAP4_LPDDR22_VREF_DQ0_INT_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
>>> -#define OMAP4_LPDDR22_VREF_DQ0_INT_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 20
>>> -#define OMAP4_LPDDR22_VREF_DQ0_INT_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 20)
>>> -#define OMAP4_LPDDR22_VREF_DQ1_INT_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A019
>>> -#define OMAP4_LPDDR22_VREF_DQ1_INT_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 19)
>>> -#define OMAP4_LPDDR22_VREF_DQ1_INT_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A018
>>> -#define OMAP4_LPDDR22_VREF_DQ1_INT_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 18)
>>> -#define OMAP4_LPDDR22_VREF_DQ1_INT_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 17
>>> -#define OMAP4_LPDDR22_VREF_DQ1_INT_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 17)
>>> -#define OMAP4_LPDDR22_VREF_DQ1_INT_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_LPDDR22_VREF_DQ1_INT_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 16)
>>> -#define OMAP4_LPDDR22_VREF_DQ_CCAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 15
>>> -#define OMAP4_LPDDR22_VREF_DQ_CCAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 15)
>>> -#define OMAP4_LPDDR22_VREF_DQ_CCAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 14
>>> -#define OMAP4_LPDDR22_VREF_DQ_CCAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(1 << 14)
>>> -#define OMAP4_LPDDR22_VREF_DQ_TAP0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A013
>>> -#define OMAP4_LPDDR22_VREF_DQ_TAP0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 13)
>>> -#define OMAP4_LPDDR22_VREF_DQ_TAP1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A012
>>> -#define OMAP4_LPDDR22_VREF_DQ_TAP1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 12)
>>> -
>>> -/* CONTROL_BUS_HOLD */
>>> -#define OMAP4_ABE_DMIC_DIN3_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_ABE_DMIC_DIN3_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_MCSPI1_CS3_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 30
>>> -#define OMAP4_MCSPI1_CS3_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -
>>> -/* CONTROL_C2C */
>>> -#define OMAP4_MIRROR_MODE_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A031
>>> -#define OMAP4_MIRROR_MODE_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_C2C_SPARE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_C2C_SPARE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x7f << 24)
>>> -
>>> -/* CORE_CONTROL_SPARE_RW */
>>> -#define OMAP4_CORE_CONTROL_SPARE_RW_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0
>>> -#define OMAP4_CORE_CONTROL_SPARE_RW_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* CORE_CONTROL_SPARE_R */
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xffffffff << 0)
>>> -
>>> -/* CORE_CONTROL_SPARE_R_C0 */
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 31
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 31)
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 30
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 30)
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 29
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 29)
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 28
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 28)
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C4_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 27
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C4_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 27)
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C5_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 26
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C5_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 26)
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C6_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 25
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C6_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 25)
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C7_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 24
>>> -#define OMAP4_CORE_CONTROL_SPARE_R_C7_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 24)
>>> -
>>> -/* CONTROL_EFUSE_1 */
>>> -#define OMAP4_AVDAC_TRIM_BYTE3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A024
>>> -#define OMAP4_AVDAC_TRIM_BYTE3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x7f << 24)
>>> -#define OMAP4_AVDAC_TRIM_BYTE2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
>>> -#define OMAP4_AVDAC_TRIM_BYTE2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 16)
>>> -#define OMAP4_AVDAC_TRIM_BYTE1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_AVDAC_TRIM_BYTE1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 8)
>>> -#define OMAP4_AVDAC_TRIM_BYTE0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_AVDAC_TRIM_BYTE0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 0)
>>> -
>>> -/* CONTROL_EFUSE_2 */
>>> -#define OMAP4_EFUSE_SMART2TEST_P0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 31
>>> -#define OMAP4_EFUSE_SMART2TEST_P0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_EFUSE_SMART2TEST_P1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_EFUSE_SMART2TEST_P1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_EFUSE_SMART2TEST_P2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 29
>>> -#define OMAP4_EFUSE_SMART2TEST_P2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 29)
>>> -#define OMAP4_EFUSE_SMART2TEST_P3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_EFUSE_SMART2TEST_P3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_EFUSE_SMART2TEST_N0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 27
>>> -#define OMAP4_EFUSE_SMART2TEST_N0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 27)
>>> -#define OMAP4_EFUSE_SMART2TEST_N1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 26
>>> -#define OMAP4_EFUSE_SMART2TEST_N1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 26)
>>> -#define OMAP4_EFUSE_SMART2TEST_N2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 25
>>> -#define OMAP4_EFUSE_SMART2TEST_N2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 25)
>>> -#define OMAP4_EFUSE_SMART2TEST_N3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_EFUSE_SMART2TEST_N3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>>> -#define OMAP4_LPDDR2_PTV_N1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 23
>>> -#define OMAP4_LPDDR2_PTV_N1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 23)
>>> -#define OMAP4_LPDDR2_PTV_N2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 22
>>> -#define OMAP4_LPDDR2_PTV_N2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 22)
>>> -#define OMAP4_LPDDR2_PTV_N3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 21
>>> -#define OMAP4_LPDDR2_PTV_N3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 21)
>>> -#define OMAP4_LPDDR2_PTV_N4_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 20
>>> -#define OMAP4_LPDDR2_PTV_N4_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 20)
>>> -#define OMAP4_LPDDR2_PTV_N5_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 19
>>> -#define OMAP4_LPDDR2_PTV_N5_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 19)
>>> -#define OMAP4_LPDDR2_PTV_P1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 18
>>> -#define OMAP4_LPDDR2_PTV_P1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 18)
>>> -#define OMAP4_LPDDR2_PTV_P2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 17
>>> -#define OMAP4_LPDDR2_PTV_P2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 17)
>>> -#define OMAP4_LPDDR2_PTV_P3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 16
>>> -#define OMAP4_LPDDR2_PTV_P3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 16)
>>> -#define OMAP4_LPDDR2_PTV_P4_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 15
>>> -#define OMAP4_LPDDR2_PTV_P4_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 15)
>>> -#define OMAP4_LPDDR2_PTV_P5_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 14
>>> -#define OMAP4_LPDDR2_PTV_P5_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 14)
>>> -
>>> -/* CONTROL_EFUSE_3 */
>>> -#define OMAP4_STD_FUSE_SPARE_1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A024
>>> -#define OMAP4_STD_FUSE_SPARE_1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 24)
>>> -#define OMAP4_STD_FUSE_SPARE_2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
>>> -#define OMAP4_STD_FUSE_SPARE_2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 16)
>>> -#define OMAP4_STD_FUSE_SPARE_3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_STD_FUSE_SPARE_3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 8)
>>> -#define OMAP4_STD_FUSE_SPARE_4_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_STD_FUSE_SPARE_4_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 0)
>>> -
>>> -/* CONTROL_EFUSE_4 */
>>> -#define OMAP4_STD_FUSE_SPARE_5_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A024
>>> -#define OMAP4_STD_FUSE_SPARE_5_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 24)
>>> -#define OMAP4_STD_FUSE_SPARE_6_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
>>> -#define OMAP4_STD_FUSE_SPARE_6_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 16)
>>> -#define OMAP4_STD_FUSE_SPARE_7_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_STD_FUSE_SPARE_7_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 8)
>>> -#define OMAP4_STD_FUSE_SPARE_8_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_STD_FUSE_SPARE_8_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0xff << 0)
>>> -
>>> -#endif
>>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx=
.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h
>>> deleted file mode 100644
>>> index 17c9b37..0000000
>>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_wkup_44xx.h
>>> +++ /dev/null
>>> @@ -1,236 +0,0 @@
>>> -/*
>>> - * OMAP44xx CTRL_MODULE_PAD_WKUP registers and bitfields
>>> - *
>>> - * Copyright (C) 2009-2010 Texas Instruments, Inc.
>>> - *
>>> - * Benoit Cousson (b-cousson@ti.com)
>>> - * Santosh Shilimkar (santosh.shilimkar@ti.com)
>>> - *
>>> - * This file is automatically generated from the OMAP hardware databas=
es.
>>> - * We respectfully ask that any modifications to this file be coordina=
ted
>>> - * with the public linux-omap@vger.kernel.org mailing list and the
>>> - * authors above to ensure that the autogeneration scripts are kept
>>> - * up-to-date with the file contents.
>>> - *
>>> - * This program is free software; you can redistribute it and/or modif=
y
>>> - * it under the terms of the GNU General Public License version 2 as
>>> - * published by the Free Software Foundation.
>>> - */
>>> -
>>> -#ifndef __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_PAD_WKUP_44XX_H
>>> -#define __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_PAD_WKUP_44XX_H
>>> -
>>> -
>>> -/* Base address */
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4a31e000
>>> -
>>> -/* Registers offset */
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_IP_REVISION =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0000
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_IP_HWINFO =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0004
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_IP_SYSCONFIG =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0010
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_PADCONF_WAKEUPEVENT_0 =A0 =A0 =A0 =
=A0 =A0 =A00x007c
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_SMART1NOPMIO_PADCONF_0 =A0 =
0x05a0
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_SMART1NOPMIO_PADCONF_1 =A0 =
0x05a4
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_PADCONF_MODE =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0x05a8
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_XTAL_OSCILLATOR =A0 =A0 =A0=
 =A0 =A00x05ac
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_USIMIO =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 0x0600
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_I2C_2 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00x0604
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_JTAG =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0608
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_CONTROL_SYS =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x060c
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_WKUP_CONTROL_SPARE_RW =A0 =A0 =A0 =
=A0 =A0 =A00x0614
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_WKUP_CONTROL_SPARE_R =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0618
>>> -#define OMAP4_CTRL_MODULE_PAD_WKUP_WKUP_CONTROL_SPARE_R_C0 =A0 =A0 =A0=
 =A0 =A00x061c
>>> -
>>> -/* Registers shifts and masks */
>>> -
>>> -/* IP_REVISION */
>>> -#define OMAP4_IP_REV_SCHEME_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 30
>>> -#define OMAP4_IP_REV_SCHEME_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_IP_REV_FUNC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>>> -#define OMAP4_IP_REV_FUNC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xfff << 16)
>>> -#define OMAP4_IP_REV_RTL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A011
>>> -#define OMAP4_IP_REV_RTL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x1f << 11)
>>> -#define OMAP4_IP_REV_MAJOR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_IP_REV_MAJOR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x7 << 8)
>>> -#define OMAP4_IP_REV_CUSTOM_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 6
>>> -#define OMAP4_IP_REV_CUSTOM_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(0x3 << 6)
>>> -#define OMAP4_IP_REV_MINOR_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_IP_REV_MINOR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3f << 0)
>>> -
>>> -/* IP_HWINFO */
>>> -#define OMAP4_IP_HWINFO_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_IP_HWINFO_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* IP_SYSCONFIG */
>>> -#define OMAP4_IP_SYSCONFIG_IDLEMODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 2
>>> -#define OMAP4_IP_SYSCONFIG_IDLEMODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(0x3 << 2)
>>> -
>>> -/* PADCONF_WAKEUPEVENT_0 */
>>> -#define OMAP4_JTAG_TDO_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
24
>>> -#define OMAP4_JTAG_TDO_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 24)
>>> -#define OMAP4_JTAG_TDI_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
23
>>> -#define OMAP4_JTAG_TDI_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 23)
>>> -#define OMAP4_JTAG_TMS_TMSC_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A022
>>> -#define OMAP4_JTAG_TMS_TMSC_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 22)
>>> -#define OMAP4_JTAG_RTCK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
21
>>> -#define OMAP4_JTAG_RTCK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 21)
>>> -#define OMAP4_JTAG_TCK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
20
>>> -#define OMAP4_JTAG_TCK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0(1 << 20)
>>> -#define OMAP4_JTAG_NTRST_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 19
>>> -#define OMAP4_JTAG_NTRST_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0=
(1 << 19)
>>> -#define OMAP4_SYS_BOOT7_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
18
>>> -#define OMAP4_SYS_BOOT7_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 18)
>>> -#define OMAP4_SYS_BOOT6_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
17
>>> -#define OMAP4_SYS_BOOT6_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 17)
>>> -#define OMAP4_SYS_PWRON_RESET_OUT_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =
=A0 =A016
>>> -#define OMAP4_SYS_PWRON_RESET_OUT_DUPLICATEWAKEUPEVENT_MASK (1 << 16)
>>> -#define OMAP4_SYS_PWR_REQ_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A015
>>> -#define OMAP4_SYS_PWR_REQ_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 15)
>>> -#define OMAP4_SYS_NRESWARM_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 14
>>> -#define OMAP4_SYS_NRESWARM_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(1 << 14)
>>> -#define OMAP4_SYS_32K_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A013
>>> -#define OMAP4_SYS_32K_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 13)
>>> -#define OMAP4_FREF_CLK4_OUT_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A012
>>> -#define OMAP4_FREF_CLK4_OUT_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 12)
>>> -#define OMAP4_FREF_CLK4_REQ_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A011
>>> -#define OMAP4_FREF_CLK4_REQ_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 11)
>>> -#define OMAP4_FREF_CLK3_OUT_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A010
>>> -#define OMAP4_FREF_CLK3_OUT_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 10)
>>> -#define OMAP4_FREF_CLK3_REQ_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A09
>>> -#define OMAP4_FREF_CLK3_REQ_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 9)
>>> -#define OMAP4_FREF_CLK0_OUT_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0=
 =A0 =A0 =A08
>>> -#define OMAP4_FREF_CLK0_OUT_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1 << 8)
>>> -#define OMAP4_FREF_CLK_IOREQ_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =
=A0 =A0 =A0 7
>>> -#define OMAP4_FREF_CLK_IOREQ_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0=
 =A0 =A0 =A0(1 << 7)
>>> -#define OMAP4_SR_SDA_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 6
>>> -#define OMAP4_SR_SDA_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(1 << 6)
>>> -#define OMAP4_SR_SCL_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 5
>>> -#define OMAP4_SR_SCL_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(1 << 5)
>>> -#define OMAP4_SIM_PWRCTRL_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A04
>>> -#define OMAP4_SIM_PWRCTRL_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 (1=
 << 4)
>>> -#define OMAP4_SIM_CD_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 3
>>> -#define OMAP4_SIM_CD_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(1 << 3)
>>> -#define OMAP4_SIM_RESET_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0=
2
>>> -#define OMAP4_SIM_RESET_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
(1 << 2)
>>> -#define OMAP4_SIM_CLK_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A01
>>> -#define OMAP4_SIM_CLK_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 (1 << 1)
>>> -#define OMAP4_SIM_IO_DUPLICATEWAKEUPEVENT_SHIFT =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 0
>>> -#define OMAP4_SIM_IO_DUPLICATEWAKEUPEVENT_MASK =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0(1 << 0)
>>> -
>>> -/* CONTROL_SMART1NOPMIO_PADCONF_0 */
>>> -#define OMAP4_FREF_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_FREF_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_FREF_DR1_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_FREF_DR1_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 28)
>>> -#define OMAP4_FREF_DR4_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26
>>> -#define OMAP4_FREF_DR4_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 26)
>>> -#define OMAP4_FREF_DR5_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_FREF_DR5_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 24)
>>> -#define OMAP4_FREF_DR6_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_FREF_DR6_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_FREF_DR7_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 20
>>> -#define OMAP4_FREF_DR7_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 20)
>>> -#define OMAP4_GPIO_DR7_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 18
>>> -#define OMAP4_GPIO_DR7_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 18)
>>> -#define OMAP4_DPM_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_DPM_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_SIM_DR0_SC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A012
>>> -#define OMAP4_SIM_DR0_SC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 12)
>>> -
>>> -/* CONTROL_SMART1NOPMIO_PADCONF_1 */
>>> -#define OMAP4_FREF_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_FREF_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_FREF_DR1_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_FREF_DR1_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 28)
>>> -#define OMAP4_FREF_DR4_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 26
>>> -#define OMAP4_FREF_DR4_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 26)
>>> -#define OMAP4_FREF_DR5_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_FREF_DR5_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 24)
>>> -#define OMAP4_FREF_DR6_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 22
>>> -#define OMAP4_FREF_DR6_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 22)
>>> -#define OMAP4_FREF_DR7_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 20
>>> -#define OMAP4_FREF_DR7_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 20)
>>> -#define OMAP4_GPIO_DR7_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 18
>>> -#define OMAP4_GPIO_DR7_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 18)
>>> -#define OMAP4_DPM_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A014
>>> -#define OMAP4_DPM_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 14)
>>> -#define OMAP4_SIM_DR0_LB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A012
>>> -#define OMAP4_SIM_DR0_LB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0x3 << 12)
>>> -
>>> -/* CONTROL_PADCONF_MODE */
>>> -#define OMAP4_VDDS_DV_FREF_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_VDDS_DV_FREF_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_VDDS_DV_BANK2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 30
>>> -#define OMAP4_VDDS_DV_BANK2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -
>>> -/* CONTROL_XTAL_OSCILLATOR */
>>> -#define OMAP4_OSCILLATOR_BOOST_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_OSCILLATOR_BOOST_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_OSCILLATOR_OS_OUT_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_OSCILLATOR_OS_OUT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -
>>> -/* CONTROL_USIMIO */
>>> -#define OMAP4_PAD_USIM_CLK_LOW_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A031
>>> -#define OMAP4_PAD_USIM_CLK_LOW_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 31)
>>> -#define OMAP4_PAD_USIM_RST_LOW_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_PAD_USIM_RST_LOW_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (1 << 29)
>>> -#define OMAP4_USIM_PWRDNZ_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_USIM_PWRDNZ_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -
>>> -/* CONTROL_I2C_2 */
>>> -#define OMAP4_SR_SDA_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 31
>>> -#define OMAP4_SR_SDA_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_SR_SDA_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_SR_SDA_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 29)
>>> -#define OMAP4_SR_SDA_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_SR_SDA_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_SR_SCL_GLFENB_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 27
>>> -#define OMAP4_SR_SCL_GLFENB_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 27)
>>> -#define OMAP4_SR_SCL_LOAD_BITS_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A025
>>> -#define OMAP4_SR_SCL_LOAD_BITS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 (0x3 << 25)
>>> -#define OMAP4_SR_SCL_PULLUPRESX_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 24
>>> -#define OMAP4_SR_SCL_PULLUPRESX_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 24)
>>> -
>>> -/* CONTROL_JTAG */
>>> -#define OMAP4_JTAG_NTRST_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 31
>>> -#define OMAP4_JTAG_NTRST_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -#define OMAP4_JTAG_TCK_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_JTAG_TCK_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 30)
>>> -#define OMAP4_JTAG_RTCK_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A029
>>> -#define OMAP4_JTAG_RTCK_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 29)
>>> -#define OMAP4_JTAG_TDI_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 28
>>> -#define OMAP4_JTAG_TDI_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 28)
>>> -#define OMAP4_JTAG_TDO_EN_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 27
>>> -#define OMAP4_JTAG_TDO_EN_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 27)
>>> -
>>> -/* CONTROL_SYS */
>>> -#define OMAP4_SYS_NRESWARM_PIPU_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 31
>>> -#define OMAP4_SYS_NRESWARM_PIPU_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 31)
>>> -
>>> -/* WKUP_CONTROL_SPARE_RW */
>>> -#define OMAP4_WKUP_CONTROL_SPARE_RW_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0
>>> -#define OMAP4_WKUP_CONTROL_SPARE_RW_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0(0xffffffff << 0)
>>> -
>>> -/* WKUP_CONTROL_SPARE_R */
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 (0xffffffff << 0)
>>> -
>>> -/* WKUP_CONTROL_SPARE_R_C0 */
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C0_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 31
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C0_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 31)
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C1_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 30
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C1_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 30)
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C2_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 29
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C2_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 29)
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C3_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 28
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C3_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 28)
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C4_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 27
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C4_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 27)
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C5_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 26
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C5_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 26)
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C6_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 25
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C6_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 25)
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C7_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 24
>>> -#define OMAP4_WKUP_CONTROL_SPARE_R_C7_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(1 << 24)
>>> -
>>> -#endif
>>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h b=
/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>> deleted file mode 100644
>>> index a0af9ba..0000000
>>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>> +++ /dev/null
>>> @@ -1,92 +0,0 @@
>>> -/*
>>> - * OMAP44xx CTRL_MODULE_WKUP registers and bitfields
>>> - *
>>> - * Copyright (C) 2009-2010 Texas Instruments, Inc.
>>> - *
>>> - * Benoit Cousson (b-cousson@ti.com)
>>> - * Santosh Shilimkar (santosh.shilimkar@ti.com)
>>> - *
>>> - * This file is automatically generated from the OMAP hardware databas=
es.
>>> - * We respectfully ask that any modifications to this file be coordina=
ted
>>> - * with the public linux-omap@vger.kernel.org mailing list and the
>>> - * authors above to ensure that the autogeneration scripts are kept
>>> - * up-to-date with the file contents.
>>> - *
>>> - * This program is free software; you can redistribute it and/or modif=
y
>>> - * it under the terms of the GNU General Public License version 2 as
>>> - * published by the Free Software Foundation.
>>> - */
>>> -
>>> -#ifndef __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_WKUP_44XX_H
>>> -#define __ARCH_ARM_MACH_OMAP2_CTRL_MODULE_WKUP_44XX_H
>>> -
>>> -
>>> -/* Base address */
>>> -#define OMAP4_CTRL_MODULE_WKUP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A00x4a30c000
>>> -
>>> -/* Registers offset */
>>> -#define OMAP4_CTRL_MODULE_WKUP_IP_REVISION =A0 =A0 =A0 =A0 =A00x0000
>>> -#define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO =A0 =A0 =A0 =A0 =A0 =A00x0004
>>> -#define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG =A0 =A0 =A0 =A0 0x0010
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0 0x0460
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1 0x0464
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2 0x0468
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_3 0x046c
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_4 0x0470
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_5 0x0474
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_6 0x0478
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_7 0x047c
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_8 0x0480
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_9 0x0484
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_10 =A0 =A0 =A0 =A00x=
0488
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_11 =A0 =A0 =A0 =A00x=
048c
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_12 =A0 =A0 =A0 =A00x=
0490
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_13 =A0 =A0 =A0 =A00x=
0494
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_14 =A0 =A0 =A0 =A00x=
0498
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_15 =A0 =A0 =A0 =A00x=
049c
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_16 =A0 =A0 =A0 =A00x=
04a0
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_17 =A0 =A0 =A0 =A00x=
04a4
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_18 =A0 =A0 =A0 =A00x=
04a8
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_19 =A0 =A0 =A0 =A00x=
04ac
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_20 =A0 =A0 =A0 =A00x=
04b0
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_21 =A0 =A0 =A0 =A00x=
04b4
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_22 =A0 =A0 =A0 =A00x=
04b8
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_23 =A0 =A0 =A0 =A00x=
04bc
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_24 =A0 =A0 =A0 =A00x=
04c0
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_25 =A0 =A0 =A0 =A00x=
04c4
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_26 =A0 =A0 =A0 =A00x=
04c8
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_27 =A0 =A0 =A0 =A00x=
04cc
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_28 =A0 =A0 =A0 =A00x=
04d0
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_29 =A0 =A0 =A0 =A00x=
04d4
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_30 =A0 =A0 =A0 =A00x=
04d8
>>> -#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_31 =A0 =A0 =A0 =A00x=
04dc
>>> -
>>> -/* Registers shifts and masks */
>>> -
>>> -/* IP_REVISION */
>>> -#define OMAP4_IP_REV_SCHEME_SHIFT =A0 =A0 =A0 =A0 =A0 30
>>> -#define OMAP4_IP_REV_SCHEME_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 30)
>>> -#define OMAP4_IP_REV_FUNC_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 16
>>> -#define OMAP4_IP_REV_FUNC_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0xfff << 16)
>>> -#define OMAP4_IP_REV_RTL_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A011
>>> -#define OMAP4_IP_REV_RTL_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1f << 11)
>>> -#define OMAP4_IP_REV_MAJOR_SHIFT =A0 =A0 =A0 =A0 =A0 =A08
>>> -#define OMAP4_IP_REV_MAJOR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x7 << 8)
>>> -#define OMAP4_IP_REV_CUSTOM_SHIFT =A0 =A0 =A0 =A0 =A0 6
>>> -#define OMAP4_IP_REV_CUSTOM_MASK =A0 =A0 =A0 =A0 =A0 =A0(0x3 << 6)
>>> -#define OMAP4_IP_REV_MINOR_SHIFT =A0 =A0 =A0 =A0 =A0 =A00
>>> -#define OMAP4_IP_REV_MINOR_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x3f << 0)
>>> -
>>> -/* IP_HWINFO */
>>> -#define OMAP4_IP_HWINFO_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0
>>> -#define OMAP4_IP_HWINFO_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(0xffffffff << 0)
>>> -
>>> -/* IP_SYSCONFIG */
>>> -#define OMAP4_IP_SYSCONFIG_IDLEMODE_SHIFT =A0 2
>>> -#define OMAP4_IP_SYSCONFIG_IDLEMODE_MASK =A0 =A0(0x3 << 2)
>>> -
>>> -/* CONF_DEBUG_SEL_TST_0 */
>>> -#define OMAP4_WKUP_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 0
>>> -#define OMAP4_WKUP_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>>> -
>>> -#endif
>>> --
>>> 1.7.7.6
>>>
>>>
>



--=20

Eduardo Valentin
