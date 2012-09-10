From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Seeking clarity on IRQCHIP_MASK_ON_SUSPEND
Date: Mon, 10 Sep 2012 12:28:35 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1209101215300.2724@ionos>
References: <20120910165127.37dd07f3@notabene.brown>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49150 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab2IJK2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 06:28:38 -0400
In-Reply-To: <20120910165127.37dd07f3@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, lkml <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Mon, 10 Sep 2012, NeilBrown wrote:
> 
> The IRQCHIP_MASK_ON_SUSPEND flag seems to be hard to use correctly, so either
> I'm understanding it wrongly, or it could be made easier to use.
> If the first case, I'm hoping that some improvement to documentation might
> result.  If the second, then maybe we can fix the code.
... 
> Is anyone able to give a definitive answer on this?  Should
> IRQCHIP_MASK_ON_SUSPEND be removed?

The whole point of IRQCHIP_MASK_ON_SUSPEND is to deal with hardware
designed by geniuses.

Most SoCs have a way to mark the interrupts which serve as a wake up
source as such. All other interrupts are magically "masked" on entry
to suspend.

Now there is hardware which is missing such a control, so we need to
mask the non wakeup interrupts right before going into suspend.

That's what IRQCHIP_MASK_ON_SUSPEND does. Not more, not less. See
commit d209a699a0b for more ugly details.

You might be looking for a different functionality. Can you explain
what you need?

Thanks,

	tglx
