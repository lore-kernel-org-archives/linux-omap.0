From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/6] ARM: OMAP2+: PM: protect the power domain state
 change by a mutex
Date: Tue, 8 May 2012 10:28:55 +0200
Message-ID: <CAORVsuUQgz4xdG0t2n1+CX=m_=2_Uzyg6D6kEf5MqcG05zmQJA@mail.gmail.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com>
	<1334752782-28804-2-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1205070033490.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:64366 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab2EHI24 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 04:28:56 -0400
Received: by vbbff1 with SMTP id ff1so1668681vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 01:28:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205070033490.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi Paul,

Thanks for the review. Do you plan to review the full set before I
start to address the comments.

On Mon, May 7, 2012 at 8:41 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Wed, 18 Apr 2012, jean.pihet@newoldbits.com wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> This patch is missing a description, which would describe why this lo=
ck is
> needed and what it protects against. =A0Please add this.
Ok

>
>> ---
>> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0| =A0 =A08 ++++++--
>> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A01 +
>> =A0arch/arm/mach-omap2/powerdomain.h | =A0 =A03 ++-
>> =A03 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
>> index d0c1c96..6918a13 100644
>> --- a/arch/arm/mach-omap2/pm.c
>> +++ b/arch/arm/mach-omap2/pm.c
>> @@ -100,15 +100,17 @@ int omap_set_pwrdm_state(struct powerdomain *p=
wrdm, u32 pwrst)
>> =A0 =A0 =A0 if (!pwrdm || IS_ERR(pwrdm))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>
>> + =A0 =A0 mutex_lock(&pwrdm->lock);
>> +
>> =A0 =A0 =A0 while (!(pwrdm->pwrsts & (1 << pwrst))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrst =3D=3D PWRDM_POWER_OFF)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst--;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);
>> =A0 =A0 =A0 if (next_pwrst =3D=3D pwrst)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> =A0 =A0 =A0 curr_pwrst =3D pwrdm_read_pwrst(pwrdm);
>> =A0 =A0 =A0 if (curr_pwrst < PWRDM_POWER_ON) {
>> @@ -141,6 +143,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwr=
dm, u32 pwrst)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>>
>> +out:
>> + =A0 =A0 mutex_unlock(&pwrdm->lock);
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>
> So this mutex would protect against simultaneous calls to
> omap_set_pwrdm_state(), but shouldn't this protection be extended to
> anything that would change the powerdomain's state? =A0For example, c=
ouldn't
> other calls to pwrdm_set_next_pwrst() race against this function?
The intention behind this patch set is to change the API to only use
omap_set_pwrdm_state to change the power domains states. Probably I
should emphasize more on that in the cover letter and commits
description.

>
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2=
/powerdomain.c
>> index 96ad3dbe..319b277 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -102,6 +102,7 @@ static int _pwrdm_register(struct powerdomain *p=
wrdm)
>> =A0 =A0 =A0 INIT_LIST_HEAD(&pwrdm->voltdm_node);
>> =A0 =A0 =A0 voltdm_add_pwrdm(voltdm, pwrdm);
>>
>> + =A0 =A0 mutex_init(&pwrdm->lock);
>> =A0 =A0 =A0 list_add(&pwrdm->node, &pwrdm_list);
>>
>> =A0 =A0 =A0 /* Initialize the powerdomain's state counter */
>> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2=
/powerdomain.h
>> index 0d72a8a..6c6567d 100644
>> --- a/arch/arm/mach-omap2/powerdomain.h
>> +++ b/arch/arm/mach-omap2/powerdomain.h
>> @@ -19,7 +19,7 @@
>>
>> =A0#include <linux/types.h>
>> =A0#include <linux/list.h>
>> -
>> +#include <linux/mutex.h>
>> =A0#include <linux/atomic.h>
>>
>> =A0#include <plat/cpu.h>
>> @@ -116,6 +116,7 @@ struct powerdomain {
>> =A0 =A0 =A0 struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
>> =A0 =A0 =A0 struct list_head node;
>> =A0 =A0 =A0 struct list_head voltdm_node;
>> + =A0 =A0 struct mutex lock;
>> =A0 =A0 =A0 int state;
>> =A0 =A0 =A0 unsigned state_counter[PWRDM_MAX_PWRSTS];
>> =A0 =A0 =A0 unsigned ret_logic_off_counter;
>
> Please add a kerneldoc entry in the struct powerdomain documentation =
for
> this field.
Ok

>
>
> - Paul

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
