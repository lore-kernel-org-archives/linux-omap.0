From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 05/25] OMAP4: Use WARN_ON() instead of BUG_ON() with graceful
 exit
Date: Mon, 05 Sep 2011 14:11:12 +0400
Message-ID: <4E64A040.4000801@ru.mvista.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38689 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab1IEKL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 06:11:57 -0400
Received: by wyh22 with SMTP id 22so3494798wyh.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Sep 2011 03:11:56 -0700 (PDT)
In-Reply-To: <1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, rnayak@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org

Hello.

On 04-09-2011 17:54, Santosh Shilimkar wrote:

> OMAP4 L2X0 initialisation code uses BUG_ON() for the ioremap()
> failure scenarios.

> Use WARN_ON() instead and allow graceful function exits.

> This was suggsted by Kevin Hilman<khilman@ti.com>  during
> OMAP4 PM code review.

> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/omap4-common.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 4791370..4904025 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -121,7 +121,8 @@ static int __init omap_l2_cache_init(void)
>
>   	/* Static mapping, never released */
>   	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
> -	BUG_ON(!l2cache_base);
> +	if (WARN_ON(!l2cache_base))
> +		return -ENODEV;

    Rather ENOMEM...

WBR, Sergei
