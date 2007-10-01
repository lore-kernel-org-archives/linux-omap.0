From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Set default OMAP2_CTRL_BASE for OMAP1
Date: Mon, 1 Oct 2007 11:05:05 -0700
Message-ID: <20071001180504.GM24656@atomide.com>
References: <46F00BB4.40403@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46F00BB4.40403@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [070918 10:33]:
>
> In case no OMAP2_CTRL_BASE is set, set default one to fix compilation
> errors e.g. for OMAP1.
>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

> Index: linux-osk/include/asm-arm/arch-omap/omap24xx.h
> ===================================================================
> --- linux-osk.orig/include/asm-arm/arch-omap/omap24xx.h
> +++ linux-osk/include/asm-arm/arch-omap/omap24xx.h
> @@ -103,6 +103,11 @@
>  
>  #endif
>  
> +#if !defined(OMAP2_CTRL_BASE)
> +/* If no one of the above configs is selected, use default */
> +#define OMAP2_CTRL_BASE		L4_24XX_BASE
> +#endif
> +
>  /* Control module */
>  #define OMAP2_CONTROL_DEVCONF0	(OMAP2_CTRL_BASE + 0x274)
>  #define OMAP2_CONTROL_DEVCONF1	(OMAP2_CTRL_BASE + 0x2e8)

Just for reference, this should not be needed any longer AFAIK.

Tony
