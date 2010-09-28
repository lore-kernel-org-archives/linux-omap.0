From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Tue, 28 Sep 2010 23:43:55 +0200
Message-ID: <AANLkTin7yoSArdMTMSxKyamMP-dk7bubPiCEgWGb6RCc@mail.gmail.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009222049.18154.rjw@sisk.pl>
	<AANLkTinJU5+s_1S6i4GpRuiOfsAPiL9UFtrxCCbtoumt@mail.gmail.com>
	<201009282322.16291.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <201009282322.16291.rjw@sisk.pl>
Sender: linux-trace-users-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Renninger <trenn@suse.de>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Sep 28, 2010 at 11:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
> On Tuesday, September 28, 2010, Jean Pihet wrote:
>> Hi,
>
> Hi,
>
>> Here is what I am proposing, in reply to all your comments:
>>
>> 1) rename the events to match Thomas's proposal:
>> =A0 =A0power:power_cpu_cstate
>> =A0 =A0power:power_cpu_pstate
>> =A0 =A0power:power_cpu_sstate
>
> If that sstate thing is going to mean "suspend", then please drop it.
> "Suspend" is not a state, let alone a CPU state. =A0It is a procedure=
 by which
> the (entire) system is put into a sleep state (that is not confined t=
o CPUs).

Since suspend is tied to the power management of the system, is it ok
to rename it to e.g. power:system_suspend?

>
>> =A0 =A0...
>>
>> 2) introduce a new Kconfig option CONFIG_DEPRECATED_POWER_EVENTS and
>> conditionally map a subset of the new events to the old ones for
>> backward compatibility with the existing user apps. The apps should =
be
>> converted to the new API asap,
>>
>> 3) update documentation
>
> Sounds reasonable.
OK

>
>> Other remarks here below:
>>
>> On Wed, Sep 22, 2010 at 8:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wro=
te:
>> ...
>> > This POWER_SSTATE thing seems to be totally artificial and omap-sp=
ecific.
>> >
>> > Why do you want it to be done this way?
>> >
>> > Or is the ACPI handling added in the ACPI patch? =A0In which case,=
 why don't you
>> > put that power_switch_state(POWER_SSTATE, 1, 0, cpu) into
>> > kernel/power/suspend.c:suspend_enter() (and analogously for
>> > power_switch_state(POWER_SSTATE, 0, 0, cpu)).
>> The ACPI code is not using the SSTATE event.
>> Indeed inserting a tracepoint at
>> kernel/power/suspend.c:suspend_enter() is more generic. I will corre=
ct
>> this.
>
> OK
>
>> > Moreover, why is the cpu argument necessary for POWER_SSTATE at al=
l?
>> The cpu_id parameter is present in all events prototypes. This is no=
t
>> needed. I will correct this.
>
> OK
>
> Thanks,
> Rafael
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-trace-u=
sers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
