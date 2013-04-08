From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/3] omap timer changes for v3.10 merge window
Date: Mon, 8 Apr 2013 10:46:49 -0700
Message-ID: <20130408174648.GS10155@atomide.com>
References: <0LdWUM-1V6HSB0nzO-00i0Xm@mx.kundenserver.de>
 <201304081940.12773.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44295 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935152Ab3DHRqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:46:54 -0400
Content-Disposition: inline
In-Reply-To: <201304081940.12773.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [130408 10:45]:
> On Thursday 04 April 2013, Tony Lindgren wrote:
> >  arch/arm/mach-omap2/board-cm-t3517.c |   2 +-
> >  arch/arm/mach-omap2/board-generic.c  |   2 +-
> >  arch/arm/mach-omap2/common.h         |   3 +-
> >  arch/arm/mach-omap2/timer.c          | 124 ++++++++++++++++++-----------------
> >  4 files changed, 66 insertions(+), 65 deletions(-)
> 
> BTW, do you have any plans to move the timer.c file to drivers/clocksource?
> 
> I think that's where most of them are heading now.

Yes that's the plan.

With the various patches posted at least the timer code
GPMC code should be very close to being movable. And the
mailbox code is getting moved to drivers based on the pull
request I saw for that few days ago.

Regards,

Tony
