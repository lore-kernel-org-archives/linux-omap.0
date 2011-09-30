From: Kevin Hilman <khilman@ti.com>
Subject: Re: ARM SoC tree: OMAP PM dependency on tip irq/core
Date: Fri, 30 Sep 2011 15:29:07 -0700
Message-ID: <87k48pfyvg.fsf@ti.com>
References: <87aa9mm8ts.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40693 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753926Ab1I3W3L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 18:29:11 -0400
Received: by yxi19 with SMTP id 19so2395265yxi.0
        for <linux-omap@vger.kernel.org>; Fri, 30 Sep 2011 15:29:09 -0700 (PDT)
In-Reply-To: <87aa9mm8ts.fsf@ti.com> (Kevin Hilman's message of "Fri, 30 Sep
	2011 06:57:35 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

Hi Arnd,

Kevin Hilman <khilman@ti.com> writes:

> The upcoming OMAP4 PM series from Santosh[1] that we're planning to
> queue for v3.2 has a dependency[2] on a patch currently queued for v3.2
> in the irq/core branch of Thomas' tip tree[3].
>
> In the past, I noticed you merged external trees like this to solve
> dependencies.
>
> Could you pull the irq/core branch into your tree to meet this
> dependency?

On second thought, since Santosh's branch is the only one with this
dependency (and we also have a dependency on Russell's devel-stable)
I'll just build up a branch for Santosh's series that includes
rmk/devel-stable and tglx/irq-core.

You (or Tony) can then pull this one instead of manually managing the
dependencies.

Kevin
