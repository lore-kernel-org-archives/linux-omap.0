From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: powerdomain: fix typo: lose context --> loose
 context
Date: Thu, 21 Apr 2011 09:35:20 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104210851500.991@utopia.booyaka.com>
References: <1303345531-8435-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33276 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1DUPfV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 11:35:21 -0400
In-Reply-To: <1303345531-8435-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, charu@ti.com

Hi Kevin,

On Wed, 20 Apr 2011, Kevin Hilman wrote:

> Before we get any users of this function, fix the name (and comments)
> to use loose instead of lose.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies to v2.6.39-rc4
> 
>  arch/arm/mach-omap2/powerdomain.c |    6 +++---
>  arch/arm/mach-omap2/powerdomain.h |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 9af0847..ec3423f 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -960,18 +960,18 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
>  }
>  
>  /**
> - * pwrdm_can_ever_lose_context - can this powerdomain ever lose context?
> + * pwrdm_can_ever_loose_context - can this powerdomain ever loose context?

'lose' is correct in this case,. It's derived from the idiom 'context 
loss'.  more broadly, 'loose' implies a strong sense of agency on the part 
of whatever is doing the 'loosing,' whereas 'lose' does not (it's the PRCM 
that causes the powerdomain to lose context, not the powerdomain itself - 
the powerdomain's logic/memory context is subject to the PRCM's whim)

- Paul
