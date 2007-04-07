From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: BUG: at kernel/sched.c:4031 __schedule()
Date: Sat, 07 Apr 2007 09:49:49 +0200
Message-ID: <46174D1D.90401@googlemail.com>
References: <46164B23.9080202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46164B23.9080202@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Oleg Kechin <okechin@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Oleg Kechin wrote:
> Hi
> I run 2.6.20-rt8 kernel on board like innovator1510 (OMAP5910 cpu)
> I notice in boot string:
> BUG: at kernel/sched.c:4031 __schedule()
> kernel complain interrupts are enabled after schedule.
> 
> digging in sched.c I figured out that interrupts are disabled when cpu 
> enter __sched(),
> but are enabled when it went out.
> Playing with the code i can find out, that problem is in the next 
> fragment: (line 4024)
> 
>    if (likely(prev != next)) {
>        next->timestamp = now;
>        rq->nr_switches++;
>        rq->curr = next;
>        ++*switch_count;
> 
>        prepare_task_switch(rq, next);
>        prev = context_switch(rq, prev, next);
>        barrier();
>        trace_special_pid(prev->pid, PRIO(prev), PRIO(current));
>        /*
>         * this_rq must be evaluated again because prev may have moved
>         * CPUs since it called schedule(), thus the 'rq' on its stack
>         * frame will be invalid.
>         */
>        finish_task_switch(this_rq(), prev);
>        __preempt_enable_no_resched();
>    } else {
> 
> in prepare_task_switch(rq, next); interrupts are enabled,
> but in finish_task_switch(this_rq(), prev); interrupts not disabled
> (it look not symmetrical for me).
> 
> Can anybody tell - is this right behavior?
> I think interrupts should be disabled somewhere in this fragment,
> or may be, scheduler should not complain?

Looks to me that this isn't an OMAP specific question. I 
think linux-rt-users@vger.kernel.org list [1] is a better 
place for this question.

Did you try a more recent -rt patch? They are updated 
frequently with additional fixes.

Regards

Dirk

[1] http://rt.wiki.kernel.org/index.php/Mailinglists
