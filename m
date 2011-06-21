From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
Date: Tue, 21 Jun 2011 15:51:00 +0530
Message-ID: <4E00708C.6050108@ti.com>
References: <20110620104415.GF2082@n2100.arm.linux.org.uk> <4DFF255E.5030308@ti.com> <20110620111336.GG2082@n2100.arm.linux.org.uk> <4DFF2E37.8030602@ti.com> <20110620114019.GH2082@n2100.arm.linux.org.uk> <20110620142338.GL2082@n2100.arm.linux.org.uk> <4DFF5F29.2000904@ti.com> <4E005F92.8030208@ti.com> <20110621100057.GB23802@n2100.arm.linux.org.uk> <4E006FA0.7050508@ti.com> <20110621101900.GC23802@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:42360 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751200Ab1FUKVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jun 2011 06:21:08 -0400
In-Reply-To: <20110621101900.GC23802@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 6/21/2011 3:49 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 21, 2011 at 03:47:04PM +0530, Santosh Shilimkar wrote:

[...]

>>> I already have that as a separate change.
>> Can you point me to both of these commits so that I have
>> them in my tree for testing.
>
> I won't be committing the init/calibrate.c change to a git tree - it
> isn't ARM stuff so it goes in patch form.

Patches with change log would be fine as well.

Regards
Santosh

