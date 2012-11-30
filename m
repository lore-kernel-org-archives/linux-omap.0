From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/3] omap late timer clean-up (and a warning fix)
 for v3.8 merge window
Date: Fri, 30 Nov 2012 09:28:33 -0800
Message-ID: <20121130172833.GJ5312@atomide.com>
References: <50b41207.c188e50a.6d1e.ffffd469SMTPIN_ADDED_BROKEN@mx.google.com>
 <20121130071833.GD6899@quad.lixom.net>
 <50B868A1.2090001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:59109 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753463Ab2K3R2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Nov 2012 12:28:38 -0500
Content-Disposition: inline
In-Reply-To: <50B868A1.2090001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [121130 00:06]:
> Olof,
> 
> On Friday 30 November 2012 12:48 PM, Olof Johansson wrote:
> >On Mon, Nov 26, 2012 at 05:06:11PM -0800, Tony Lindgren wrote:
> >>The following changes since commit 9dc57643738f9fbe45c10cc062903d5dfda5bdd9:
> >>
> >>   Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer (2012-11-13 13:52:38 -0800)
> >>
> >>are available in the git repository at:
> >>
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-timer-signed
> >>
> >>for you to fetch changes up to 26f01998b0657a61167a819f1c37cb9f9e9d674b:
> >>
> >>   ARM: OMAP3: cm-t3517: use GPTIMER for system clock (2012-11-21 10:20:43 -0800)
> >
> >By the way, I had to apply the following fixup on top of this (in next/cleanup)
> >to fix a compilation failure. Seems to be caused by "ARM: OMAP2+: timer: remove
> >CONFIG_OMAP_32K_TIMER" from Igor.

Yes thanks.

> There was similar patch [1] like yours from Jon to fix above build
> break.

There's also few more fixes that I'll queue once these pending
branches are merged.

Regards,

Tony
 
> [1] http://www.spinics.net/lists/linux-omap/msg83260.html
