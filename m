From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [GIT PULL 4/4] GIC crossbar support for v3.14 merge window
Date: Tue, 14 Jan 2014 14:40:04 -0800
Message-ID: <87r48a5gsb.fsf@linaro.org>
References: <20140109011940.GI31323@atomide.com>
	<20140109012215.GL31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:41122 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbaANWkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Jan 2014 17:40:07 -0500
Received: by mail-pd0-f179.google.com with SMTP id y10so251683pdj.38
        for <linux-omap@vger.kernel.org>; Tue, 14 Jan 2014 14:40:06 -0800 (PST)
In-Reply-To: <20140109012215.GL31323@atomide.com> (Tony Lindgren's message of
	"Wed, 8 Jan 2014 17:22:16 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit 413541dd66d51f791a0b169d9b9014e4f56be13c:
>
>   Linux 3.13-rc5 (2013-12-22 13:08:32 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/crossbar-signed
>
> for you to fetch changes up to 70d4545544853e2d95909b919d4565ff32c3e3c5:
>
>   ARM: DRA: Enable Crossbar IP support for DRA7XX (2014-01-08 09:21:42 -0800)
>
> ----------------------------------------------------------------
> Add support for GIC crossbar that routes interrupts on newer omaps.
>
> ----------------------------------------------------------------

I think this one is a little late for v3.14 also, and should spend some
more time in -next before v3.15.  Also...

> Sricharan R (4):
>       irqchip: irq-gic: Add support for routable irqs

... I see a Reviewed-by from tglx on this one...
        
>       irqchip: crossbar: Add support for Crossbar IP

...but no signs of irqchip mainainer review/ack on this one.

Ideally, these two irqchip ones would be merged through the irqchip
maintainers...

>       ARM: OMAP4+: Correct Wakeup-gen code to use physical irq number
>       ARM: DRA: Enable Crossbar IP support for DRA7XX

.. and then we'd take these two through arm-soc.

If there are strong dependencies, we can take them all through arm-soc,
but I'd like to see the tags from the irqchip maintainers first.

Kevin
