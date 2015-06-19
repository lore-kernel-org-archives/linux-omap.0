From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v2] futex: lower the lock contention on the HB lock during
 wake up
Date: Fri, 19 Jun 2015 10:51:31 -0700
Message-ID: <CAMAWPa9F3qP41XQ1jb9U+fQxUAogYnomHabbKj6PG1=Mf8sW2w@mail.gmail.com>
References: <1432056298-18738-1-git-send-email-dave@stgolabs.net>
	<1432056298-18738-2-git-send-email-dave@stgolabs.net>
	<20150616192911.GA19500@linutronix.de>
	<1434484226.1903.19.camel@stgolabs.net>
	<20150617083350.GA2433@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150617083350.GA2433@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Mike Galbraith <umgwanakikbuti@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, lkml <linux-kernel@vger.kernel.org>, Tyler Baker <tyler.baker@linaro.org>, Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 17, 2015 at 1:33 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> wake_futex_pi() wakes the task before releasing the hash bucket lock
> (HB). The first thing the woken up task usually does is to acquire the
> lock which requires the HB lock. On SMP Systems this leads to blocking
> on the HB lock which is released by the owner shortly after.
> This patch rearranges the unlock path by first releasing the HB lock and
> then waking up the task.
>
> [bigeasy: redo ontop of lockless wake-queues]
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> * Davidlohr Bueso | 2015-06-16 12:50:26 [-0700]:
>
>>I prefer having two separate patches, thus keeping their own changelog
>>for the change justification.
>
> okay, here it is on top of #1.

A handful of boot test failures on ARM/OMAP were found by kernelci.org
in next-20150619[1] and were bisected down to this patch, which hit
next-20150619 in the form of commit 881bd58d6e9e (futex: Lower the
lock contention on the HB lock during wake up).  I confirmed that
reverting that patch on top of next-20150619 gets things booting again
for the affected platforms.

I haven't debugged this any further, but full boot logs are available
for the boot failures[2][3] and the linux-omap list and maintainer are
Cc'd here to help investigate further if needed.

Kevin

[1] http://kernelci.org/boot/all/job/next/kernel/next-20150619/
[2] http://storage.kernelci.org/next/next-20150619/arm-multi_v7_defconfig/lab-khilman/boot-omap5-uevm.html
[3] http://storage.kernelci.org/next/next-20150619/arm-omap2plus_defconfig/lab-tbaker/boot-omap3-beagle-xm.html
