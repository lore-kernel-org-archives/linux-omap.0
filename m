From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 06:58:06 -0700
Message-ID: <4CC58CEE.9080507@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <1287488171-25303-3-git-send-email-trenn@suse.de> <20101025100428.GA24061@elte.hu> <201010251303.04019.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <201010251303.04019.trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On 10/25/2010 4:03 AM, Thomas Renninger wrote:
> On Monday 25 October 2010 12:04:28 Ingo Molnar wrote:
>> * Thomas Renninger<trenn@suse.de>  wrote:
>>
>>> New power trace events:
>>> power:processor_idle
>>> power:processor_frequency
>>> power:machine_suspend
>>>
>>>
>>> C-state/idle accounting events:
>>>    power:power_start
>>>    power:power_end
>>> are replaced with:
>>>    power:processor_idle
>> Well, most power saving hw models (and the code implementing them) have this kind of
>> model:
>>
>>   enter power saving mode X
>>   exit power saving mode
>>
>> Where X is some sort of 'power saving deepness' attribute, right?
> Sure.
> But ACPI and afaik this model got picked up for PCI and other (sub-)archs
> as well, defines state 0 as the non-power saving mode.

correct ,... "C0" is not power efficient... but it's still a valid OS 
idle state!
Also tracking processor_idle_{start,end} as a separate event!

same for "S0"... S0 as standby state is still valid... sure it doesn't 
save you much power... but that does not mean it's not valid.
(as indication, the Intel Moorestown platform, which is currently in 
production and available to OEMs, has such a S0 standby state)


> makes no sense and there is no need to introduce:
> processor_idle_start/processor_idle_end
> machine_suspend_start/machine_suspend_end
> device_power_mode_start/device_power_mode_end
> events.
> Using state 0 as "exit/end", is much nicer for kernel/
> userspace implementations/code and the user.
actually no; having written a few of these in userspace so far, having a 
separate end event is easier to deal with;
the actions you take on entry and exit are complete separate code paths.

