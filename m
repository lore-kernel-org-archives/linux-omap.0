From: Thomas Renninger <trenn@suse.de>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Tue, 19 Oct 2010 13:31:01 +0200
Message-ID: <201010191331.03080.trenn@suse.de>
References: <201010062334.46971.trenn@suse.de> <4CB095FA.8060803@linux.intel.com> <20101010121928.GA2688@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:45375 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758323Ab0JSLbF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 07:31:05 -0400
In-Reply-To: <20101010121928.GA2688@elte.hu>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Sunday 10 October 2010 14:19:28 Ingo Molnar wrote:
> 
> * Arjan van de Ven <arjan@linux.intel.com> wrote:
> 
...
> > also I have to say that some events are more likely to change than others
> > 
> > "function foo in the kernel called" is more likely to change than "the 
> > processor went to THIS frequency". The concept of CPU frequencies has 
> > been with us fora long time and is going to be there for a long time 
> > as well ......
Right, it's a frequency and a CPU that should get passed along with the
event. The X86/ACPI specific X-state data (even there unused and never will 
get used) should vanish before ARM starts to make use of it.
The idle (power_start/power_end) state definition is worse...

> Most definitely. It's no accident that it took such a long time for this 
> issue to be raised in the first place.
> It's a rare occurance -
Do you agree that this occurance happened now and these events
should get cleaned up before ARM and other archs make use of the broken
interface?
If not, discussing this further, is a big waste of time... and Jean
would have to try to adapt his ARM code on the broken ABI...

> and then 
> we can deal with it intelligently, without breaking stuff unnecessarily.
Can we get this defined a bit clearer so that a patch can be created?

Compatibility can only be achieved by still firing the old events for
some kernel rounds.

I'll send some patches in a new thread with these people in CC.
It would be great to see a decision (in a way that a patch can be created)
how an event change can/should look like if there is urgent need.

Thanks,

         Thomas
