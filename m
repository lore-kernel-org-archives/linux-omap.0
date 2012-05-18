From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv2 15/19] ARM: OMAP4430: PM: workaround for DDR corruption
 on second CS
Date: Fri, 18 May 2012 11:25:38 +0530
Message-ID: <CAMQu2gwUypAN_v7NFOCz=dB=doftjgbFqmm1WJFAHBG5iH=2tg@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-16-git-send-email-t-kristo@ti.com> <87mx573boy.fsf@ti.com>
 <CAMQu2gzOeX3W1HouzVHf7uvMHtdTp7=E22fk6Uq81sxcdM5nxg@mail.gmail.com>
 <87vcjuzred.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87vcjuzred.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 17, 2012 at 10:17 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:
>
>> On Thu, May 17, 2012 at 5:45 AM, Kevin Hilman <khilman@ti.com> wrote:
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>
>>>> Work around for Errata ID: i632 "LPDDR2 Corruption After OFF Mode
>>>> Transition When CS1 Is Used On EMIF" which impacts OMAP443x silicon
>>>> The issue occurs when EMIF_SDRAM_CONFIG is restored first before
>>>> EMIF_SDRAM_CONFIG_2 is not yet restored, the register configuration
>>>> is not set properly, we apply the required workaround allowing
>>>> the restore sequence to work properly.
>>>
>>> Please summarize the workaround here as well.
>>>
>> ok
>>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> [t-kristo@ti.com: moved workaround from omap-sar.c to pm44xx.c]
>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>> ---
>>>> =A0.../include/mach/ctrl_module_wkup_44xx.h =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +
>>>> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 37 ++++++++++++++++++++
>>>> =A02 files changed, 39 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h =
b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>>> index a0af9ba..b763a79 100644
>>>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>>> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_wkup_44xx.h
>>>> @@ -28,6 +28,8 @@
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_REVISION =A0 =A0 =A0 =A0 =A0 0x00=
00
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_HWINFO =A0 =A0 =A0 =A0 =A0 =A0 0x=
0004
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_IP_SYSCONFIG =A0 =A0 =A0 =A0 =A00x00=
10
>>>> +#define OMAP4_CTRL_SECURE_EMIF1_SDRAM_CONFIG2_REG =A0 =A00x0114
>>>> +#define OMAP4_CTRL_SECURE_EMIF2_SDRAM_CONFIG2_REG =A0 =A00x011c
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_0 =A00x0460
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_1 =A00x0464
>>>> =A0#define OMAP4_CTRL_MODULE_WKUP_CONF_DEBUG_SEL_TST_2 =A00x0468
>>>> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx=
.c
>>>> index 215b80e..dfaa254 100644
>>>> --- a/arch/arm/mach-omap2/pm44xx.c
>>>> +++ b/arch/arm/mach-omap2/pm44xx.c
>>>> @@ -17,12 +17,18 @@
>>>> =A0#include <linux/err.h>
>>>> =A0#include <linux/slab.h>
>>>> =A0#include <asm/system_misc.h>
>>>> +#include <linux/io.h>
>>>> +
>>>> +#include <mach/ctrl_module_wkup_44xx.h>
>>>> +#include <mach/hardware.h>
>>>>
>>>> =A0#include "common.h"
>>>> =A0#include "clockdomain.h"
>>>> =A0#include "powerdomain.h"
>>>> =A0#include "pm.h"
>>>>
>>>> +#define EMIF_SDRAM_CONFIG2_OFFSET =A0 =A00xc
>>>> +
>>>> =A0struct power_state {
>>>> =A0 =A0 =A0 struct powerdomain *pwrdm;
>>>> =A0 =A0 =A0 u32 next_state;
>>>> @@ -215,6 +221,37 @@ static int __init omap4_pm_init(void)
>>>>
>>>> =A0 =A0 =A0 pr_err("Power Management for TI OMAP4.\n");
>>>>
>>>> + =A0 =A0 /*
>>>> + =A0 =A0 =A0* Work around for OMAP443x Errata i632: "LPDDR2 Corruptio=
n After OFF
>>>> + =A0 =A0 =A0* Mode Transition When CS1 Is Used On EMIF":
>>>> + =A0 =A0 =A0* Overwrite EMIF1/EMIF2
>>>> + =A0 =A0 =A0* SECURE_EMIF1_SDRAM_CONFIG2_REG
>>>> + =A0 =A0 =A0* SECURE_EMIF2_SDRAM_CONFIG2_REG
>>>> + =A0 =A0 =A0*/
>>>> + =A0 =A0 if (cpu_is_omap443x()) {
>>>
>>> This should probably be done later in this function, after PM_ERRATUM
>>> flags are setup, and then it should use a PM_ERRATUM flag instead of cp=
u_is*
>>>
>> ok
>>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *secure_ctrl_mod;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *emif1;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *emif2;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 u32 val;
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 secure_ctrl_mod =3D ioremap(OMAP4_CTRL_MODUL=
E_WKUP, SZ_4K);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 emif1 =3D ioremap(OMAP44XX_EMIF1_BASE, SZ_1M=
);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 emif2 =3D ioremap(OMAP44XX_EMIF2_BASE, SZ_1M=
);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(!secure_ctrl_mod || !emif1 || !emif2);
>>>
>>> Please avoid BUG_ON() and use proper error recovery. =A0This is not a
>>> condition where the entire kernel should panic.
>>>
>> Agree. WARN_ON() should suffice.
>
> A WARN_ON() is ok (but noisy). =A0Better is a pr_warn() with some proper
> error recovery.
>
OK
