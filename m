From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/4] OMAP2+: clockdomain: Add an api to read idle mode
Date: Tue, 05 Apr 2011 19:09:56 +0530
Message-ID: <4D9B1BAC.3090700@ti.com>
References: <1302007497-10525-1-git-send-email-rnayak@ti.com> <1302007497-10525-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54036 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751996Ab1DENkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 09:40:20 -0400
Received: by gwb1 with SMTP id 1so203573gwb.22
        for <linux-omap@vger.kernel.org>; Tue, 05 Apr 2011 06:40:18 -0700 (PDT)
In-Reply-To: <1302007497-10525-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On 4/5/2011 6:14 PM, Rajendra Nayak wrote:
> Add a clockdomain api to check if hardware supervised
> idle transitions are enabled on a clockdomain.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/clockdomain.c |   21 +++++++++++++++++++++
>   arch/arm/mach-omap2/clockdomain.h |    3 +++
>   2 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
> index ab87854..1de6def 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -795,6 +795,27 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
>   	arch_clkdm->clkdm_deny_idle(clkdm);
>   }
>
> +/**
> + * clkdm_is_idle - Check if the clkdm hwsup/autoidle is enabled
> + * @clkdm: struct clockdomain *
> + *
> + * Returns true if the clockdomain is in hardware-supervised
> + * idle mode, or 0 otherwise.
> + *
> + */
> +int clkdm_is_idle(struct clockdomain *clkdm)
 >
Name of the API not seems to fit correctly.
Shoule it be something like "clkdm_is_in_hwsup"?
