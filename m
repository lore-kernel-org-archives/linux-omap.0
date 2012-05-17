From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 15/19] ARM: OMAP4430: PM: workaround for DDR corruption
 on second CS
Date: Thu, 17 May 2012 12:42:30 +0530
Message-ID: <CAMQu2gzOeX3W1HouzVHf7uvMHtdTp7=E22fk6Uq81sxcdM5nxg@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-16-git-send-email-t-kristo@ti.com> <87mx573boy.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54626 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759685Ab2EQHMx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 03:12:53 -0400
Received: by qabj40 with SMTP id j40so1456292qab.8
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 00:12:51 -0700 (PDT)
In-Reply-To: <87mx573boy.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Thu, May 17, 2012 at 5:45 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Work around for Errata ID: i632 "LPDDR2 Corruption After OFF Mode
>> Transition When CS1 Is Used On EMIF" which impacts OMAP443x silicon
>> The issue occurs when EMIF_SDRAM_CONFIG is restored first before
>> EMIF_SDRAM_CONFIG_2 is not yet restored, the register configuration
>> is not set properly, we apply the required workaround allowing
>> the restore sequence to work properly.
>
> Please summarize the workaround here as well.
>
ok
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> [t-kristo@ti.com: moved workaround from omap-sar.c to pm44xx.c]
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>> =A0.../include/mach/ctrl_module_wkup_44xx.h =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +
>> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 37 ++++++++++++++++++++
>> =A02 files changed, 39 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.=
h b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>> index a0af9ba..b763a79 100644
>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>> @@ -28,6 +28,8 @@
>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_REVISION =A0 =A0 =A0 =A0 =A0 0x=
0000
>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO =A0 =A0 =A0 =A0 =A0 =A0 =
0x0004
>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG =A0 =A0 =A0 =A0 =A00x=
0010
>> +#define OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG =A0 =A00x0114
>> +#define OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG =A0 =A00x011c
>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0 =A00x0460
>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1 =A00x0464
>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2 =A00x0468
>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44=
xx.c
>> index 215b80e..dfaa254 100644
>> --- a/arch/arm/mach-omap2/pm44xx.c
>> +++ b/arch/arm/mach-omap2/pm44xx.c
>> @@ -17,12 +17,18 @@
>> =A0#include <linux/err.h>
>> =A0#include <linux/slab.h>
>> =A0#include <asm/system_misc.h>
>> +#include <linux/io.h>
>> +
>> +#include <mach/ctrl_module_wkup_44xx.h>
>> +#include <mach/hardware.h>
>>
>> =A0#include "common.h"
>> =A0#include "clockdomain.h"
>> =A0#include "powerdomain.h"
>> =A0#include "pm.h"
>>
>> +#define EMIF_SDRAM_CONFIG2_OFFSET =A0 =A00xc
>> +
>> =A0struct power_state {
>> =A0 =A0 =A0 struct powerdomain *pwrdm;
>> =A0 =A0 =A0 u32 next_state;
>> @@ -215,6 +221,37 @@ static int __init omap4_pm_init(void)
>>
>> =A0 =A0 =A0 pr_err("Power Management for TI OMAP4.\n");
>>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Work around for OMAP443x Errata i632: "LPDDR2 Corrupt=
ion After OFF
>> + =A0 =A0 =A0* Mode Transition When CS1 Is Used On EMIF":
>> + =A0 =A0 =A0* Overwrite EMIF1/EMIF2
>> + =A0 =A0 =A0* SECURE_EMIF1_SDRAM_CONFIG2_REG
>> + =A0 =A0 =A0* SECURE_EMIF2_SDRAM_CONFIG2_REG
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (cpu_is_omap443x()) {
>
> This should probably be done later in this function, after PM_ERRATUM
> flags are setup, and then it should use a PM_ERRATUM flag instead of =
cpu_is*
>
ok

>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *secure_ctrl_mod;
>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *emif1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *emif2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 val;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 secure_ctrl_mod =3D ioremap(OMAP4_CTRL_MOD=
ULE_WKUP, SZ_4K);
>> + =A0 =A0 =A0 =A0 =A0 =A0 emif1 =3D ioremap(OMAP44XX_EMIF1_BASE, SZ_=
1M);
>> + =A0 =A0 =A0 =A0 =A0 =A0 emif2 =3D ioremap(OMAP44XX_EMIF2_BASE, SZ_=
1M);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(!secure_ctrl_mod || !emif1 || !emif=
2);
>
> Please avoid BUG_ON() and use proper error recovery. =A0This is not a
> condition where the entire kernel should panic.
>
Agree. WARN_ON() should suffice.

Regards
santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
