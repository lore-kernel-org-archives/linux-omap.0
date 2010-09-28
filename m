From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Tue, 28 Sep 2010 14:45:24 -0700
Message-ID: <4CA261F4.5070803@linux.intel.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <201009222049.18154.rjw@sisk.pl> <AANLkTinJU5+s_1S6i4GpRuiOfsAPiL9UFtrxCCbtoumt@mail.gmail.com> <201009282322.16291.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22204 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112Ab0I1Vph (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Sep 2010 17:45:37 -0400
In-Reply-To: <201009282322.16291.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Thomas Renninger <trenn@suse.de>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org

  On 9/28/2010 2:22 PM, Rafael J. Wysocki wrote:
> On Tuesday, September 28, 2010, Jean Pihet wrote:
>> Hi,
> Hi,
>
>> Here is what I am proposing, in reply to all your comments:
>>
>> 1) rename the events to match Thomas's proposal:
>>     power:power_cpu_cstate
>>     power:power_cpu_pstate
>>     power:power_cpu_sstate
> If that sstate thing is going to mean "suspend", then please drop it.
> "Suspend" is not a state, let alone a CPU state.  It is a procedure by which
> the (entire) system is put into a sleep state (that is not confined to CPUs).

there are also non-suspend S states, like S0i1 and S0i3 (supported in 
the current Intel "Moorestown" platform)

so it's slightly more complex than "just" suspend :)

