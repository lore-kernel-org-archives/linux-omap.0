From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 13:15:31 -0500
Message-ID: <AANLkTikAGsdm7HS7Au-6CHw5n0OC1c1L_j2AJgZKE_=K@mail.gmail.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
	<20101026071020.GC13036@elte.hu>
	<AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF@mail.gmail.com>
	<4CC6FC03.708@linux.intel.com>
	<AANLkTinrmhBkjnXE+xQGgrsv_OR_ckz=dyH4EoDB59X_@mail.gmail.com>
	<1288115894.3673.12.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42201 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab0JZSPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Oct 2010 14:15:32 -0400
In-Reply-To: <1288115894.3673.12.camel@laptop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@elte.hu>, Thomas Renninger <trenn@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Frank Eigler <fche@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, rjw@sisk.pl, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Frederic Weisbecker <fweisbec@gmail.com>, Tejun Heo <tj@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

On Tue, Oct 26, 2010 at 12:58 PM, Peter Zijlstra <peterz@infradead.org>=
 wrote:
> On Tue, 2010-10-26 at 11:56 -0500, Pierre Tardy wrote:
>>
>> + =A0 =A0 =A0 trace_runtime_pm_usage(dev, atomic_read(&dev->power.us=
age_count)+1);
>> =A0 =A0 =A0 =A0 atomic_inc(&dev->power.usage_count);
>
> That's terribly racy..
>
I know. I'm not proud of this.. As I said, this is preliminary patch.
We dont really need to have this prev_usage. This is just for debug.
It mayprobably endup with something like:

         atomic_inc(&dev->power.usage_count);
+       trace_power_device_usage(dev);

--=20
Pierre
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
