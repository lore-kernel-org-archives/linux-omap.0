From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 09:32:51 -0700
Message-ID: <4C9A2FB3.105@linux.intel.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>	<201009171736.14170.trenn@suse.de>	<20100917162412.GB3341@elte.hu>	<201009180026.59482.trenn@suse.de>	<AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com>	<4C9A21AD.1000800@linux.intel.com> <AANLkTim6B+Je=LykgJb9=0vK5Br1rkft619BRJkBcHdP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTim6B+Je=LykgJb9=0vK5Br1rkft619BRJkBcHdP@mail.gmail.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Thomas Renninger <trenn@suse.de>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

  On 9/22/2010 8:36 AM, Jean Pihet wrote:
> On Wed, Sep 22, 2010 at 5:33 PM, Arjan van de Ven<arjan@linux.intel.com>  wrote:
>>   On 9/22/2010 8:31 AM, Jean Pihet wrote:
>>> Hi,
>>>
>>> Here is a patch that redefines the power events API. The advantages
>>> are: easier maintainance of the kernel and the
>>> user space tools, a cleaner and more generic interface, more
>>> parameters for fine tracing and even documentation!
>>>
>>> Thomas, this patch has your patch above merged in ('power-trace: Use
>>> power_switch_state instead of power_start and power_end'). The revised
>>> ACPI patch is coming asap.
>>>
>>> The trace points for x86 and OMAP are also udated accordingly.
>>>
>>> The pytimechart tool needs an update for the new API. This can be done
>>> as soon as the kernel code gets merged in.
>> unfortunately this code is changing a userspace ABI... we really shouldn't
>> do that if we can avoid it,
>> and here we can avoid it.
>>
>> applications ARE using this stuff!
> What are the apps that are using it? I know about builtin-timechart,
> pytimechart. Is powertop using this as well?

powertop 2.x codebase is as well.

and a bunch of tools we have internal here at Intel.

the thing with ABIs is that you don't know how many users you have.. at 
least here you know the lower bound is 3 different tools that are open 
source.
.... and likely many local tools that aren't.

