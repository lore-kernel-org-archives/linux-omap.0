From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Thu, 7 Oct 2010 17:45:45 +0200
Message-ID: <AANLkTi=fhBt2VYUcTEntn1y2W4EDqPBK2FsCU1LKkSPa@mail.gmail.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	<201010062334.46971.trenn@suse.de>
	<20101007150825.GB12581@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20101007150825.GB12581@Krystal>
Sender: linux-trace-users-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Oct 7, 2010 at 5:08 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> [ Adding a few more CCs, since this discussion is about a tracepoint
> =A0userspace ABI policy, which is a topic of general interest. ]
>
> * Thomas Renninger (trenn@suse.de) wrote:
>> Hi,
>>
>> On Monday 04 October 2010 17:20:57 Jean Pihet wrote:
>> > Here is a re-spin of the patches after discussion.
>>
>> what is going to happen here now?
>>
>> Is this supposed to go through Ingo's tree?
>>
>> Ingo: do you mind commenting on this.
>
> Meanwhile, here are some ideas...
>
>
>> I see 3 possibilities:
>> =A0 1) Power (or all) perf events are never going to change.
>
> Persisting with bad interfaces (which were never meant to be stable, =
and were
> actually explicitely said to be non-stable) for the sake of poorly wr=
itten
> proprietary userspace apps does not seem like viable to me. Since whe=
n did we
> start designing kernel code for broken proprierary apps ? (see below =
for
> solutions on how to fix the apps)
>
> The only reason we have these tracepoints in there is because they ca=
n follow
> kernel code changes, thanks to their flexible nature. Being stucked w=
ith
> badly named tracepoints because of some monolithic analyzer app is ju=
st insane.
>
>> =A0 If they are going to change, then now is the right time and
>> =A0 2) Backward compatibility is provided in some way for some time.
>
> I've looked at the resulting code, and, honestly, it's ugly and it co=
mplexifies
> the test matrix. I would really prefer to move this compatibility cra=
p out of
> the kernel out into userspace libraries, where it belongs. It should =
have got
> there in the first place when the developers of these propritary
> tracepoint-consumers got the hint that those were going to change. Th=
en you have
> a sane design:
>
> 1) The kernel, providing a tracepoint ABI that *can change over time*=
, because
> =A0 tracepoints are too tied to kernel code to afford not being chang=
ed.
> 2) Adapdation libraries, some which could be provided with the perf u=
serspace
> =A0 libraries, some which could be provided along with the tracepoint=
 consumer
> =A0 application, so the proprietary application can link on an open-s=
ource
> =A0 library that can be upgraded when needed.
> 3) The trace analyzer. So if the analyzer is open source, then it's f=
ine, it
> =A0 could follow the rare ABI breakups that are needed by a simple up=
grade.
> =A0 Ideally we might want to keep backward compatibility code in ther=
e too, but
> =A0 it's OK to require users to upgrade their tools if the kernel is =
upgraded.
> =A0 If the analyzer is closed-source, then it should interact with an=
 open source
> =A0 library rather than with the kernel tracepoints ABI.
Totally agree here! The real solution is to provide such a library.
Anyone interested?

> So, given that I don't want to uglify kernel code based on some badly=
 written
> proprietary userspace tools, and given we've given all possible warni=
ngs telling
> that the tracepoint ABI might change, I really don't see why we shoul=
d bother
> bloating the kernel with this. The analyzers should be changed to use=
 adaptation
> libraries instead.
>
>> =A0 3) The power events get cleaned up without compatibility to
>> =A0 =A0 =A0former kernels versions.
>>
>> There are patches for 2. and 3., for 1. there obviously are no
>> needed.
>> For 2., the patches (mine or Jeans), need some polishing. IMO
>> these double events inside of general code aren't that bad.
>> I trust Jean, that it's not that easy with all the include magic
>> and macros, partly realized that myself already and it's not worth
>> it to dig further for a temporary solution.
>>
>> Votes so far:
>> 1. Arjan
>> 2. Myself, Jean
>> 3. Peter Zijlstra and Mathieu Desnoyers
I am for 3 but I do not mind to provide the code for 2.

>>
>> Jean's work got successfully blocked for weeks now.
>> If there would be a final decision by a maintainer who is going to
>> merge Jean's work, that would be great and it would finally be worth
>> to send updated patches again which hopefully some day find their wa=
y into
>> a linux-next kernel...
>
> Yes, sadly this debate running in circles hurts contributors.

Indeed.

Honestly I do not know what to do next. Here are some facts:
- Thomas and myself did completely rework the patches a couple of
times now and most of them got acked
- A transition API has been provided along with a Kconfig option.
Special care has been taken to provide an easy to maintain solution
(just remove the option from Kconfig and a few lines of code in
kernel/trace)
- I am willing to provide the according patches to pytimechart, for
the new API only. Some pytimechart fixes from myself are already in
the tree thanks to the maintainer (Pierre).

Please let us move this forward. Some more on-going work is depending
on those changes.

Thanks,
Jean

>
> Thanks for the summary!
>
> Mathieu
>
>>
>> Thanks,
>>
>> =A0 =A0 =A0 Thomas
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
>
--
To unsubscribe from this list: send the line "unsubscribe linux-trace-u=
sers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
