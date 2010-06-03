From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 3/9] OMAP2/3/4 : Dual mode timer device registration.
Date: Thu, 03 Jun 2010 16:24:41 -0700
Message-ID: <87eignk8cm.fsf@deeprootsystems.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
	<1275143831-7629-2-git-send-email-thara@ti.com>
	<1275143831-7629-3-git-send-email-thara@ti.com>
	<1275143831-7629-4-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50352 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654Ab0FCXYo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 19:24:44 -0400
Received: by pwj2 with SMTP id 2so315218pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 16:24:44 -0700 (PDT)
In-Reply-To: <1275143831-7629-4-git-send-email-thara@ti.com> (Thara Gopinath's message of "Sat\, 29 May 2010 20\:07\:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch converts OMAP2/OMAP3/OMAP4 dual mode timers into
> platform devices using omap hwmod, omap device and runtime pm frameworks.
> This patch also allows GPTIMER1 and GPTIMER2 to be registered as
> early devices. This will allow GPTIMER1 to be registered as
> system timer very early on in the system boot up sequence.
> Later during normal plaform_device_register these are converted
> to normal platform device.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

[...]

> +#define OMAP2_DM_TIMER_COUNT		12
> +#define OMAP3PLUS_DM_TIMER_COUNT	11

Also, I noticed this patch drops support for handling GPT12, but is
not explained in the changelog or in PATCH 0/x description.

Kevin
