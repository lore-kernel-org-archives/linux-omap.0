From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 2/3] PERF(kernel): Cleanup power events
Date: Mon, 25 Oct 2010 09:00:17 -0700
Message-ID: <4CC5A991.5090109@linux.intel.com>
References: <1287488171-25303-1-git-send-email-trenn@suse.de> <4CC597FA.7080606@linux.intel.com> <20101025145604.GB16397@elte.hu> <201010251748.59218.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <201010251748.59218.trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, Peter Zijlstra <peterz@infradead.org>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Pierre Tardy <tardyp@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-omap@vger.kernel.org

On 10/25/2010 8:48 AM, Thomas Renninger wrote:
> On Monday 25 October 2010 16:56:04 Ingo Molnar wrote:
>> * Arjan van de Ven<arjan@linux.intel.com>  wrote:
>>> On 10/25/2010 7:36 AM, Thomas Renninger wrote:
>>> ok so we have
>>>
>>> "C0 idle"
> Ideally this should not be called C0, but expressed
> as (#define) POLL_IDLE wherever possible.
>
> In all documentations/specs/white papers about other OSes
> C0 is refered to as not being idle.
> Linux mis-uses it as a self-defined idle state which
> is really confusing.

sure naming is one thing
>>> and
>>> "C0 no longer idle"
>>>
>>> I'd propose using the number 0 for the first one (it makes the most
>>> logical sense, it's the least deep idle state etc etc)
> I would use a special number for the "Linux only" state.

that special number is 0 though..
it makes sense in ordering, 0 < 1, 1 < 2 etc



0 makes for a really bad special number for the exit marker; not just here,
but also for your suspend hook, that one definitely needs to change
(since current commercially available SOCs already reuse 0 for this for 
standby level states)


