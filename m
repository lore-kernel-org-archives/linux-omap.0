From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 02 Feb 2012 10:38:31 -0800
Message-ID: <87ty39cc7s.fsf@ti.com>
References: <20120202093600.12509.35052.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:55555 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757092Ab2BBSi3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 13:38:29 -0500
Received: by mail-pw0-f50.google.com with SMTP id d12so3300620pbd.9
        for <linux-omap@vger.kernel.org>; Thu, 02 Feb 2012 10:38:28 -0800 (PST)
In-Reply-To: <20120202093600.12509.35052.stgit@dusk> (Paul Walmsley's message
	of "Thu, 02 Feb 2012 02:38:48 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com

Paul Walmsley <paul@pwsan.com> writes:

> Hi
>
> This series consolidates some duplicated PM code across OMAP2, 3, and 4.
> This saves both binary kernel image size, and lines of source.  These
> functions are just the low-hanging fruit; it looks to me like there's even
> more consolidation that could be done.
>
> Suspend + UART wakeup was tested on OMAP44xx BeagleBoard.  

I assume you meant Panda board?

> On the OMAP35xx Beagleboard here, v3.3-rc2 doesn't seem to wake up
> from suspend correctly with or without these patches, so I've only
> boot-tested them on that platform.

I also tested idle & suspend + UART wakeup on 3430/n900, 3530/Overo.

Will add these to my cleanup queue for v3.4[1] after adding a Tested-by
from Santosh.

Kevin

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cleanup/pm
