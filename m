From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Wed, 21 Dec 2011 01:55:13 -0800
Message-ID: <CAMbhsRSNTUvou9Gf6T4Ggq=jfxsWUcn7M2yNsKQz6aNrt6gLDg@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4EF1A0B4.5080307@linux.intel.com>
	<CAMbhsRRP7s9xsHqxhb=iMfHAJFcqAea-6CDORZS34RCPNo+UWw@mail.gmail.com>
	<4EF1AA8A.8060304@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4EF1AA8A.8060304-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Trinabh Gupta <g.trinabh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Deepthi Dharwar <deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 21, 2011 at 1:44 AM, Arjan van de Ven <arjan-VuQAYsv1562vlLw7lfJaRg@public.gmane.org=
m> wrote:
> On 12/21/2011 10:40 AM, Colin Cross wrote:
>
>>> this smells fundamentally racey to me; you can get an interrupt one
>>> cycle after you think you're done, but before the last guy enters W=
=46I...
>>>
>>> how do you solve that issue ?
>>
>> All the cpus have interrupts off when they increment the counter, so
>> they cannot receive an interrupt. =A0If an interrupt is pending on o=
ne
>> of those cpus, it will be handled later when WFI aborts due to the
>> pending interrupt.
>
> ... but this leads to cases where you're aborting before other cpus a=
re
> entering..... so your "last guy in" doesn't really work, since while =
cpu
> 0 thinks it's the last guy, cpu 1 is already on the way out/out
> already... =A0(heck it might already be going back to sleep if your i=
dle
> code can run fast, like in the size of a cache miss)

Once a cpu has incremented the counter, it has no way out unless either
1: another cpu (that hasn't incremented the counter yet) receives an
interrupt, aborts idle, and clears its idle flag
or
2: all cpus enter the ready counter, and call the cpuidle driver's
enter function.

In your example, cpu 1 has incremented the counter, so it cannot be on
the way out unless cpu 0 aborts (in which case it will not increment
the counter, and the counter will never be equal to the number of
cpus), or unless cpu 0 turns off its interrupts and incrementes the
counter (in which case neither cpu can return until after the cpuidle
driver's enter function has been called on all cpus).
