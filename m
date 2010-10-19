From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Tue, 19 Oct 2010 06:27:57 -0700
Message-ID: <4CBD9CDD.1010300@linux.intel.com>
References: <201010062334.46971.trenn@suse.de> <4CB095FA.8060803@linux.intel.com> <20101010121928.GA2688@elte.hu> <201010191331.03080.trenn@suse.de> <20101019114501.GA25371@elte.hu> <1287488841.1994.5.camel@twins> <20101019115200.GC25371@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8261 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758570Ab0JSN2A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 09:28:00 -0400
In-Reply-To: <20101019115200.GC25371@elte.hu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Renninger <trenn@suse.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org

  On 10/19/2010 4:52 AM, Ingo Molnar wrote:
> * Peter Zijlstra<peterz@infradead.org>  wrote:
>
>> On Tue, 2010-10-19 at 13:45 +0200, Ingo Molnar wrote:
>>> * Thomas Renninger<trenn@suse.de>  wrote:
>>>
>>>>> Most definitely. It's no accident that it took such a long time for this issue
>>>>> to be raised in the first place. It's a rare occurance -
>>>> Do you agree that this occurance happened now and these events should get cleaned
>>>> up before ARM and other archs make use of the broken interface?
>>>>
>>>> If not, discussing this further, is a big waste of time... and Jean would have to
>>>> try to adapt his ARM code on the broken ABI...
>>> The discussion seems to have died down somewhat. Please re-send to lkml the latest
>>> patches you have to remind everyone of the latest state of things - the merge window
>>> is getting near.
>>>
>>> My only compatibility/ABI point is basically that it shouldnt break _existing_
>>> tracepoints (and users thereof). If your latest bits meet that then it ought to be a
>>> good first step. You are free to (and encouraged to) introduce more complete sets of
>>> events.
>> Can we deprecate and eventually remove the old ones, or will we be forever obliged
>> to carry the old ones too?
> We most definitely want to deprecate and remove the old ones - but we want to give
> instrumentation software some migration time for that.
>
> Jean, Arjan, what would be a feasible and practical deprecation period for that? One
> kernel cycle?

more like a year

for some time software needs to support both, especially if popular 
distros stick to an older kernel like *cough* RHEL6

