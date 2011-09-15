From: TAO HU <tghk48@motorola.com>
Subject: Re: Tasks schedule/migration issue with CPU hotplug?
Date: Thu, 15 Sep 2011 10:38:02 +0800
Message-ID: <CAOwKts9kJGYke6xA6zrQ=h6T7KMAz6uruxC37+PCskNwn6iK2A@mail.gmail.com>
References: <CAOwKts_WTDBLkz9=0MBhs6wzc67XD_bYgGMiZ-JUM+8O7gP_fw@mail.gmail.com>
	<CAOwKts8pXt6spknNfBV-wy4_KoSp-JaZsdbzOxxWTqu=f6X3Bg@mail.gmail.com>
	<20110908072801.GA11124@zhy> <20110908073943.GC11124@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110908073943.GC11124@zhy>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: peterz@infradead.org, Ingo Molnar <mingo@elte.hu>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi, Yong

You're right. We figured out something is wrong (is negative) with
vruntime of certain processes.
Below link describes the same issue we observed.
http://lkml.indiana.edu/hypermail/linux/kernel/1101.2/00333.html

And the commite indicated by you is exactly the fix.

Appreciate it!.

On Thu, Sep 8, 2011 at 3:39 PM, Yong Zhang <yong.zhang0@gmail.com> wrote:
> On Thu, Sep 08, 2011 at 03:28:01PM +0800, Yong Zhang wrote:
>> On Thu, Sep 08, 2011 at 02:47:08PM +0800, TAO HU wrote:
>> > Resend with linux-kernel mail list included.
>>
>> Hmm, could you give a try with commit da7a735e?
>>
>> Thanks,
>> Yong
>>
>> ---
>> commit da7a735e51f9622eb3e1672594d4a41da01d7e4f
>> Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
>> Date: =A0 Mon Jan 17 17:03:27 2011 +0100
>>
>> =A0 =A0 sched: Fix switch_from_fair()
>>
>> =A0 =A0 When a task is taken out of the fair class we must ensure the vr=
untime
>> =A0 =A0 is properly normalized because when we put it back in it will as=
sume
>> =A0 =A0 to be normalized.
>>
>> =A0 =A0 The case that goes wrong is when changing away from the fair cla=
ss
>> =A0 =A0 while sleeping. Sleeping tasks have non-normalized vruntime in o=
rder
>> =A0 =A0 to make sleeper-fairness work. So treat the switch away from fai=
r as a
>> =A0 =A0 wakeup and preserve the relative vruntime.
>>
>> =A0 =A0 Also update sysrq-n to call the ->switch_{to,from} methods.
>>
>> =A0 =A0 Reported-by: Onkalo Samu <samu.p.onkalo@nokia.com>
>> =A0 =A0 Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
>> =A0 =A0 LKML-Reference: <new-submission>
>> =A0 =A0 Signed-off-by: Ingo Molnar <mingo@elte.hu>
>>
>> >
>> > On Wed, Sep 7, 2011 at 10:22 PM, TAO HU <tghk48@motorola.com> wrote:
>> > > <4>[ 6950.136230] cfs_rq[0]:/
>> > > <4>[ 6950.136230] ? .exec_clock ? ? ? ? ? ? ? ? ? ?: 6520265.283900
>> > > <4>[ 6950.136260] ? .MIN_vruntime ? ? ? ? ? ? ? ? ?: 2223057.428522
>> > > <4>[ 6950.136260] ? .min_vruntime ? ? ? ? ? ? ? ? ?: 2223057.428522
>> > > <4>[ 6950.136291] ? .max_vruntime ? ? ? ? ? ? ? ? ?: 2223114.709956
>> > > <4>[ 6950.136291] ? .spread ? ? ? ? ? ? ? ? ? ? ? ?: 57.281434
>> > > <4>[ 6950.136291] ? .spread0 ? ? ? ? ? ? ? ? ? ? ? : 0.000000
>> > > <4>[ 6950.136322] ? .nr_running ? ? ? ? ? ? ? ? ? ?: 212
>> > > <4>[ 6950.136322] ? .load ? ? ? ? ? ? ? ? ? ? ? ? ?: 217650
>> > > <4>[ 6950.136352] ? .nr_spread_over ? ? ? ? ? ? ? ?: 125034
>> > > <4>[ 6950.136352] ? .shares ? ? ? ? ? ? ? ? ? ? ? ?: 0
>> > > <4>[ 6950.136352]
>> > > <4>[ 6950.136566] runnable tasks:
>> > > <4>[ 6950.136566] ? ? ? ? ? ? task ? PID ? ? ? ? tree-key ?switches
>> > > prio ? ? exec-runtime ? ? ? ? sum-exec ? ? ? ?sum-sleep
>> > > <4>[ 6950.136596]
>> > > --------------------------------------------------------------------=
--------------------------------------
>> > > <4>[ 6950.136627] ? ? ?omap2_mcspi ? ?21 ? 2223062.886210 ?29451523
>
> The tree-key(2223062.886210) almost equals to cfs_rq.min_vruntime,
> so maybe you hit the bug which is cured by the mentioned commit.
>
> Thanks,
> Yong
>



-- =

Best Regards
Hu Tao
