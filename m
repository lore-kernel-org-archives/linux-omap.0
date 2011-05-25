From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 11/15] OMAP: GPIO: Remove hardcoded offsets in ctxt save/restore
Date: Wed, 25 May 2011 16:01:10 -0700
Message-ID: <871uzmo05l.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-12-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:49138 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752667Ab1EYXBO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:01:14 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so95851pxi.24
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:01:13 -0700 (PDT)
In-Reply-To: <1306247094-25372-12-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> It is not required to use hard-coded offsets any more in context
> save and restore functions and instead use the generic offsets
> which have been correctly initialized during device registration.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks good.

I suggest you move this and all the other patches that just change to using
regsister offsets earlier in the series.

Kevin
