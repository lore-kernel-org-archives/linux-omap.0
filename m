From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
Date: Tue, 21 Jun 2011 14:38:34 +0530
Message-ID: <4E005F92.8030208@ti.com>
References: <1308561839-18407-1-git-send-email-santosh.shilimkar@ti.com> <20110620095053.GA2082@n2100.arm.linux.org.uk> <20110620101438.GD2082@n2100.arm.linux.org.uk> <4DFF20B3.7010209@ti.com> <20110620104415.GF2082@n2100.arm.linux.org.uk> <4DFF255E.5030308@ti.com> <20110620111336.GG2082@n2100.arm.linux.org.uk> <4DFF2E37.8030602@ti.com> <20110620114019.GH2082@n2100.arm.linux.org.uk> <20110620142338.GL2082@n2100.arm.linux.org.uk> <4DFF5F29.2000904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49441 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752727Ab1FUJIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jun 2011 05:08:43 -0400
In-Reply-To: <4DFF5F29.2000904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Russell,

On 6/20/2011 8:24 PM, Santosh Shilimkar wrote:
> On 6/20/2011 7:53 PM, Russell King - ARM Linux wrote:
>> On Mon, Jun 20, 2011 at 12:40:19PM +0100, Russell King - ARM Linux wrote:
[....]

>> So, as loops_per_jiffy is not local to this function, the compiler has
>> to write out that zero value, before calling calibrate_delay_converge(),
>> and loops_per_jiffy only becomes non-zero _after_
>> calibrate_delay_converge()
>> has returned. This opens the window and allows the spinlock debugging
>> code to explode.
>>
>> This patch closes the window completely, by only writing to
>> loops_per_jiffy
>> only when we have a real value for it.
>>
>> This allows me to boot 3.0.0-rc3 on Versatile Express (4 CPU) whereas
>> without this it fails with spinlock lockup and rcu problems.
>>
>> init/calibrate.c | 14 ++++++++------
>> 1 files changed, 8 insertions(+), 6 deletions(-)
>>
> I am away from my board now. Will test this change.
Have tested your change and it seems to fix the crash I
was observing. Are you planning to send this fix for rc5?

> btw, the online-active race is still open even with this patch close
> and should be fixed.
>
The only problem remains is waiting for active mask before
marking CPU online. Shall I refresh my patch with only
this change then ?

Regards
Santosh
