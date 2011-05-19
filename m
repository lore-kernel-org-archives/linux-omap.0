From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 05/10] OMAP2PLUS: GPIO: Use flag to identify wkup dmn GPIO
Date: Thu, 19 May 2011 18:34:15 +0200
Message-ID: <87ei3u7ipk.fsf@ti.com>
References: <1305546104-1511-1-git-send-email-tarun.kanti@ti.com>
	<1305546104-1511-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:39492 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933515Ab1ESQeV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 12:34:21 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so3094740wya.33
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:34:19 -0700 (PDT)
In-Reply-To: <1305546104-1511-6-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Mon, 16 May 2011 17:11:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Charulatha V <charu@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> In omap3, save/restore context is implemented for GPIO
> banks 2-6 as GPIO bank1 is in wakeup domain. Instead
> of identifying bank's power domain by bank id, make use
> of a flag "loses_context" which is filled by
> pwrdm_can_ever_lose_context() during dev_init.
>
> For getting the powerdomain pointer, omap_hwmod_get_pwrdm()
> is used. omap_device_get_pwrdm() could not be used as the
> pwrdm information needs to be filled in pdata, whereas
> omap_device_get_pwrdm() could be used only after
> omap_device_build() call.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>

Looks good.

Kevin
