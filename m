From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
Date: Mon, 20 Jun 2011 20:24:33 +0530
Message-ID: <4DFF5F29.2000904@ti.com>
References: <1308561839-18407-1-git-send-email-santosh.shilimkar@ti.com> <20110620095053.GA2082@n2100.arm.linux.org.uk> <20110620101438.GD2082@n2100.arm.linux.org.uk> <4DFF20B3.7010209@ti.com> <20110620104415.GF2082@n2100.arm.linux.org.uk> <4DFF255E.5030308@ti.com> <20110620111336.GG2082@n2100.arm.linux.org.uk> <4DFF2E37.8030602@ti.com> <20110620114019.GH2082@n2100.arm.linux.org.uk> <20110620142338.GL2082@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110620142338.GL2082@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 6/20/2011 7:53 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 20, 2011 at 12:40:19PM +0100, Russell King - ARM Linux wrote:
>> Ok.  So loops_per_jiffy must be too small.  My guess is you're using an
>> older kernel without 71c696b1 (calibrate: extract fall-back calculation
>> into own helper).
>
> Right, this commit above helps show the problem - and it's fairly subtle.
>
> It's a race condition.  Let's first look at the spinlock debugging code.
> It does this:
>
> static void __spin_lock_debug(raw_spinlock_t *lock)
> {
>          u64 i;
>          u64 loops = loops_per_jiffy * HZ;
>
>          for (;;) {
>                  for (i = 0; i<  loops; i++) {
>                          if (arch_spin_trylock(&lock->raw_lock))
>                                  return;
>                          __delay(1);
>                  }
> 		/* print warning */
> 	}
> }
>
> If loops_per_jiffy is zero, we never try to grab the spinlock, because
> we never enter the inner for loop.  We immediately print a warning,
> and re-execute the outer loop for ever, resulting in the CPU locking up
> in this condition.
>
> In theory, we should never see a zero loops_per_jiffy value, because it
> represents the number of loops __delay() needs to delay by one jiffy and
> clearly zero makes no sense.
>
> However, calibrate_delay() does this (which x86 and ARM call on secondary
> CPU startup):
>
> calibrate_delay()
> {
> ...
> 	if (preset_lpj) {
> 	} else if ((!printed)&&  lpj_fine) {
> 	} else if ((loops_per_jiffy = calibrate_delay_direct()) != 0) {
> 	} else {
> 		/* approximation/convergence stuff */
> 	}
> }
>
> Now, before 71c696b, this used to be:
>
>          } else {
>                  loops_per_jiffy = (1<<12);
>
> So the window between calibrate_delay_direct() returning and setting
> loops_per_jiffy to zero, and the re-initialization of loops_per_jiffy
> was relatively short (maybe even the compiler optimized away the zero
> write.)
>
> However, after 71c696b, this now does:
>
>          } else {
>                  if (!printed)
>                          pr_info("Calibrating delay loop... ");
> +               loops_per_jiffy = calibrate_delay_converge();
>
> So, as loops_per_jiffy is not local to this function, the compiler has
> to write out that zero value, before calling calibrate_delay_converge(),
> and loops_per_jiffy only becomes non-zero _after_ calibrate_delay_converge()
> has returned.  This opens the window and allows the spinlock debugging
> code to explode.
>
> This patch closes the window completely, by only writing to loops_per_jiffy
> only when we have a real value for it.
>
> This allows me to boot 3.0.0-rc3 on Versatile Express (4 CPU) whereas
> without this it fails with spinlock lockup and rcu problems.
>
>   init/calibrate.c |   14 ++++++++------
>   1 files changed, 8 insertions(+), 6 deletions(-)
>
I am away from my board now. Will test this change.
btw, the online-active race is still open even with this patch close
and should be fixed.

Regards
Santosh
