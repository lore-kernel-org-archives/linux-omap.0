From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
Date: Tue, 21 Jun 2011 11:26:00 +0100
Message-ID: <20110621102600.GD23802@n2100.arm.linux.org.uk>
References: <20110620111336.GG2082@n2100.arm.linux.org.uk> <4DFF2E37.8030602@ti.com> <20110620114019.GH2082@n2100.arm.linux.org.uk> <20110620142338.GL2082@n2100.arm.linux.org.uk> <4DFF5F29.2000904@ti.com> <4E005F92.8030208@ti.com> <20110621100057.GB23802@n2100.arm.linux.org.uk> <4E006FA0.7050508@ti.com> <20110621101900.GC23802@n2100.arm.linux.org.uk> <4E00708C.6050108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49584 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab1FUK0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jun 2011 06:26:17 -0400
Content-Disposition: inline
In-Reply-To: <4E00708C.6050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jun 21, 2011 at 03:51:00PM +0530, Santosh Shilimkar wrote:
> On 6/21/2011 3:49 PM, Russell King - ARM Linux wrote:
>> On Tue, Jun 21, 2011 at 03:47:04PM +0530, Santosh Shilimkar wrote:
>
> [...]
>
>>>> I already have that as a separate change.
>>> Can you point me to both of these commits so that I have
>>> them in my tree for testing.
>>
>> I won't be committing the init/calibrate.c change to a git tree - it
>> isn't ARM stuff so it goes in patch form.
>
> Patches with change log would be fine as well.

The answer is not at the moment, but maybe soon.
