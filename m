From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] include/asm-arm/arch-omap/omap24xx.h
Date: Thu, 25 Oct 2007 17:28:42 +0200
Message-ID: <4720B62A.1010406@googlemail.com>
References: <ae36f8040710240958l579ad5el16f17cb073e25387@mail.gmail.com>
	<471F868A.3060106@googlemail.com>
	<20071025053143.222542615@pwsan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20071025053143.222542615@pwsan.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Paul Walmsley wrote:
> Hello Dirk, Luis, 
> 
> how about the patch (following in the next message) instead?  That way
> we don't define OMAP2_CTRL_BASE for non-OMAP2 builds. 

Mmh, I like to fix it in include/asm-arm/arch-omap/omap24xx.h, so I 
prefer [1].

The issue was introduced by

http://linux.omap.com/pipermail/linux-omap-open-source/2007-August/011159.html

With [1] we

- fix it where it was introduced
- have an additional #ifdef only in a header file instead of 
plat-omap/devices.c, which is IMHO better
- fix it for everybody now and in the future who directly or 
indirectly includes omap24xx.h.

Regards

Dirk

[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2007-October/011720.html

> - Paul
>>From paul@pwsan.com Wed Oct 24 23:36:10 2007
> Message-Id: <20071025053610.715631084@pwsan.com>
> User-Agent: quilt/0.46-1
> Date: Wed, 24 Oct 2007 23:31:44 -0600
> From: Paul Walmsley <paul@pwsan.com>
> To: lvcargnini@gmail.com,
>  dirk.behme@googlemail.com,
>  tony@atomide.com
> Cc: linux-omap-open-source@linux.omap.com
> Bcc:  <471F868A.3060106@googlemail.com>
> Subject: fix undeclared OMAP2_CTRL_BASE for OMAP MMC driver in OMAP1 compiles
> References: <ae36f8040710240958l579ad5el16f17cb073e25387@mail.gmail.com>
>     <471F868A.3060106@googlemail.com>
>  <20071025053143.222542615@pwsan.com>
> Content-Disposition: inline; filename=fix_omap2_ctrl_base_mmc_compile_bug.patch
> Replace-Subject: fix undeclared OMAP2_CTRL_BASE for OMAP MMC driver in OMAP1 compiles
> 
> Remove reference to OMAP2_CTRL_BASE in arch/arm/plat-omap/devices.c
> if we aren't building for an OMAP2 platform.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  arch/arm/plat-omap/devices.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-omap/arch/arm/plat-omap/devices.c
> ===================================================================
> --- linux-omap.orig/arch/arm/plat-omap/devices.c	2007-08-29 13:53:47.000000000 -0600
> +++ linux-omap/arch/arm/plat-omap/devices.c	2007-10-24 23:29:51.000000000 -0600
> @@ -339,6 +339,7 @@
>  				omap_cfg_reg(MMC_DAT3);
>  			}
>  		}
> +#if defined(CONFIG_ARCH_OMAP24XX)
>  		if (mmc->internal_clock) {
>  			/*
>  			 * Use internal loop-back in MMC/SDIO
> @@ -350,6 +351,7 @@
>  				omap_writel(v, OMAP2_CONTROL_DEVCONF);
>  			}
>  		}
> +#endif
>  		mmc1_conf = *mmc;
>  		(void) platform_device_register(&mmc_omap_device1);
>  	}
> 
