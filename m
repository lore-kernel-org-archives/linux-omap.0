From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] tools, perf: Documentation for the power events API
Date: Mon, 10 Jan 2011 11:10:43 +0100
Message-ID: <AANLkTikC2SbRxJ-uMu6PYO9iXNyvDivZAt8jZwc-7YOT@mail.gmail.com>
References: <1294253342-29056-1-git-send-email-j-pihet@ti.com>
	<1294253342-29056-3-git-send-email-j-pihet@ti.com>
	<20110107055042.GA6137@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <20110107055042.GA6137@besouro.research.nokia.com>
Sender: linux-perf-users-owner@vger.kernel.org
To: eduardo.valentin@nokia.com
Cc: mingo@elte.hu, trenn@suse.de, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello Eduardo,

On Fri, Jan 7, 2011 at 6:50 AM, Eduardo Valentin
<eduardo.valentin@nokia.com> wrote:
> Hello Jean,
>
> On Wed, Jan 05, 2011 at 07:49:02PM +0100, ext jean.pihet@newoldbits.c=
om wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Provides documentation for the following:
>> - the new power trace API,
>> - the old (legacy) power trace API,
>> - the DEPRECATED Kconfig option usage.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0Documentation/trace/events-power.txt | =A0 90 +++++++++++++++++++=
+++++++++++++++
>> =A01 files changed, 90 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/trace/events-power.txt
>>
>> diff --git a/Documentation/trace/events-power.txt b/Documentation/tr=
ace/events-power.txt
>> new file mode 100644
>> index 0000000..96d87b6
>> --- /dev/null
>> +++ b/Documentation/trace/events-power.txt
>> @@ -0,0 +1,90 @@
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Subsystem Trace Points: po=
wer
>> +
>> +The power tracing system captures events related to power transitio=
ns
>> +within the kernel. Broadly speaking there are three major subheadin=
gs:
>> +
>> + =A0o Power state switch which reports events related to suspend (S=
-states),
>> + =A0 =A0 cpuidle (C-states) and cpufreq (P-states)
>> + =A0o System clock related changes
>
> What do you mean by system clock here? I see that you are covering cp=
u rate
> changes and system clock (?) here. How about memory clock changes?
> Would it make sense to have a major subheading for it? Maybe you are
> targeting it be traced by means of clocks event (item 2. bellow)..
The meaning is to trace the system clocks changes, i.e. clocks that
the CPUs can control. Maybe 'SoC clocks' is a better name for it.
Indeed 'System clock related changes' is for '2. Clocks events'

Thanks for the review!

Regards,
Jean

>
>> + =A0o Power domains related changes and transitions
>> +
>> +This document describes what each of the tracepoints is and why the=
y
>> +might be useful.
>> +
>> +Cf. include/trace/events/power.h for the events definitions.
>> +
>> +1. Power state switch events
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> +
>> +1.1 New trace API
>> +-----------------
>> +
>> +A 'cpu' event class gathers the CPU-related events: cpuidle and
>> +cpufreq.
>> +
>> +cpu_idle =A0 =A0 =A0 =A0 =A0 =A0 "state=3D%lu cpu_id=3D%lu"
>> +cpu_frequency =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"state=3D%lu cpu_id=3D=
%lu"
>> +
>> +A suspend event is used to indicate the system going in and out of =
the
>> +suspend mode:
>> +
>> +machine_suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0"state=3D%lu"
>> +
>> +
>> +Note: the value of '-1' or '4294967295' for state means an exit fro=
m the current state,
>> +i.e. trace_cpu_idle(4, smp_processor_id()) means that the system
>> +enters the idle state 4, while trace_cpu_idle(PWR_EVENT_EXIT, smp_p=
rocessor_id())
>> +means that the system exits the previous idle state.
>> +
>> +The event which has 'state=3D4294967295' in the trace is very impor=
tant to the user
>> +space tools which are using it to detect the end of the current sta=
te, and so to
>> +correctly draw the states diagrams and to calculate accurate statis=
tics etc.
>> +
>> +1.2 DEPRECATED trace API
>> +------------------------
>> +
>> +A new Kconfig option CONFIG_EVENT_POWER_TRACING_DEPRECATED with the=
 default value of
>> +'y' has been created. This allows the legacy trace power API to be =
used conjointly
>> +with the new trace API.
>> +The Kconfig option, the old trace API (in include/trace/events/powe=
r.h) and the
>> +old trace points will disappear in a future release (namely 2.6.41)=
=2E
>> +
>> +power_start =A0 =A0 =A0 =A0 =A0"type=3D%lu state=3D%lu cpu_id=3D%lu=
"
>> +power_frequency =A0 =A0 =A0 =A0 =A0 =A0 =A0"type=3D%lu state=3D%lu =
cpu_id=3D%lu"
>> +power_end =A0 =A0 =A0 =A0 =A0 =A0"cpu_id=3D%lu"
>> +
>> +The 'type' parameter takes one of those macros:
>> + . POWER_NONE =A0 =A0 =A0 =A0=3D 0,
>> + . POWER_CSTATE =A0 =A0 =A0=3D 1, =A0 =A0/* C-State */
>> + . POWER_PSTATE =A0 =A0 =A0=3D 2, =A0 =A0/* Fequency change or DVFS=
 */
>> +
>> +The 'state' parameter is set depending on the type:
>> + . Target C-state for type=3DPOWER_CSTATE,
>> + . Target frequency for type=3DPOWER_PSTATE,
>> +
>> +power_end is used to indicate the exit of a state, corresponding to=
 the latest
>> +power_start event.
>> +
>> +2. Clocks events
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +The clock events are used for clock enable/disable and for
>> +clock rate change.
>> +
>> +clock_enable =A0 =A0 =A0 =A0 "%s state=3D%lu cpu_id=3D%lu"
>> +clock_disable =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s state=3D%lu cpu_id=
=3D%lu"
>> +clock_set_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s state=3D%lu cpu_id=3D=
%lu"
>> +
>> +The first parameter gives the clock name (e.g. "gpio1_iclk").
>> +The second parameter is '1' for enable, '0' for disable, the target
>> +clock rate for set_rate.
>> +
>> +3. Power domains events
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +The power domain events are used for power domains transitions
>> +
>> +power_domain_target =A0"%s state=3D%lu cpu_id=3D%lu"
>> +
>> +The first parameter gives the power domain name (e.g. "mpu_pwrdm").
>> +The second parameter is the power domain target state.
>> +
>> --
>> 1.7.2.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
>
> --
> Eduardo Valentin
>
