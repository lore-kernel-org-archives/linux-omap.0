From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 04/15] OMAP2PLUS: GPIO: Use flag to identify wkup dmn GPIO
Date: Wed, 25 May 2011 14:40:48 -0700
Message-ID: <87ei3msbkv.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:35909 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755820Ab1EYVky (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 17:40:54 -0400
Received: by pwj3 with SMTP id 3so124946pwj.1
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 14:40:50 -0700 (PDT)
In-Reply-To: <1306247094-25372-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

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

Looks good.

Kevin
