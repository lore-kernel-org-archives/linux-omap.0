From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC] omap: mux: add support for selecting mpu_irq for each wakeup pad
Date: Mon, 07 Nov 2011 16:17:55 -0800
Message-ID: <87wrbbqxfw.fsf@ti.com>
References: <1319803425-13154-1-git-send-email-t-kristo@ti.com>
	<1319803425-13154-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46799 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750871Ab1KHAR7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 19:17:59 -0500
Received: by mail-gy0-f174.google.com with SMTP id 15so6697734gyc.33
        for <linux-omap@vger.kernel.org>; Mon, 07 Nov 2011 16:17:58 -0800 (PST)
In-Reply-To: <1319803425-13154-2-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 28 Oct 2011 15:03:45 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Tero Kristo <t-kristo@ti.com> writes:

> By default all registered pads will trigger mpu_irqs[0]. Now there is
> an API for selecting used mpu_irq on pad basis, which can be used to
> trigger different irq handlers for different pads in the same hwmod.
> Each pad that requires its interrupt to be re-routed this way must
> have a separate call to omap_hwmod_pad_route_irq(hwmod, pad, irq).
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

FWIW, I like this approach.

Kevin
