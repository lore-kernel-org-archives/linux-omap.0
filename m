From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 15/19] ARM: OMAP4430: PM: workaround for DDR corruption on
 second CS
Date: Thu, 26 Apr 2012 11:49:43 +0530
Message-ID: <CAMQu2gwEuKGtcrP4x-JU3NH906QKvScRwO7vDtrghErKaaF0HA@mail.gmail.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-16-git-send-email-t-kristo@ti.com> <4F96EF56.5020604@ti.com>
 <1335338762.2149.103.camel@sokoban> <4F981536.2030609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37884 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751985Ab2DZGUG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Apr 2012 02:20:06 -0400
Received: by qcsk26 with SMTP id k26so560972qcs.40
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 23:20:04 -0700 (PDT)
In-Reply-To: <4F981536.2030609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Wed, Apr 25, 2012 at 8:46 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> Hi Tero,
>
> On 04/25/2012 02:26 AM, Tero Kristo wrote:
>> On Tue, 2012-04-24 at 13:22 -0500, Jon Hunter wrote:
>>> Hi Tero,
>>>
>>> On 04/20/2012 04:33 AM, Tero Kristo wrote:
>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>
>>>> Work around for Errata ID: i632 "LPDDR2 Corruption After OFF Mode
>>>> Transition When CS1 Is Used On EMIF" which impacts OMAP443x silico=
n
>>>> The issue occurs when EMIF_SDRAM_CONFIG is restored first before
>>>> EMIF_SDRAM_CONFIG_2 is not yet restored, the register configuratio=
n
>>>> is not set properly, we apply the required workaround allowing
>>>> the restore sequence to work properly.
>>>>
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> [t-kristo@ti.com: moved workaround from omap-sar.c to pm44xx.c]
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> ---
>>>> =A0.../include/mach/ctrl_module_wkup_44xx.h =A0 =A0 =A0 =A0 =A0 | =
=A0 =A02 +
>>>> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 24 ++++++++++++++++++++
>>>> =A02 files changed, 26 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44x=
x.h b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>>> index a0af9ba..b763a79 100644
>>>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>>> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>>> @@ -28,6 +28,8 @@
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_REVISION =A0 =A0 =A0 =A0 0x00=
00
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO =A0 =A0 =A0 =A0 =A0 0x=
0004
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x0010
>>>> +#define OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG =A00x0114
>>>> +#define OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG =A00x011c
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0 =A0 =A0 =A0=
 =A00x0460
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1 =A0 =A0 =A0=
 =A00x0464
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2 =A0 =A0 =A0=
 =A00x0468
>>>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm=
44xx.c
>>>> index 0472921..d4d18d9 100644
>>>> --- a/arch/arm/mach-omap2/pm44xx.c
>>>> +++ b/arch/arm/mach-omap2/pm44xx.c
>>>> @@ -17,6 +17,9 @@
>>>> =A0#include <linux/err.h>
>>>> =A0#include <linux/slab.h>
>>>> =A0#include <asm/system_misc.h>
>>>> +#include <linux/io.h>
>>>> +
>>>> +#include <mach/ctrl_module_wkup_44xx.h>
>>>>
>>>> =A0#include "common.h"
>>>> =A0#include "clockdomain.h"
>>>> @@ -215,6 +218,27 @@ static int __init omap4_pm_init(void)
>>>>
>>>> =A0 =A0 pr_err("Power Management for TI OMAP4.\n");
>>>>
>>>> + =A0 /*
>>>> + =A0 =A0* Work around for OMAP443x Errata i632: "LPDDR2 Corruptio=
n After OFF
>>>> + =A0 =A0* Mode Transition When CS1 Is Used On EMIF":
>>>> + =A0 =A0* Overwrite EMIF1/EMIF2
>>>> + =A0 =A0* SECURE_EMIF1_SDRAM_CONFIG2_REG
>>>> + =A0 =A0* SECURE_EMIF2_SDRAM_CONFIG2_REG
>>>> + =A0 =A0*/
>>>> + =A0 if (cpu_is_omap443x()) {
>>>> + =A0 =A0 =A0 =A0 =A0 void __iomem *secure_ctrl_mod;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 secure_ctrl_mod =3D ioremap(OMAP4_CTRL_MODUL=
E_WKUP, SZ_4K);
>>>> + =A0 =A0 =A0 =A0 =A0 BUG_ON(!secure_ctrl_mod);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 __raw_writel(0x10, secure_ctrl_mod +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_CTRL_SECURE=
_EMIF1_SDRAM_CONFIG2_REG);
>>>> + =A0 =A0 =A0 =A0 =A0 __raw_writel(0x10, secure_ctrl_mod +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_CTRL_SECURE=
_EMIF2_SDRAM_CONFIG2_REG);
>>>
>>> According to the erratum description the above registers are used t=
o
>>> restore the EMIFx_SDRAM_CONFIG2 registers. So although the value 0x=
10,
>>> maybe the value being used for EMIFx_SDRAM_CONFIG2 registers, shoul=
dn't
>>> we read the EMIFx_SDRAM_CONFIG2 registers and store them in the abo=
ve
>>> registers?
>>
>> This might be a good idea, however, this patch might be tagged as TE=
MP
>> until the EMIF driver is in place, this fix should rather be located
>> there. I'll take a look at this if I can change the implementation a
>> bit.
>
> By the way, I did dump the EMIF1_SDRAM_CONFIG2 register on a omap4403
> and it is configured to 0x10. So I think that reading this register a=
nd
> saving would be safe.
>
That's right. The reason it is harcoded is, it will be 0x10 or 0x0. Wri=
ting 0x10
even of we use 1 chip select doesn't create any issue as such.

But go ahead and read the register and store it. That way it will
appear bit cleaner.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
