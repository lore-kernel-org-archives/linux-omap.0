From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: RT throttling and suspend/resume (was Re: [PATCH] i2c: omap: revert
 "i2c: omap: switch to threaded IRQ support")
Date: Tue, 16 Oct 2012 14:39:50 -0700
Message-ID: <87ipaanljt.fsf_-_@deeprootsystems.com>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121016133356.GG21801@arwen.pp.htv.fi> (Felipe Balbi's message
 of "Tue, 16 Oct 2012 16:33:56 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Paul Walmsley <paul@pwsan.com>, Wolfram Sang <w.sang@pengutronix.de>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

+ peterz, tglx

Felipe Balbi <balbi@ti.com> writes:

[...]

> The problem I see is that even though we properly return IRQ_WAKE_THREAD
> and wake_up_process() manages to wakeup the IRQ thread (it returns 1),
> the thread is never scheduled. To make things even worse, ouw irq thread
> runs once, but doesn't run on a consecutive call. Here's some (rather
> nasty) debug prints showing the problem:

[...]

>> [   88.721923] try_to_wake_up 1411
>> [   88.725189] ===> irq_wake_thread 139: IRQ 72 wake_up_process 0
>> [   88.731292] [sched_delayed] sched: RT throttling activated

This throttling message is the key one.

With RT throttling activated, the IRQ thread will not be run (it
eventually will be allowed much later on, but by then, the I2C xfers
have timed out.)

As a quick hack, the throttling can be disabled by seeting the
sched_rt_runtime to RUNTIME_INF:

        # sysctl -w kernel.sched_rt_runtime_us=-1

and a quick test shows that things go back to working as expected.  But
we still need to figure out why the throttling is hapenning...

So I started digging into why the RT runtime was so high, and noticed
that time spent in suspend was being counted as RT runtime!

So spending time in suspend anywhere near sched_rt_runtime (0.95s) will
cause the RT throttling to always be triggered, and thus prevent IRQ
threads from running in the resume path.  Ouch.

I think I'm already in over my head in the RT runtime stuff, but
counting the time spent in suspend as RT runtime smells like a bug to
me. no?

Peter? Thomas?

Kevin
