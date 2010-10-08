From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 8 Oct 2010 09:41:56 -0400
Message-ID: <20101008134156.GA28724@Krystal>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com> <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal> <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com> <20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org> <20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4CAF19E7.3070103@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

* Arjan van de Ven (arjan@linux.intel.com) wrote:
>  On 10/8/2010 1:38 AM, Ingo Molnar wrote:
>>
>> The fundamental thing about tracing/instrumentation is that there are no
>> deep ABI needs: it's all about analyzing development kernels (and a few
>> select versions that get the enterprise treatment) but otherwise the
>> half-life of this kind of information is very short.
>>
>> So we dont want to tie ourselves down with excessive ABIs.
>>
>
> ok I'll start working on a second mechanism then to export information  
> that applications need ;-(
> it'll look a lot like tracing I suppose ;-(

What's wrong with doing the compatibility layer in a LGPL library shipped with
the kernel tree under tools/ ? Why does everything *have* to be done in
kernel-space ? Why are you so focused on making your application interact
directly with kernel ABIs ?

I'm being direct because there are trivial solutions to your problem that you
are rejecting without due consideration. (and also I just had one coffee too
many) ;-)

Regards,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
