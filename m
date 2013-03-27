From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 8/9] ARM: OMAP4: PM: Remove L4 wakeup depedency with MPU since errata fix exist now
Date: Wed, 27 Mar 2013 11:46:05 -0700
Message-ID: <874nfw7kb6.fsf@linaro.org>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
	<1361373527-21695-9-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:54069 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863Ab3C0SqJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 14:46:09 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so575483pdj.27
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 11:46:08 -0700 (PDT)
In-Reply-To: <1361373527-21695-9-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Wed, 20 Feb 2013 20:48:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> With commit bfd6d021 {ARM: OMAP3+: Implement timer workaround for errata
> i103 and i767}, the sync and gptimer synchronization errata got fixed.
>
> Hence the l4_wakeup static dependency with MPU can  can be removed
> now. Static dependency was one of the proposed workaround but from
> power savings perspective, it isn't an ideal workaround.
>
> Cc: Jon Hunter <jon-hunter@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Nice.

Acked-by: Kevin Hilman <khilman@linaro.org>

