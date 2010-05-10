From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Enable wakeup from ads7846 touchscreen
Date: Mon, 10 May 2010 09:40:34 -0700
Message-ID: <87bpcnk8vx.fsf@deeprootsystems.com>
References: <1273302561-27539-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42511 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121Ab0EJQkk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 12:40:40 -0400
Received: by vws17 with SMTP id 17so237039vws.19
        for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 09:40:39 -0700 (PDT)
In-Reply-To: <1273302561-27539-1-git-send-email-ranjithl@ti.com> (Ranjith Lohithakshan's message of "Sat\,  8 May 2010 12\:39\:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> This  patch enables the wakeup capabilities of ads7846 touchscreen driver.
> ads7846 driver can now wakeup the system from suspend on OMAP3430 EVM
> and SDP boards.
>
> The earlier approach of enabling wakeup on the touchscreen GPIO pin during
> board level mux init is removed. Instead the wakeup flag in
> ads7846_platform_data is enabled. Based on the flag, the ads7846 driver
> will do an enable_irq_wake which will eventually call into the OMAP GPIO
> layer and will enable the wakeup capability on the GPIO pin.
>
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
> This patch is tested on OMAP3 EVM and compile tested for OMAP3430 SDP.
> This patch has a dependency with the following patch
> https://patchwork.kernel.org/patch/96461/

Adding both of these to my PM queue for 2.6.35 (pm-next branch.)

Kevin
