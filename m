From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: Remove useless Makefile line
Date: Mon, 8 Apr 2013 14:46:42 -0700
Message-ID: <20130408214640.GB10155@atomide.com>
References: <1365156992.1830.63.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365156992.1830.63.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Paul Bolle <pebolle@tiscali.nl> [130405 03:21]:
> Merge commit 952414505f55afe5cd6dc004765076aa22b3ed7e ("Merge branch
> 'next/cleanup' of git://git.linaro.org/people/arnd/arm-soc") added
> references to CONFIG_MACH_PCM049 and board-omap4pcm049.o to this
> Makefile. But there's no Kconfig symbol MACH_PCM049 and there's no file
> board-omap4pcm049.c. This line can safely be removed.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Note that MACH_PCM049 was removed from mach-types in v3.5.
> 
>  arch/arm/mach-omap2/Makefile | 2 --
>  1 file changed, 2 deletions(-)

Thanks applying into omap-for-v3.10/board.

Tony
 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 3d0697c..62bb352 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -254,8 +254,6 @@ obj-$(CONFIG_MACH_TOUCHBOOK)		+= board-omap3touchbook.o
>  obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
>  obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o
>  
> -obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o
> -
>  obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
>  
>  obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
> -- 
> 1.7.11.7
> 
