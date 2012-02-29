From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
Date: Wed, 29 Feb 2012 15:17:59 -0600
Message-ID: <CAMXH7KFHdh=bsJizq1MBUi7L0x1U4Tgr=DR2G_ZkyuKonnTJ0A@mail.gmail.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
	<1330485109-7327-2-git-send-email-rob.lee@linaro.org>
	<87obsheazt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87obsheazt.fsf@ti.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: len.brown@intel.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 29, 2012 at 12:43 PM, Kevin Hilman <khilman@ti.com> wrote:
> Robert Lee <rob.lee@linaro.org> writes:
>
>> Make necessary changes to implement time keeping and irq enabling
>> in the core cpuidle code. =A0This will allow the removal of these
>> functionalities from various platform cpuidle implementations whose
>> timekeeping and irq enabling follows the form in this common code.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> ---
>> =A0arch/arm/include/asm/cpuidle.h | =A0 14 ++++++
>> =A0drivers/cpuidle/cpuidle.c =A0 =A0 =A0| =A0 90 +++++++++++++++++++=
+++++++++++++--------
>> =A0include/linux/cpuidle.h =A0 =A0 =A0 =A0| =A0 13 ++++++
>> =A03 files changed, 99 insertions(+), 18 deletions(-)
>> =A0create mode 100644 arch/arm/include/asm/cpuidle.h
>>
>> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/c=
puidle.h
>> new file mode 100644
>> index 0000000..1d2075b
>> --- /dev/null
>> +++ b/arch/arm/include/asm/cpuidle.h
>> @@ -0,0 +1,14 @@
>> +#ifndef __ASM_ARM_CPUIDLE_H
>> +#define __ASM_ARM_CPUIDLE_H
>> +
>> +/* Common ARM WFI state */
>> +#define CPUIDLE_ARM_WFI_STATE {\
>> + =A0 =A0 .enter =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D cpuidle_simp=
le_enter,\
>> + =A0 =A0 .exit_latency =A0 =A0 =A0 =A0 =A0 =3D 1,\
>> + =A0 =A0 .target_residency =A0 =A0 =A0 =3D 1,\
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D CPUIDLE_FLAG=
_TIME_VALID,\
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "WFI",\
>> + =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "ARM core cl=
ock gating (WFI)",\
>> +}
>
> nit: just name this ARM WFI. =A0Clock gating is platform specific, an=
d
> "core" has platform-specific meanings, so in order to keep this truly
> generic, I think hat ARM WFI is the best name.
>

Agree.  I'll make that change.

> Kevin
>
>
