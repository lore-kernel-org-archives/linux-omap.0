From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: remove duplicated declaration of
 omap4430_init_late
Date: Fri, 26 Oct 2012 12:14:55 -0700
Message-ID: <20121026191455.GQ11908@atomide.com>
References: <1351272589-9885-1-git-send-email-const@MakeLinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351272589-9885-1-git-send-email-const@MakeLinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Constantine Shulyupin <const@MakeLinux.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Constantine Shulyupin <const@MakeLinux.com> [121026 10:31]:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> Problem:
> Function omap4430_init_late is declared twice in arch/arm/mach-omap2/common.h.
> Fix: remove out of order declaration, assuming all functions ordered accordingly processor number.
>  
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Thanks, applying into omap-for-v3.7-rc2/fixes-part2-take3.

Regards,

Tony

> ---
>  arch/arm/mach-omap2/common.h |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 7045e4d..45478d1 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -152,7 +152,6 @@ void am33xx_init_early(void);
>  void omap4430_init_early(void);
>  void omap5_init_early(void);
>  void omap3_init_late(void);	/* Do not use this one */
> -void omap4430_init_late(void);
>  void omap2420_init_late(void);
>  void omap2430_init_late(void);
>  void omap3430_init_late(void);
> -- 
> 1.7.9.5
> 
