From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: fix uninitialized warning
Date: Fri, 10 Oct 2008 14:42:01 +0300
Message-ID: <20081010114201.GW3044@atomide.com>
References: <1223552280-14373-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62975 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbYJJLmG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 07:42:06 -0400
Content-Disposition: inline
In-Reply-To: <1223552280-14373-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [081009 14:38]:
> warning: 'rev_name' may be used uninitialized in this function

Pushing.

Tony

> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/mach-omap2/id.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 7a7ad18..c002076 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -147,7 +147,7 @@ void __init omap34xx_check_revision(void)
>  	u32 cpuid, idcode;
>  	u16 hawkeye;
>  	u8 rev;
> -	char *rev_name;
> +	char *rev_name = "ES1.0";
>  
>  	/*
>  	 * We cannot access revision registers on ES1.0.
> @@ -157,7 +157,6 @@ void __init omap34xx_check_revision(void)
>  	cpuid = read_cpuid(CPUID_ID);
>  	if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
>  		system_rev = OMAP3430_REV_ES1_0;
> -		rev_name = "ES1.0";
>  		goto out;
>  	}
>  
> -- 
> 1.6.0.2.229.g1293c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
