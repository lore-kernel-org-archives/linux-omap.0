From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 22 Sep 2010 20:09:01 +0200
Message-ID: <201009222009.02011.rjw@sisk.pl>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com> <AANLkTimMAr9kEzybFGai3qGyXx36v055iPpXq_C1vW8C@mail.gmail.com> <4C9A21AD.1000800@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <4C9A21AD.1000800@linux.intel.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Thomas Renninger <trenn@suse.de>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, September 22, 2010, Arjan van de Ven wrote:
>   On 9/22/2010 8:31 AM, Jean Pihet wrote:
> > Hi,
> >
> > Here is a patch that redefines the power events API. The advantages
> > are: easier maintainance of the kernel and the
> > user space tools, a cleaner and more generic interface, more
> > parameters for fine tracing and even documentation!
> >
> > Thomas, this patch has your patch above merged in ('power-trace: Use
> > power_switch_state instead of power_start and power_end'). The revised
> > ACPI patch is coming asap.
> >
> > The trace points for x86 and OMAP are also udated accordingly.
> >
> > The pytimechart tool needs an update for the new API. This can be done
> > as soon as the kernel code gets merged in.
> 
> unfortunately this code is changing a userspace ABI... we really 
> shouldn't do that if we can avoid it,
> and here we can avoid it.
> 
> applications ARE using this stuff!

Apart from this, could we rename things like POWER_CSTATE to CPU_POWER_CSTATE
and state clearly in the docs that this whole thing is about CPU power?

Thanks,
Rafael
