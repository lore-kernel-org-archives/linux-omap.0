From: Tony Lindgren <tony@atomide.com>
Subject: Re: twl3040-gpio: fix task softlockup warning
Date: Tue, 19 Aug 2008 09:26:43 +0300
Message-ID: <20080819062641.GE17276@atomide.com>
References: <20080818155457.1371.38168.sendpatchset@localhost.localdomain> <20080819091935.9dee82d8.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59325 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbYHSG0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 02:26:46 -0400
Content-Disposition: inline
In-Reply-To: <20080819091935.9dee82d8.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080819 09:22]:
> On Mon, 18 Aug 2008 18:54:57 +0300
> "ext Artem Bityutskiy" <Artem.Bityutskiy@nokia.com> wrote:
> 
> > This patch fixes the following annoying warning:
> > 
> > INFO: task twl4030 gpio:283 blocked for more than 120 seconds.
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> > message. twl4030 gpio  D c027e9dc     0   283      2
> > [<c027e744>] (schedule+0x0/0x314) from [<c00640f0>] (kthread
> > +0x3c/0x80) [<c00640b4>] (kthread+0x0/0x80) from [<c0052678>] (do_exit
> > +0x0/0x664) r5:00000000 r4:00000000
> > 
> > Which is printed every 120 seconds by the softlockup code (see
> > 'check_hung_task()' function, introduced by on Jan 2008 by commit
> > 82a1fcb90287052aabfa235e7ffc693ea003fe69).
> > 
> > The reason is that the "twl4030 gpio" kthread is created but is not
> > started immediatelly. And in fact it may never start, because TWL3040
> > interrupts may never happen and hence, the
> > 'twl4030_gpio_unmask_irqchip()' function is never run. This makes the
> > softlockup detection code unhappy.
> > 
> > Fix this by running the "twl4030 gpio" kernel thread in at the end of
> > the 'gpio_twl4030_init()' initialization function. Since the
> > 'gpio_pending_unmask' global variable is 0 at that time, the tread
> > ('twl4030_gpio_unmask_thread()') will effectively do nothing and go
> > sleep. This makes the softlocup detection code happy.
> > 
> This is good. It fixes also second issue where system load average is
> always above 1 since task is in uninterruptible state before this first
> wake-up.

Great, thanks Artem, will push your patch today.

Tony
