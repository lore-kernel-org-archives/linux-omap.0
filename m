From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 07/10] OMAP: GPIO: cleanup suspend and resume functions
Date: Thu, 19 May 2011 18:08:02 +0200
Message-ID: <87vcx67jx9.fsf@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
	<1305546104-1511-8-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38262 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932238Ab1ESQIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 12:08:11 -0400
Received: by mail-wy0-f181.google.com with SMTP id 11so2692456wyi.40
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:08:09 -0700 (PDT)
In-Reply-To: <1305546104-1511-8-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Mon, 16 May 2011 17:11:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Since wake_status, wake_clear, wake_set is common for all banks on a given
> OMAP version it is enough to get their values once during probe().
> Also, register offsets are already initialzed according to OMAP versions
> during device registration. We no longer need these explicit checks.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Great!

Kevin 
