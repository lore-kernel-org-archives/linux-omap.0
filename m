From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 08 Oct 2010 06:17:27 -0700
Message-ID: <4CAF19E7.3070103@linux.intel.com>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com> <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal> <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com> <20101007155816.GA5351@nowhere> <4CAED2F0.9080801@kernel.org> <20101008083819.GA22385@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35453 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913Ab0JHNR3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 09:17:29 -0400
In-Reply-To: <20101008083819.GA22385@elte.hu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Tejun Heo <tj@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Pierre Tardy <tardyp@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

  On 10/8/2010 1:38 AM, Ingo Molnar wrote:
>
> The fundamental thing about tracing/instrumentation is that there are no
> deep ABI needs: it's all about analyzing development kernels (and a few
> select versions that get the enterprise treatment) but otherwise the
> half-life of this kind of information is very short.
>
> So we dont want to tie ourselves down with excessive ABIs.
>

ok I'll start working on a second mechanism then to export information 
that applications need ;-(
it'll look a lot like tracing I suppose ;-(

