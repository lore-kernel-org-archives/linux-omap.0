From: Xianghua Xiao <xiaoxianghua@gmail.com>
Subject: Re: Issue with SCHED_FIFO app
Date: Wed, 12 May 2010 22:16:30 -0500
Message-ID: <AANLkTilGJ8VVFM5sUEP3ZXOSaUSeGpxui7NkuUPRpM_m@mail.gmail.com>
References: <k2j54a292881005092139u7e120250hf530f8b688abdd22@mail.gmail.com>
	 <t2s54a292881005092142h58ccae9ch2ecec665d06a7601@mail.gmail.com>
	 <AANLkTillkVE9Mmz3CiQyIF5yiZfpp13g18UCyMQSuZ_K@mail.gmail.com>
	 <201005131249.56432.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201005131249.56432.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Con Kolivas <kernel@kolivas.org>
Cc: Suresh Rajashekara <suresh.raj+linuxomap@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, May 12, 2010 at 9:49 PM, Con Kolivas <kernel@kolivas.org> wrote=
:
> On Wed, 12 May 2010 12:46:20 Xianghua Xiao wrote:
>> On Sun, May 9, 2010 at 11:42 PM, Suresh Rajashekara
>>
>> <suresh.raj+linuxomap@gmail.com> wrote:
>> > Hi All,
>> >
>> > I had a couple of application (with real time priority SCHED_FIFO)
>> > which were working fine on 2.6.16. They have started behaving
>> > differently on 2.6.29.
>> >
>> > I will explain my problem briefly.
>> >
>> > Application A (my main application) is scheduled with SCHED_FIFO a=
nd
>> > priority 5. Application B (watchdog application) is also scheduled=
 with
>> > SCHED_FIFO but with priority 54.
>> >
>> > A keeps putting the OMAP to sleep and wake up every 4 seconds and
>> > again puts it to sleep.
>> > B is supposed to be running every 1.25 seconds to kick watchdog, b=
ut
>> > since A keeps OMAP in sleep for 4 seconds, it should run as soon a=
s
>> > OMAP wakes up.
>> >
>> > Since B is of a higher priority, its supposed to run whenever the =
OMAP
>> > wakes up and then A should again put it back to sleep. This happen=
s
>> > perfectly on 2.6.16
>> >
>> > On 2.6.29, B fails to run when OMAP wakes up and before A puts it =
back
>> > to sleep. B only runs if there is atleast 1.5 seconds of delay bet=
ween
>> > the awake-sleep cycle.
>> >
>> > On searching the internet, I figured out that CFS (completely fair
>> > scheduler) was introduced in 2.6.23, which makes some changes to t=
he
>> > RT bandwidth (and many users started facing issues with they
>> > applications with SCHED_FIFO). Somewhere on the web I found that
>> > issuing
>> >
>> > echo -1 > /proc/sys/kernel/sched_rt_runtime_us
>> >
>> > should disable the changes which affects the RT bandwidth. It actu=
ally
>> > did help to an extent in solving some other problem (not described
>> > above. A's IOCTL call return was getting delayed), but this proble=
m
>> > still persists.
>> >
>> > Any pointers to where I should look for the solution.
>> >
>> > Is there a way I can revert back to the scheduler behavior as it w=
as on
>> > 2.6.16?
>> >
>> > I have disabled CONFIG_GROUP_SCHED and also CONFIG_CGROUPS. I am u=
sing
>> > 2.6.29 on an OMAP1 platform.
>> >
>> > Thanks in advance,
>> > Suresh
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>
>> I have seen similar things while upgrading a 2.6.18 RT kernel to
>> 2.6.33 RT, actually exactly when CFS was introduced we found
>> performance issues, in that, our main application(a multi-thread
>> SCHED_FIFO / SCHED_RR mixed) runs with much higher overhead under CF=
S.
>> In 2.6.18RT, the cpu usage is close to 0% and on newer kernel with
>> CFS, the cpu usage is 12% when the application runs idle(i.e. sleepi=
ng
>> and waiting for input, WCHAN shows sched_timeout or futex_wait). Whe=
n
>> the main application runs with real load, cpu usage gets much worse
>> with CFS.
>>
>> I tried various methods, including the one you described above, and
>> made sure no sched_yield is used, etc, still the main application
>> spends 6% cpu in user space and 6% in kernel space while at idle. I
>> tried BFS schedule and it's actually better, about 8% in user space
>> and 0.6% in kernel space while the application runs idle. Again with
>> 2.6.18 RT it's nearly 0% cpu usage.
>
> It's distinctly possible that there is no change in the CPU usage at =
all and
> this is purely representing the change in how CPU accounting is done =
in CFS,
> and now BFS since the older mainline scheduler. The old mainline sche=
duler was
> potentially very inaccurate at representing CPU usage, particularly w=
hen tasks
> were very short lived. In fact it was possible to write a carefully c=
rafted
> application that would use 99.9% CPU and register as zero CPU usage, =
by
> ensuring it slept just before the accounting tick would be hit. CFS c=
hanged
> dramatically how CPU accounting was done, and on BFS I changed it yet=
 again,
> trying to make it more accurate.
>
> The only way to see if there is a real issue with a change in CPU usa=
ge is to
> measure CPU usage through other means, which can be incredibly diffic=
ult to
> do, such as the power consumed by the CPU, the maximum throughput of =
the
> applications, and so on.
>
> I do not think this is related to the original issue reported with SC=
HED_FIFO
> apps on this email thread though.
>
> --
> -ck
>

The pthread that has most "cpu usage"(2.6%) is a simple SCHED_RR task
waiting on select(), another two top cpu usage SCHED_RR pthreads are
our own timers, these three are supposedly idle tasks before a user
activates inputs.

lmbench was done and the results are close, though 2.6.33rt wins on
latency but overall 2.6.18rt has better performance(esp on fork, exec,
context switch performance).

I'm unsure if the newest "top" (or /proc/PID/stat) reports the correct
cpu usage when CFS/BFS is used, as you mentioned it seems failed to do
that. I will try to stress the system and see who fails first under
same workload, maybe that's the only way to compare cpu usage between
2.6.18rt vs 2.6.33rt, for now.

Thanks a lot,
Xianghua
