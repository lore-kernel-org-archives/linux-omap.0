From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 4/4] ARM: OMAP2+: Fix sparse warnings in timer.c
Date: Thu, 29 Nov 2012 10:46:38 +0530
Message-ID: <50B6EFB6.1060103@ti.com>
References: <1354140300-16825-1-git-send-email-jon-hunter@ti.com> <1354140300-16825-5-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37048 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab2K2FQU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 00:16:20 -0500
In-Reply-To: <1354140300-16825-5-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Hiremath <hvaibhav@ti.com>

On Thursday 29 November 2012 03:35 AM, Jon Hunter wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> Sparse generates the following warnings when compiling mach-omap2/timer.c.
>
>    CHECK   arch/arm/mach-omap2/timer.c
>    arch/arm/mach-omap2/timer.c:193:13: warning: symbol 'omap_dmtimer_init'
>    was not declared. Should it be static?
>    arch/arm/mach-omap2/timer.c:213:12: warning: symbol
>    'omap_dm_timer_get_errata' was not declared. Should it be static?
>
> Add static to function declaration to fix warnings.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

