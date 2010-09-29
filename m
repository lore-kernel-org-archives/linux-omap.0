From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Wed, 29 Sep 2010 11:25:43 +0200
Message-ID: <AANLkTikmcMZhJh348vcVkPwWRyXot8m+==484tY=cEkD@mail.gmail.com>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009282322.16291.rjw@sisk.pl>
	<4CA261F4.5070803@linux.intel.com>
	<201009290949.34245.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64213 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab0I2JZq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 05:25:46 -0400
In-Reply-To: <201009290949.34245.trenn@suse.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, arjan@infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-trace-users@vger.kernel.org

Hi,

On Wed, Sep 29, 2010 at 9:49 AM, Thomas Renninger <trenn@suse.de> wrote=
:
> On Tuesday 28 September 2010 23:45:24 Arjan van de Ven wrote:
>> =A0 On 9/28/2010 2:22 PM, Rafael J. Wysocki wrote:
>> > On Tuesday, September 28, 2010, Jean Pihet wrote:
>> >> Hi,
>> > Hi,
>> >
>> >> Here is what I am proposing, in reply to all your comments:
>> >>
>> >> 1) rename the events to match Thomas's proposal:
>> >> =A0 =A0 power:power_cpu_cstate
>> >> =A0 =A0 power:power_cpu_pstate
>> >> =A0 =A0 power:power_cpu_sstate
> I'd not name it that X86/ACPI specific.
> =A0 =A0power:processor_sleep
> =A0 =A0power:processor_frequency
> =A0 =A0power:system_suspend
> This would map with X86/ACPI c/p/s states but the name would
> also match fine with ARM and other archs.
Good for me!

>
>> > If that sstate thing is going to mean "suspend", then please drop
>> > it.
>> > "Suspend" is not a state, let alone a CPU state. =A0It is a proced=
ure
>> > by which the (entire) system is put into a sleep state (that is no=
t
>> > confined to CPUs).
>>
>> there are also non-suspend S states, like S0i1 and S0i3 (supported i=
n
>> the current Intel "Moorestown" platform)
>>
>> so it's slightly more complex than "just" suspend :)
> Something specific for this arch could get introduced, similar as
> Jean did for the ARM specifics, e.g.:
> power:moorestown_suspend
I would not introduce arch specific events. Your other proposal below
is more generic.

> Intel probably invented three names for this new technique, one
> might fit as an event name?
> Depending whether extra info needs passed through this event it
> could also use
> =A0 =A0power:system_suspend
> and pass a suspend state of #define S0i1 0x100, #define S0i2 0x101...
I am OK with that.

>
> I try to find time to come up with another cleanup patch.
> I also want to look at perf timechart then where I remember some ugly
> hacks with C-state accounting and the broken state_start, state_end a=
nd
> frequency_switch events. Hope it won't get too ugly and perf timechar=
t
> can support both, the old and the cleaned up events for a while.
About pytimechart, I think it should be updated with the support for
the new events only. The current version is not perfect but supports
the current events correctly. I am planning to celan up and upgrade
that tool when the new API is out.

If that could force people to upgrade to the new events API asap...

>
> =A0 =A0Thomas
>
I know you want to see real code. Let me come with a respin of the
patch asap (it is a matter of days).

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
