From: Tejun Heo <tj@kernel.org>
Subject: Re: PATCH [0/4] perf: clean-up of power events API
Date: Fri, 08 Oct 2010 10:14:40 +0200
Message-ID: <4CAED2F0.9080801@kernel.org>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com> <201010062334.46971.trenn@suse.de> <20101007150825.GB12581@Krystal> <AANLkTikT4xsh7iCQDX8ksewJwC-BeFov=Ab7iYo+hDmO@mail.gmail.com> <20101007155816.GA5351@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45141 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755774Ab0JHIQM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Oct 2010 04:16:12 -0400
In-Reply-To: <20101007155816.GA5351@nowhere>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Pierre Tardy <tardyp@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Renninger <trenn@suse.de>, Jean Pihet <jean.pihet@newoldbits.com>, linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

Hello,

On 10/07/2010 05:58 PM, Frederic Weisbecker wrote:
> I really feel uncomfortable with this tracepoint/ABI problem....
> Mathieu suggested we start a user library that could handle these
> changes when they are really necessary.
> 
> Thoughts?
> 
> (Adding Tejun in Cc).

Given that tracepoints are supposed to make internal operation
visible.  I don't think it's a good idea to make it part of fixed ABI.
Maybe some core part can be put in stone but I think things like
internal workqueue implementation should be changeable without
worrying about ABI issues.

Thanks.

-- 
tejun
