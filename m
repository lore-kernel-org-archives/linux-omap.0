From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] arm: plat-omap: counter_32k: Fix build error due to IS_ERR
Date: Tue, 07 Dec 2010 13:04:56 -0800
Message-ID: <87fwu9l2fb.fsf@deeprootsystems.com>
References: <1291723777-27316-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38917 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab0LGVVp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 16:21:45 -0500
Received: by yxt3 with SMTP id 3so269581yxt.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 13:21:44 -0800 (PST)
In-Reply-To: <1291723777-27316-1-git-send-email-sourav.poddar@ti.com> (Sourav
	Poddar's message of "Tue, 7 Dec 2010 17:39:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Sourav Poddar <sourav.poddar@ti.com> writes:

> Fix the following build error by including linux/err.h
> arch/arm/plat-omap/counter_32k.c: In function 'omap_init_clocksource_32k':
> arch/arm/plat-omap/counter_32k.c:167: error: implicit declaration of
>                                       function 'IS_ERR'
>
> The above error is due to the following commit:
> subject: arm: plat-omap: counter_32k: use IS_ERR() instead of NULL check
> commit: 235fbace0334c846c21e902f330020122fc85955
>
> Created on linux-omap-2.6 branch: omap-fixes
>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> Reviewed-by: Charulatha V <charu@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Just noticed this one too.

Kevin
