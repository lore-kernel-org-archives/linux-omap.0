From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Sat, 09 Oct 2010 09:19:06 -0700
Message-ID: <4CB095FA.8060803@linux.intel.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com> <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal> <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com> <20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org> <20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com> <20101008134156.GA28724@Krystal> <20101009062836.GB5517@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2579 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757539Ab0JIQTJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 9 Oct 2010 12:19:09 -0400
In-Reply-To: <20101009062836.GB5517@elte.hu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

  On 10/8/2010 11:28 PM, Ingo Molnar wrote:
> * Mathieu Desnoyers<mathieu.desnoyers@efficios.com>  wrote:
>
>> * Arjan van de Ven (arjan@linux.intel.com) wrote:
>>>   On 10/8/2010 1:38 AM, Ingo Molnar wrote:
>>>> The fundamental thing about tracing/instrumentation is that there
>>>> are no deep ABI needs: it's all about analyzing development kernels
>>>> (and a few select versions that get the enterprise treatment) but
>>>> otherwise the half-life of this kind of information is very short.
>>>>
>>>> So we dont want to tie ourselves down with excessive ABIs.
>>> ok I'll start working on a second mechanism then to export
>>> information that applications need ;-( it'll look a lot like tracing
>>> I suppose ;-(
>> What's wrong with doing the compatibility layer in a LGPL library
>> shipped with the kernel tree under tools/ ? Why does everything *have*
>> to be done in kernel-space ? Why are you so focused on making your
>> application interact directly with kernel ABIs ?
> The thing is, Arjan is 100% right that a library for this is not a
> 'solution', it's an unnecessary complication.
>
> What i suggested in my mail was to _keep existing events_. I.e. do not
> break powertop. We are 100% happy that we _have_ such apps, and we
> should do reasonable things to not break them.
>
> If we need to change events, we can add a new event. The old events will
> lose their relevance without us having to do much - and without us
> having to break powertop, pytimechart, etc. We can even have periods of
> overlap when both events are available - to give instrumentation apps
> time to learn the new events.
>
> I.e. it's not an ABI in the classic sense - we do not (because we
> cannot) guarantee the infinite availability of these events. But we can
> guarantee that the fields do not change in some stupid, avoidable way.

also I have to say that some events are more likely to change than others

"function foo in the kernel called" is more likely to change than "the 
processor went to THIS frequency".
The concept of CPU frequencies has been with us fora long time and is 
going to be there for a long time as well ......

