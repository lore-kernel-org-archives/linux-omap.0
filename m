From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP2+: hwmod: incorrect computation of autoidle_mask
Date: Mon, 3 Jan 2011 15:42:16 +0100
Message-ID: <4D21E048.2040005@ti.com>
References: <1294091991-2078-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56795 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754818Ab1ACOm3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jan 2011 09:42:29 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p03EgKbg009412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 3 Jan 2011 08:42:26 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p03EgJl4001298
	for <linux-omap@vger.kernel.org>; Mon, 3 Jan 2011 08:42:19 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p03EgJRF005614
	for <linux-omap@vger.kernel.org>; Mon, 3 Jan 2011 08:42:19 -0600 (CST)
In-Reply-To: <1294091991-2078-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tarun,

On 1/3/2011 10:59 PM, DebBarma, Tarun Kanti wrote:
> Autoidle is just a single bit setting across OMAP platforms.
> In _set_module_autoidle() I am seeing 0x3 where the mask is
> computed. I believe this should be 0x1.

Just a minor comment; it looks from this description that you are not 
100% sure it is a bug :-)
You need to refer to the various TRMs, stating that this is indeed a bug 
for all OMAPs!

Adding a "fix" in the subject seems more accurate to describe the patch.
OMAP2+: Fix incorrect computation of autoidle_mask

Since is it harmless for the moment, I think it will probably go for 2.6.39.

> Baseline:
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
> Tested Info:
> Boot tested on OMAP 2/3/4.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Acked-by: Rajendra Nayak<rnayak@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>


Thanks,
Benoit

> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 5a30658..da49b56 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -373,7 +373,7 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
>   	}
>
>   	autoidle_shift = oh->class->sysc->sysc_fields->autoidle_shift;
> -	autoidle_mask = (0x3<<  autoidle_shift);
> +	autoidle_mask = (0x1<<  autoidle_shift);
>
>   	*v&= ~autoidle_mask;
>   	*v |= autoidle<<  autoidle_shift;

