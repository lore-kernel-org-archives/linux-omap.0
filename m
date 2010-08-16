From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH] PM: runtime PM + idle: allow usage when interrupts are disabled
Date: Mon, 16 Aug 2010 23:18:03 +0200
Message-ID: <201008162318.03923.rjw@sisk.pl>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45818 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313Ab0HPVTo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Aug 2010 17:19:44 -0400
In-Reply-To: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <tom.leiming@gmail.com>

On Tuesday, August 10, 2010, Kevin Hilman wrote:
> When using runtime PM in combination with CPUidle, the runtime PM
> transtions of some devices may be triggered during the idle path.
> Late in the idle sequence, interrupts will likely be disabled when
> runtime PM for these devices is initiated.
> 
> Currently, the runtime PM core assumes methods are called with
> interrupts enabled.  However, if it is called with interrupts
> disabled, the internal locking unconditionally enables interrupts, for
> example:
> 
> pm_runtime_put_sync()

Please don't use that from interrupt context.  There's pm_runtime_put()
exactly for this purpose that puts the _idle() call into a workqueue.

>     __pm_runtime_put()
>         pm_runtime_idle()
>             spin_lock_irq()
>             __pm_runtime_idle()
>                 spin_unlock_irq()   <--- interrupts unconditionally enabled

That's because __pm_runtime_idle() has to be called from process context.

>                 dev->bus->pm->runtime_idle()
>                 spin_lock_irq()
>              spin_unlock_irq()

Thanks,
Rafael
