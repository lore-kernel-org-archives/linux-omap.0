From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/3] OMAP2+: hwmod: Fix what _init_clock returns
Date: Fri, 18 Feb 2011 15:51:42 +0100
Message-ID: <4D5E877E.5090600@ti.com>
References: <1297858285-7056-1-git-send-email-rnayak@ti.com> <1297858285-7056-2-git-send-email-rnayak@ti.com> <1297858285-7056-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52673 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab1BROvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 09:51:47 -0500
In-Reply-To: <1297858285-7056-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2/16/2011 1:11 PM, Nayak, Rajendra wrote:
> _init_clock always returns 0 and does
> not propogate the error (in case of failure)
> back to the caller, causing _init_clocks to
> fail silently.
>
> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index cd9dcde..960461f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -926,7 +926,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
>   	if (!ret)
>   		oh->_state = _HWMOD_STATE_CLKS_INITED;
>
> -	return 0;
> +	return ret;
>   }
>
>   /**

This is correct and that makes kerneldoc accurate : "Returns ... a 
non-zero error on failure."

I'll queue it for 2.6.39.

Thanks,
Benoit

