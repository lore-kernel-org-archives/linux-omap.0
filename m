From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 05/15] OMAP: GPIO: Make gpio_context part of gpio_bank structure
Date: Wed, 25 May 2011 14:41:41 -0700
Message-ID: <87aaeasbje.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-6-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:53034 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756483Ab1EYVlp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 17:41:45 -0400
Received: by pxi10 with SMTP id 10so59552pxi.8
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 14:41:44 -0700 (PDT)
In-Reply-To: <1306247094-25372-6-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> gpio_context array, which is used to save gpio bank's context,
> is used only for OMAP3 architecture.
>
> Move gpio_context as part of gpio_bank structure so that
> it can be specific to each gpio bank and can be used for
> any OMAP architecture
>
> TODO: extend the gpio save/restore context function for OMAP4
> architecture. This is done in one of the next patches in this
> series
>
> Signed-off-by: Charulatha V <charu@ti.com>

Looks good.

Kevin
