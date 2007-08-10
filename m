From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: Add camera block base address definition.
Date: Fri, 10 Aug 2007 03:17:32 -0700
Message-ID: <20070810101731.GW8658@atomide.com>
References: <11843157513870-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11843157513870-git-send-email-sakari.ailus@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Sakari Ailus <sakari.ailus@nokia.com> [070713 01:41]:
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  include/asm-arm/arch-omap/omap24xx.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/asm-arm/arch-omap/omap24xx.h b/include/asm-arm/arch-omap/omap24xx.h
> index 675b78f..e552ce8 100644
> --- a/include/asm-arm/arch-omap/omap24xx.h
> +++ b/include/asm-arm/arch-omap/omap24xx.h
> @@ -77,6 +77,9 @@
>  /* Mailbox */
>  #define OMAP24XX_MAILBOX_BASE	(L4_24XX_BASE + 0x94000)
>  
> +/* Camera */
> +#define OMAP24XX_CAMERA_BASE	(L4_24XX_BASE + 0x52000)
> +
>  #if defined(CONFIG_ARCH_OMAP2420)
>  
>  #define OMAP2_32KSYNCT_BASE	OMAP2420_32KSYNCT_BASE

Pushing today.

Tony
