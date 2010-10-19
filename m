From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Tue, 19 Oct 2010 22:58:27 +0200
Message-ID: <201010192258.27988.arnd@arndb.de>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com> <AANLkTimDdPUjo+65vBL0PTQ3b=5NpeVT28XrdkYqx3Ex@mail.gmail.com> <AANLkTinNfERyi_bTWc7LOKR1uRLC3E612ubFKBLxWB1E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64118 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757629Ab0JSU6b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 16:58:31 -0400
In-Reply-To: <AANLkTinNfERyi_bTWc7LOKR1uRLC3E612ubFKBLxWB1E@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Grant Likely <grant.likely@secretlab.ca>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Simon Que <sque@ti.com>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

On Tuesday 19 October 2010 22:43:34 Ohad Ben-Cohen wrote:
> > Disabling irqs might be a concern as a source of RT latency.  It
> > might be better to make the caller responsible for managing local spin
> > locks and irq disable/enable.
> 
> This a coming from an hardware requirement, rather than a choice the
> user should take.
> 
> If a hwspinlock is taken over a long period of time, its other user
> (with which we try to achieve synchronization) might be polling the
> OMAP interconnect for too long (trying to take the hwspinlock) and
> thus preventing it to be used for other transactions.

This sounds exactly like any other spinlock.

> To prevent such lengthy polling on the interconnect, the hwspinlock
> should only be used for very short period of times, with preemption
> and interrupts disabled.

Interrupts disabled in general might go a bit too far -- they are also
short and infrequent events unless you have seriously broken drivers.

When running with CONFIG_PREEMPT, I would guess you actually want to
turn the omap_hwspinlock into a sleeping operation, though that would
require much extra work to implement. Disabling preemption while the
hwspinlock is held is of course a correct implementation technically,
but it might not be what someone enabling CONFIG_PREEMPT expects.

> That's why we don't give users the choice whether to disable
> interrupts or not - it's simply not a decision they should take.

What about those cases where you already know that interrupts are
disabled, e.g. while holding a regular spin_lock_irq or inside
of an interrupt handler?

	Arnd
