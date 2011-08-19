From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] trace points: power: remove 'cpu_id' from
 trace_clock_*
Date: Fri, 19 Aug 2011 11:14:00 -0400
Message-ID: <1313766840.15704.104.camel@gandalf.stny.rr.com>
References: <1313766244-22313-1-git-send-email-tom.leiming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:57245 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab1HSPOD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Aug 2011 11:14:03 -0400
In-Reply-To: <1313766244-22313-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tom.leiming@gmail.com
Cc: fweisbec@gmail.com, jean.pihet@newoldbits.com, mingo@redhat.com, trenn@suse.de, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>

On Fri, 2011-08-19 at 23:04 +0800, tom.leiming@gmail.com wrote:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> This patch removes the 'cpu_id' parameter of the clock_*
> trace point, based on the ideas below:
> 
> - the cpu_id which is passed to trace point is always the current
>   cpu
> - the current cpu info has been included into the trace result already
> - smp_processor_id() can't be used safely in preemptible context.
> 

Do you know if these changes wont break powertop?

-- Steve


