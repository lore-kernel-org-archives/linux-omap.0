From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 09:59:24 +0200
Message-ID: <AANLkTikf8QXwbmz6=Pv_onHOb3trUtaz1D5kmsHCPqy+@mail.gmail.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1288049630-10947-1-git-send-email-trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 26, 2010 at 1:33 AM, Thomas Renninger <trenn@suse.de> wrote=
:
> Changes in V2:
> =A0- Introduce PWR_EVENT_EXIT instead of 0 to mark non-power state
> =A0- Use u32 instead of u64 for cpuid, state which is by far enough
>
> New power trace events:
> power:processor_idle
> power:processor_frequency
> power:machine_suspend
>
>
> C-state/idle accounting events:
> =A0power:power_start
> =A0power:power_end
> are replaced with:
> =A0power:processor_idle
>
> and
> =A0power:power_frequency
> is replaced with:
> =A0power:processor_frequency
>
> power:machine_suspend
> is newly introduced, a first implementation
> comes from the ARM side, but it's easy to add these events
> in X86 as well if needed.
This will come as a separate patch, which fits all platforms. Cf.
http://marc.info/?l=3Dlinux-omap&m=3D128620575300682&w=3D2.

=2E..

> @@ -481,10 +484,12 @@ static void mwait_idle(void)
> =A0static void poll_idle(void)
> =A0{
> =A0 =A0 =A0 =A0trace_power_start(POWER_CSTATE, 0, smp_processor_id())=
;
> +       trace_processor_idle(1, smp_processor_id());

Should that be:
+       trace_processor_idle(0, smp_processor_id());
instead?
Since state '0' is for the CPU active in polling mode and
PWR_EVENT_EXIT means 'exit from any idle state'.

> =A0 =A0 =A0 =A0local_irq_enable();
> =A0 =A0 =A0 =A0while (!need_resched())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> - =A0 =A0 =A0 trace_power_end(0);
> + =A0 =A0 =A0 trace_power_end(smp_processor_id());
> + =A0 =A0 =A0 trace_processor_idle(PWR_EVENT_EXIT, smp_processor_id()=
);
> =A0}
>
> =A0/*

=2E..

> diff --git a/include/trace/events/power.h b/include/trace/events/powe=
r.h
=2E..

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-trace-u=
sers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
