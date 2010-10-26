From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 09:04:19 -0700
Message-ID: <4CC6FC03.708@linux.intel.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>	<1288049630-10947-1-git-send-email-trenn@suse.de>	<20101026071020.GC13036@elte.hu> <AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On 10/26/2010 8:32 AM, Pierre Tardy wrote:
> On Tue, Oct 26, 2010 at 2:10 AM, Ingo Molnar<mingo@elte.hu>  wrote:
>
>> How will future PCI (or other device) power saving tracepoints be called?
>>
>> Might be more consistent to use:
>>
>>   power:cpu_idle
>>   power:machine_idle
>>   power:device_idle
> Agree with this.
>
> FYI, I have a runtime_pm tracepoint currently cooking. Here is
> preliminary patch.
> Can this be a candidate for a "power:device_idle" tracepoint?


I would like to see a slightly more advanced tracepoint do the runtime 
pm framework;
specifically I'd like to see the "comm" of the process that's taking a 
refcount on a device
(that way, powertop can track which process keeps a device busy)

