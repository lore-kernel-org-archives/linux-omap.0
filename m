From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/19] ARM: OMAP: fix %d confusingly prefixed with 0x in
 format string
Date: Fri, 22 Aug 2014 16:04:56 -0700
Message-ID: <20140822230456.GK10066@atomide.com>
References: <1407111483-14512-1-git-send-email-hans@hanshq.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407111483-14512-1-git-send-email-hans@hanshq.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Wennborg <hans@hanshq.net>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Hans Wennborg <hans@hanshq.net> [140803 17:21]:
> Signed-off-by: Hans Wennborg <hans@hanshq.net>
> ---
>  arch/arm/mach-omap2/id.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index d42022f..53841de 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -663,7 +663,7 @@ void __init dra7xxx_check_revision(void)
>  
>  	default:
>  		/* Unknown default to latest silicon rev as default*/
> -		pr_warn("%s: unknown idcode=0x%08x (hawkeye=0x%08x,rev=0x%d)\n",
> +		pr_warn("%s: unknown idcode=0x%08x (hawkeye=0x%08x,rev=0x%x)\n",
>  			__func__, idcode, hawkeye, rev);
>  		omap_revision = DRA752_REV_ES1_1;
>  	}

Thanks applying into omap-for-v3.17/fixes.

Tony
