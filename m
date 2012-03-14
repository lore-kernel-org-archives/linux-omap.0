From: Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Tue, 13 Mar 2012 17:28:15 -0700
Message-ID: <CAMbhsRRZ+xt179RN32-+eBWngbRow=MpKV1XcLvG-sHGF6VOJA@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4F1929E9.7070707@linaro.org>
	<8762e8kqi6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8762e8kqi6.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arjan van de Ven <arjan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Trinabh Gupta <g.trinabh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Deepthi Dharwar <deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 13, 2012 at 4:52 PM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
> Hi Colin,
>
> On 12/21/2011 01:09 AM, Colin Cross wrote:
>
>> To use coupled cpuidle states, a cpuidle driver must:
>
> [...]
>
>> =A0 =A0 Provide a struct cpuidle_state.enter function for each state
>> =A0 =A0 that affects multiple cpus. =A0This function is guaranteed t=
o be
>> =A0 =A0 called on all cpus at approximately the same time. =A0The dr=
iver
>> =A0 =A0 should ensure that the cpus all abort together if any cpu tr=
ies
>> =A0 =A0 to abort once the function is called.
>
> I've discoved the last sentence above is crucial, and in order to cat=
ch
> all the corner cases I found it useful to have the struct
> cpuidle_coupled in cpuidle.h so that the driver can check ready_count
> itself (patch below, on top of $SUBJECT series.)

ready_count is an internal state of core coupled code, and will change
significantly in the next version of the patches.  Drivers cannot
depend on it.

> As you know, on OMAP4, when entering the coupled state, CPU0 has to w=
ait
> for CPU1 to enter its low power state before entering itself. =A0The =
first
> pass at implementing this was to just spin waiting for the powerdomai=
n
> of CPU1 to hit off. =A0That works... most of the time.
>
> If CPU1 wakes up immediately (or before CPU0 starts checking), or mor=
e
> likely, fails to hit the low-power state because of other hardware
> "conditions", CPU0 will end up stuck in the loop waiting for CPU1.
>
> To solve this, in addition to checking the power state of CPU1, I als=
o
> check if (coupled->ready_count !=3D cpumask_weight(&coupled->alive_co=
upled_cpus)).
> If true, it means that CPU1 has already exited/aborted so CPU0 had
> better abort as well.
>
> Checking the ready_count seemed like an easy way to do this, but did =
you
> have any other mechanisms in mind for CPUs to communicate that they'v=
e
> exited/aborted?

Why not set a flag from CPU1 when it exits the low power state, and
have CPU0 spin on the powerdomain register or the flag?  You can then
use the parallel barrier function to ensure both cpus have seen the
flag and reset it to 0 before returning.
