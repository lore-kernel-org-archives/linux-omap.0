From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 10:08:08 +0200
Message-ID: <AANLkTiknZ5t24j44hhDrbocJSJv1d=9LtvcSrd2QPcq2@mail.gmail.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
	<20101026071020.GC13036@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101026071020.GC13036@elte.hu>
Sender: linux-trace-users-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Ingo,

On Tue, Oct 26, 2010 at 9:10 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Thomas Renninger <trenn@suse.de> wrote:
>
>> Changes in V2:
>> =A0 - Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
>> =A0 - Use u32 instead of u64 for cpuid, state which is by far enough

=2E..

>>
>> +#define PWR_EVENT_EXIT 0xFFFFFFFF
>
> Shouldnt this be part of the POWER_ enum? (and you can write -1 there=
)
>
>> +#ifndef _TRACE_POWER_ENUM_
>> +#define _TRACE_POWER_ENUM_
>> +enum {
>> + =A0 =A0 POWER_NONE =3D 0,
>> + =A0 =A0 POWER_CSTATE =3D 1,
>> + =A0 =A0 POWER_PSTATE =3D 2,
>> +};
>> +#endif
>
> Since we are cleaning up all these events, those enum definitions don=
t really look
> logical. For example, what is 'POWER_NONE'? Can a CPU have 'no power'=
?
The enum belongs to the deprecated API so I would rather not touch it.
Keeping the deprecated code isolated will make it easier to remove
later.

>
> Plus:
>
>> +DECLARE_EVENT_CLASS(processor,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int state, unsigned int cpu_id),
>> +
>> + =A0 =A0 TP_ARGS(state, cpu_id),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0 =A0 =A0u32, =A0 =A0 =A0 =A0=
 =A0 =A0state =A0 =A0 =A0 =A0 =A0 )
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0 =A0 =A0u32, =A0 =A0 =A0 =A0=
 =A0 =A0cpu_id =A0 =A0 =A0 =A0 =A0)
>
> Trace entries can carry a cpu_id of the current processor already. Ca=
n this cpu_id
> ever be different from that CPU id?
I have no evidence of that (powr mgt on SMP ARM is coming real
soon...) but one can imagine one of the CPUs being the master for PM
decisions.

>
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_fast_assign(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->state =3D state;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __entry->cpu_id =3D cpu_id;
>> + =A0 =A0 ),
>> +
>> + =A0 =A0 TP_printk("state=3D%lu cpu_id=3D%lu", (unsigned long)__ent=
ry->state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)__entry->cpu_id)
>> +);
>> +
>> +DEFINE_EVENT(processor, processor_idle,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int state, unsigned int cpu_id),
>> +
>> + =A0 =A0 =A0 =A0 =A0TP_ARGS(state, cpu_id)
>> +);
>> +
>> +#define PWR_EVENT_EXIT 0xFFFFFFFF
>> +
>> +DEFINE_EVENT(processor, processor_frequency,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int frequency, unsigned int cpu_id),
>> +
>> + =A0 =A0 TP_ARGS(frequency, cpu_id)
>> +);
>
> So, we have a 'state' field in the class, which is used as 'state' by=
 the
> power::cpu_idle event, and as 'frequency' by the power::cpu_freq even=
t?
>
> Are there any architectures that track frequency in Hz, not in kHz? I=
f yes, might
> there ever be a need for the frequency value to be larger than 4.29 G=
Hz? If yes,
> then it wont fit into u32.
>
> Also, might there be a future need to express different types of freq=
uencies? For
> example, should we decide to track turbo frequencies in Intel CPUs, h=
ow would that
> be expressed via these events? Are there any architectures and CPUs t=
hat somehow
> have some extra attribute to the frequency value?
>
>> +TRACE_EVENT(machine_suspend,
>> +
>> + =A0 =A0 TP_PROTO(unsigned int state),
>> +
>> + =A0 =A0 TP_ARGS(state),
>> +
>> + =A0 =A0 TP_STRUCT__entry(
>> + =A0 =A0 =A0 =A0 =A0 =A0 __field( =A0 =A0 =A0 =A0u32, =A0 =A0 =A0 =A0=
 =A0 =A0state =A0 =A0 =A0 =A0 =A0 )
>> + =A0 =A0 ),
>
> Hm, this event is not used anywhere in the submitted patches. Where i=
s the patch
> that adds usage, and what are the possible values for 'state'?
This will come as a separate patch, which fits all platforms. Cf.
http://marc.info/?l=3Dlinux-omap&m=3D128620575300682&w=3D2.
The state field is of type suspend_state_t, cf. include/linux/suspend.h
>
> =A0 =A0 =A0 =A0Ingo
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-trace-u=
sers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
