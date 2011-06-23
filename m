From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 07/10] omap2+: Reserve clocksource and timesource and initialize dmtimer later
Date: Thu, 23 Jun 2011 10:13:05 -0700
Message-ID: <87ei2ka2u6.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092343.357.60445.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:46189 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932642Ab1FWRNI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 13:13:08 -0400
Received: by mail-pz0-f43.google.com with SMTP id 1so1435297pzk.30
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 10:13:07 -0700 (PDT)
In-Reply-To: <20110620092343.357.60445.stgit@kaulin> (Tony Lindgren's message
	of "Mon, 20 Jun 2011 02:23:43 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> There's no need to initialize the dmtimer framework early.
> Just mark the clocksource and timesource as reserved, and
> initialize dmtimer with an arch_initcall.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Also, when you are able to fully get rid of omap_dm_timer_init(), you
can probably remove it from dmtimer.h and make it static in dmtimer.c

Kevin
