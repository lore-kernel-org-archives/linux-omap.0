From: David Brown <davidb@quicinc.com>
Subject: Re: [PATCH 1/5] ARM: smp: Select local timers vs dummy timer support runtime
Date: Mon, 14 Feb 2011 20:13:07 -0800
Message-ID: <8ya1v3aey0c.fsf@huya.qualcomm.com>
References: <1297510187-31547-1-git-send-email-santosh.shilimkar@ti.com>
	<1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:22371 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1BOENI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 23:13:08 -0500
In-Reply-To: <1297510187-31547-2-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 12 Feb 2011 16:59:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Russell King <linux@arm.linux.org.uk>, Daniel Walker <dwalker@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Colin Cross <ccross@android.com>, Erik Gilling <konkers@android.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

On Sat, Feb 12 2011, Santosh Shilimkar wrote:

> The current code support of dummy timers in absence of local
> timer is compile time. This is an attempt to convert it to runtime
> so that on few SOC version if the local timers aren't supported
> kernel can switch to dummy timers. OMAP4430 ES1.0 does suffer from
> this limitation.
>
> This patch should not have any functional impact on affected
> files.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-msm/timer.c           |    3 ++-

Acked-By: David Brown <davidb@codeaurora.org>

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
