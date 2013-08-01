From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 3/3] arm: omap: convert omap boot_lock to raw
Date: Thu, 1 Aug 2013 14:37:37 +0100
Message-ID: <20130801133737.GG21614@n2100.arm.linux.org.uk>
References: <1375359165-8411-1-git-send-email-balbi@ti.com> <1375359165-8411-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39564 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab3HANhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 09:37:50 -0400
Content-Disposition: inline
In-Reply-To: <1375359165-8411-4-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Frank Rowand <frank.rowand@am.sony.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 01, 2013 at 03:12:45PM +0300, Felipe Balbi wrote:
> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> The omap boot_lock is used by the secondary processor startup code.  The locking
> task is the idle thread, which has idle->sched_class == &idle_sched_class.
> idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
> lock, the attempt to wake it when the lock becomes available will fail:
> 
> try_to_wake_up()
>    ...
>       activate_task()
>          enqueue_task()
>             p->sched_class->enqueue_task(rq, p, flags)
> 
> Fix by converting boot_lock to a raw spin lock.
> 
> [ balbi@ti.com: taken from RT v3.10.4-rt1 patchset ]
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

There's a whole bunch of these, OMAP is not the only one.  If someone's
going to fix one case, the rest should also be fixed.  See:

arch/arm/mach-exynos/platsmp.c
arch/arm/mach-msm/platsmp.c
arch/arm/mach-prima2/platsmp.c
arch/arm/mach-spear/platsmp.c
arch/arm/mach-sti/platsmp.c
arch/arm/mach-ux500/platsmp.c
