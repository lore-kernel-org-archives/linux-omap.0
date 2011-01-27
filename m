From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/2] arch/arm/mach-omap2/dma.c: Convert IS_ERR result to
 PTR_ERR
Date: Thu, 27 Jan 2011 21:02:25 +0200
Message-ID: <20110127210225.07de155f.jhnikula@gmail.com>
References: <1296143347-17508-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1296143347-17508-1-git-send-email-julia@diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 27 Jan 2011 16:49:06 +0100
Julia Lawall <julia@diku.dk> wrote:

> diff -u -p a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
> --- a/arch/arm/mach-omap2/dma.c
> +++ b/arch/arm/mach-omap2/dma.c
> @@ -264,7 +264,7 @@ static int __init omap2_system_dma_init_
>  	if (IS_ERR(od)) {
>  		pr_err("%s: Cant build omap_device for %s:%s.\n",
>  			__func__, name, oh->name);
> -		return IS_ERR(od);
> +		return PTR_ERR(od);
>  	}
>  
FWIW,

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
