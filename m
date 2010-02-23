From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH V2] [PM-WIP-OPP]: Fixing wrong target level being passed during Core DVFS.
Date: Tue, 23 Feb 2010 10:37:14 -0800
Message-ID: <87fx4rztlx.fsf@deeprootsystems.com>
References: <1266944632-9744-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57234 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab0BWShT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 13:37:19 -0500
Received: by vws6 with SMTP id 6so504725vws.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Feb 2010 10:37:18 -0800 (PST)
In-Reply-To: <1266944632-9744-1-git-send-email-thara@ti.com> (Thara Gopinath's message of "Tue\, 23 Feb 2010 22\:33\:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

Thara Gopinath <thara@ti.com> writes:

> As per the current implementaion (u8*)&target_level is being passed
> to freq_to_opp in set_opp. This would result in updating just the first
> 8 bits of a u32 variable. Later target_level is passed to
> resource_set_opp_level as a u32 parameter. This maens
> a. Initially target_level was 0xabcdefgh.
> b. freq_to_opp updates the lower eight bits of target_level
> to 0xXX. Now target_level = 0xabcdefXX.
> c. We pass 0xabcdefXX as target_level to resource_set_opp_level
> when we want to pass just 0xXX.
> This is leading to some corrupted bookkeeping later on in the
> dvfs path.
>
> This patch ensures that target_level passed to resource_set_opp_level
> is actually the level that is intended by freq_to_opp API.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, applying to pm-wip-opp after cleaning up the formatting in the changelog
to be a little more readable.

Kevin

> ---
>  arch/arm/mach-omap2/resource34xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index 3604a38..2c850a2 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -478,6 +478,7 @@ int set_opp(struct shared_resource *resp, u32 target_level)
>  		/* uh uh.. no OPPs?? */
>  		BUG_ON(IS_ERR(oppx));
>  
> +		target_level = 0;
>  		ret = freq_to_opp((u8 *)&target_level, OPP_L3, req_l3_freq);
>  		/* we dont expect this to fail */
>  		BUG_ON(ret);
> -- 
> 1.5.4.7
