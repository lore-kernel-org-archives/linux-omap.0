From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
Date: Mon, 20 Jun 2011 15:49:57 +0530
Message-ID: <4DFF1ECD.8080305@ti.com>
References: <1308561839-18407-1-git-send-email-santosh.shilimkar@ti.com>
	<20110620095053.GA2082@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110620095053.GA2082@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 6/20/2011 3:20 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 20, 2011 at 02:53:59PM +0530, Santosh Shilimkar wrote:
>> The current ARM CPU hotplug code suffers from couple of race conditions
>> in CPU online path with scheduler.
>> The ARM CPU hotplug code doesn't wait for hot-plugged CPU to be marked
>> active as part of cpu_notify() by the CPU which brought it up before
>> enabling interrupts.
>
> Hmm, why not just move the set_cpu_online() call before notify_cpu_starting()
> and add the wait after the set_cpu_online() ?
I think that's what patch is doing. Do you mean, calling hotplug
notifier chain immediately after CPU marked as online. Something
like below.

	set_cpu_online(cpu, true);
	notify_cpu_starting(cpu);
         while (!cpumask_test_cpu(smp_processor_id(), cpu_active_mask))
                 cpu_relax();

         /*
          * Enable local interrupts.
          */
                 local_irq_enable();
         local_fiq_enable();


Regards
Santosh
