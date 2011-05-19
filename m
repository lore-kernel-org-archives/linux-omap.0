From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 02/10] ZOOM: QUART: Request reset GPIO
Date: Thu, 19 May 2011 18:11:41 +0200
Message-ID: <87ipt67jr6.fsf@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
	<1305546104-1511-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:35650 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754532Ab1ESQLy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 12:11:54 -0400
Received: by wyi11 with SMTP id 11so2468873wyi.12
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:11:44 -0700 (PDT)
In-Reply-To: <1305546104-1511-3-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Mon, 16 May 2011 17:11:36 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Reset GPIO (OMAP_GPIO_152) for QUART in zoom2/zoom3 debug-board is
> not requested at all. This would lead to problems if this GPIO is
> wrongly requested. Hence request OMAP GPIO 152 for QUART RESET but
> do not apply a reset pulse as it would reset QUART and
> disturb the QUART settings.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

This is a bug fix that should be separated from this series, and sent to
l-o as a fix.  Also, please Cc linux-arm-kernel.

Feel free to add

Acked-by: Kevin Hilman <khilman@ti.com>

Thanks,

Kevin 
