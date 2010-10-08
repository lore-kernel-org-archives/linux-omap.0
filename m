From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 08 Oct 2010 13:21:35 -0400
Message-ID: <1286558495.6661.822.camel@gandalf.stny.rr.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
	 <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal>
	 <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com>
	 <20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org>
	 <20101008083819.GA22385@elte.hu> <4CAF19E7.3070103@linux.intel.com>
	 <20101008134156.GA28724@Krystal>  <4CAF4554.7070303@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:56087 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757884Ab0JHRVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 13:21:40 -0400
In-Reply-To: <4CAF4554.7070303@linux.intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, 2010-10-08 at 09:22 -0700, Arjan van de Ven wrote:
> On 10/8/2010 6:41 AM, Mathieu Desnoyers wrote:

> because that is not workable... at least nobody has shown to be able to 
> make this work.
> libraries (after compilation) live in /lib or /usr/lib (or lib64 I 
> suppose).....
> what mechanism ensures that a user who compiles his kernel gets a 
> library compatible with that kernel in /usr/lib?
> and can said library deal with older kernels too? And distro kernels?

Perhaps we should have "make install" of a kernel also install this
library?

Have two libraries? One that is linked to the app, the other that can
search for another library to link on load too (like a kernel.ld.so)

Then we could see the kernel version, and search for a library that is
compatible, and load that one.

The app only needs to worry about loading the generic library. The
generic library can test for compatible libraries for the kernel.

Could just be..

  libkernel.ld.so  which then loads..

  /lib/modules/2.6.36/libkernel.so


Just a little brain storming.

-- Steve


