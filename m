From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Wed, 21 Dec 2011 01:40:54 -0800
Message-ID: <CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4EF1A0B4.5080307@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EF1A0B4.5080307-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Trinabh Gupta <g.trinabh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Deepthi Dharwar <deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 21, 2011 at 1:02 AM, Arjan van de Ven <arjan-VuQAYsv1562vlLw7lfJaRg@public.gmane.org=
m> wrote:
> On 12/21/2011 1:09 AM, Colin Cross wrote:
>> On some ARM SMP SoCs (OMAP4460, Tegra 2, and probably more), the
>> cpus cannot be independently powered down, either due to
>> sequencing restrictions (on Tegra 2, cpu 0 must be the last to
>> power down), or due to HW bugs (on OMAP4460, a cpu powering up
>> will corrupt the gic state unless the other cpu runs a work
>> around). =A0Each cpu has a power state that it can enter without
>> coordinating with the other cpu (usually Wait For Interrupt, or
>> WFI), and one or more "coupled" power states that affect blocks
>> shared between the cpus (L2 cache, interrupt controller, and
>> sometimes the whole SoC). =A0Entering a coupled power state must
>> be tightly controlled on both cpus.
>>
>> The easiest solution to implementing coupled cpu power states is
>> to hotplug all but one cpu whenever possible, usually using a
>> cpufreq governor that looks at cpu load to determine when to
>> enable the secondary cpus. =A0This causes problems, as hotplug is an
>> expensive operation, so the number of hotplug transitions must be
>> minimized, leading to very slow response to loads, often on the
>> order of seconds.
>>
>> This patch series implements an alternative solution, where each
>> cpu will wait in the WFI state until all cpus are ready to enter
>> a coupled state, at which point the coupled state function will
>> be called on all cpus at approximately the same time.
>>
>> Once all cpus are ready to enter idle, they are woken by an smp
>> cross call. =A0At this point, there is a chance that one of the
>> cpus will find work to do, and choose not to enter suspend. =A0A
>> final pass is needed to guarantee that all cpus will call the
>> power state enter function at the same time. =A0During this pass,
>> each cpu will increment the ready counter, and continue once the
>> ready counter matches the number of online coupled cpus. =A0If any
>> cpu exits idle, the other cpus will decrement their counter and
>> retry.
>
> this smells fundamentally racey to me; you can get an interrupt one
> cycle after you think you're done, but before the last guy enters WFI=
=2E..
>
> how do you solve that issue ?

All the cpus have interrupts off when they increment the counter, so
they cannot receive an interrupt.  If an interrupt is pending on one
of those cpus, it will be handled later when WFI aborts due to the
pending interrupt.
