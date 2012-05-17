From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 15/19] ARM: OMAP4430: PM: workaround for DDR corruption on second CS
Date: Thu, 17 May 2012 09:47:06 -0700
Message-ID: <87vcjuzred.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-16-git-send-email-t-kristo@ti.com>
	<87mx573boy.fsf@ti.com>
	<CAMQu2gzOeX3W1HouzVHf7uvMHtdTp7=E22fk6Uq81sxcdM5nxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:51378 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758930Ab2EQQrJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 12:47:09 -0400
Received: by pbbrp8 with SMTP id rp8so3874086pbb.33
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 09:47:07 -0700 (PDT)
In-Reply-To: <CAMQu2gzOeX3W1HouzVHf7uvMHtdTp7=E22fk6Uq81sxcdM5nxg@mail.gmail.com>
	(Santosh Shilimkar's message of "Thu, 17 May 2012 12:42:30 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Thu, May 17, 2012 at 5:45 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> Work around for Errata ID: i632 "LPDDR2 Corruption After OFF Mode
>>> Transition When CS1 Is Used On EMIF" which impacts OMAP443x silicon
>>> The issue occurs when EMIF_SDRAM_CONFIG is restored first before
>>> EMIF_SDRAM_CONFIG_2 is not yet restored, the register configuration
>>> is not set properly, we apply the required workaround allowing
>>> the restore sequence to work properly.
>>
>> Please summarize the workaround here as well.
>>
> ok
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> [t-kristo@ti.com: moved workaround from omap-sar.c to pm44xx.c]
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>> =C2=A0.../include/mach/ctrl_module_wkup_44xx.h =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +
>>> =C2=A0arch/arm/mach-omap2/pm44xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 37 ++++++++++++++++=
++++
>>> =C2=A02 files changed, 39 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx=
=2Eh b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>> index a0af9ba..b763a79 100644
>>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>> @@ -28,6 +28,8 @@
>>> =C2=A0#define OMAP4_CTRL_MODULE_WKUP_IP_REVISION =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 0x0000
>>> =C2=A0#define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 0x0004
>>> =C2=A0#define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x0010
>>> +#define OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG =C2=A0 =C2=A00x0=
114
>>> +#define OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG =C2=A0 =C2=A00x0=
11c
>>> =C2=A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0 =C2=A00x0=
460
>>> =C2=A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1 =C2=A00x0=
464
>>> =C2=A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2 =C2=A00x0=
468
>>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm4=
4xx.c
>>> index 215b80e..dfaa254 100644
>>> --- a/arch/arm/mach-omap2/pm44xx.c
>>> +++ b/arch/arm/mach-omap2/pm44xx.c
>>> @@ -17,12 +17,18 @@
>>> =C2=A0#include <linux/err.h>
>>> =C2=A0#include <linux/slab.h>
>>> =C2=A0#include <asm/system_misc.h>
>>> +#include <linux/io.h>
>>> +
>>> +#include <mach/ctrl_module_wkup_44xx.h>
>>> +#include <mach/hardware.h>
>>>
>>> =C2=A0#include "common.h"
>>> =C2=A0#include "clockdomain.h"
>>> =C2=A0#include "powerdomain.h"
>>> =C2=A0#include "pm.h"
>>>
>>> +#define EMIF_SDRAM_CONFIG2_OFFSET =C2=A0 =C2=A00xc
>>> +
>>> =C2=A0struct power_state {
>>> =C2=A0 =C2=A0 =C2=A0 struct powerdomain *pwrdm;
>>> =C2=A0 =C2=A0 =C2=A0 u32 next_state;
>>> @@ -215,6 +221,37 @@ static int __init omap4_pm_init(void)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 pr_err("Power Management for TI OMAP4.\n");
>>>
>>> + =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0* Work around for OMAP443x Errata i632: "LPDD=
R2 Corruption After OFF
>>> + =C2=A0 =C2=A0 =C2=A0* Mode Transition When CS1 Is Used On EMIF":
>>> + =C2=A0 =C2=A0 =C2=A0* Overwrite EMIF1/EMIF2
>>> + =C2=A0 =C2=A0 =C2=A0* SECURE_EMIF1_SDRAM_CONFIG2_REG
>>> + =C2=A0 =C2=A0 =C2=A0* SECURE_EMIF2_SDRAM_CONFIG2_REG
>>> + =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 if (cpu_is_omap443x()) {
>>
>> This should probably be done later in this function, after PM_ERRATU=
M
>> flags are setup, and then it should use a PM_ERRATUM flag instead of=
 cpu_is*
>>
> ok
>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *secure_ct=
rl_mod;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *emif1;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void __iomem *emif2;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 val;
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 secure_ctrl_mod =3D ior=
emap(OMAP4_CTRL_MODULE_WKUP, SZ_4K);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emif1 =3D ioremap(OMAP4=
4XX_EMIF1_BASE, SZ_1M);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 emif2 =3D ioremap(OMAP4=
4XX_EMIF2_BASE, SZ_1M);
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG_ON(!secure_ctrl_mod=
 || !emif1 || !emif2);
>>
>> Please avoid BUG_ON() and use proper error recovery. =C2=A0This is n=
ot a
>> condition where the entire kernel should panic.
>>
> Agree. WARN_ON() should suffice.

A WARN_ON() is ok (but noisy).  Better is a pr_warn() with some proper
error recovery.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
