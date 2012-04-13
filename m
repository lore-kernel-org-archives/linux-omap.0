From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 01/18] led-triggers: create a trigger for CPU activity
Date: Fri, 13 Apr 2012 19:29:36 +0800
Message-ID: <CAK5ve-LiRKnph8cvUD5+D39UTd=yKCAiYUwshariJ2Naa2EF4A@mail.gmail.com>
References: <1333108713-12707-1-git-send-email-bryan.wu@canonical.com>
 <1333108713-12707-2-git-send-email-bryan.wu@canonical.com> <20120406151505.4eeb01ba.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120406151505.4eeb01ba.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tony@atomide.com, linux@arm.linux.org.uk, rpurdie@rpsys.net, manuel.lauss@gmail.com, cjb@laptop.org, cbou@mail.ru, dwmw2@infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 7, 2012 at 6:15 AM, Andrew Morton <akpm@linux-foundation.or=
g> wrote:
> On Fri, 30 Mar 2012 19:58:16 +0800
> Bryan Wu <bryan.wu@canonical.com> wrote:
>
>> Attempting to consolidate the ARM LED code, this removes the
>> custom RealView LED trigger code to turn LEDs on and off in
>> response to CPU activity and replace it with a standard trigger.
>>
>> (bryan.wu@canonical.com:
>> It moves arch/arm/kernel/leds.c syscore stubs into this trigger.
>> It also provides ledtrig_cpu trigger event stub in <linux/leds.h>.
>> Although it was inspired by ARM work, it can be used in other arch.)
>>
>>
>> ...
>>
>> +#include <linux/percpu.h>
>> +#include <linux/syscore_ops.h>
>> +#include "leds.h"
>> +
>> +#define MAX_NAME_LEN 8
>
> The kernel already has at least eight different definitions of
> MAX_NAME_LEN. =A0I guess a ninth won't hurt ;)
>
>>
>> ...
>>
>> +static void __init ledtrig_cpu_register(void)
>> +{
>> + =A0 =A0 int cpuid =3D smp_processor_id();
>> + =A0 =A0 struct led_trigger *trig;
>> + =A0 =A0 char *name =3D __get_cpu_var(trig_name);
>> +
>> + =A0 =A0 snprintf(name, MAX_NAME_LEN, "cpu%d", cpuid);
>> + =A0 =A0 led_trigger_register_simple(name, &trig);
>> +
>> + =A0 =A0 pr_info("LED trigger %s indicate activity on CPU %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 trig->name, cpuid);
>> +
>> + =A0 =A0 __get_cpu_var(cpu_trig) =3D trig;
>> +}
>> +
>> +static void __exit ledtrig_cpu_unregister(void)
>> +{
>> + =A0 =A0 struct led_trigger *trig =3D __get_cpu_var(cpu_trig);
>> + =A0 =A0 char *name =3D __get_cpu_var(trig_name);
>> +
>> + =A0 =A0 led_trigger_unregister_simple(trig);
>> + =A0 =A0 __get_cpu_var(cpu_trig) =3D NULL;
>> + =A0 =A0 memset(name, 0, MAX_NAME_LEN);
>> +}
>> +
>> +static int __init ledtrig_cpu_init(void)
>> +{
>> + =A0 =A0 int cpu;
>> +
>> + =A0 =A0 for_each_possible_cpu(cpu)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ledtrig_cpu_register();
>> +
>> + =A0 =A0 register_syscore_ops(&ledtrig_cpu_syscore_ops);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +module_init(ledtrig_cpu_init);
>
> This all looks horridly broken. =A0We call ledtrig_cpu_register() onc=
e
> for each CPU, but we call it on the same CPU each time, and it uses
> smp_processor_id() which a) is wrong and b) will emit a runtime
> preemption-is-enabled warning.
>

Indeed, my bad. I've already rewritten this function by using per_cpu()=
 API.

> I'm assuming this wasn't tested on SMP. =A0It needs to be, please.
>

Yeah, tested on my OMAP4 dual core SMP panda board.

> Also, the code uses for_each_possible_cpu, ignoring CPU hotplug.
> That's probably justifiable for this small storage size and not-hotpa=
th
> code, but the decision should be given prominence and justified in th=
e
> changelog or, better, in code comments please.
>

I tested with CPU hotplug after this initial function on Panda and
added comments.

>>
>> ...
>>
>
> The patchset is basically an ARM thing. =A0Is there some ARM tree via
> which we can get it merged?

I put these patches in my git tree, but might need Russell or Arnd to
help review and merge.

And I just resent the patchset.

Thanks,
--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.186-168-78255 Mobile
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
