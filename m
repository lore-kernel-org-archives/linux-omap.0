From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v9 REPOST 00/25] gpio/omap: driver cleanup and fixes
Date: Mon, 09 Jan 2012 16:57:24 -0800
Message-ID: <87ty44wf0r.fsf@ti.com>
References: <1325002176-25626-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:34264 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751862Ab2AJA52 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 19:57:28 -0500
Received: by mail-gy0-f169.google.com with SMTP id r18so2112209ghr.0
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 16:57:27 -0800 (PST)
In-Reply-To: <1325002176-25626-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 27 Dec 2011 21:39:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tarun,

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.

Since this is now a "real" driver under drivers, please repost this
including the GPIO maintainer (Grant Likely <grant.likely@secretlab.ca>)
and LKML.

Also, for ease of testing with all the other OMAP features that are
already queued for upstream, please rebase on top of Tony's 'uart'
branch.

After the above, I will do some final testing and queue a branch for
Grant, but it's too late for the v3.3 merge window, but we'll get this
into v3.4.  We'll also get it into Tony's "testing" branch so it can see
some broader testing as well.

Thanks,

Kevin
