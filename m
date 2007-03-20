From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: 243x: Add mappings for SDRC and SMS
Date: Tue, 20 Mar 2007 14:20:06 -0400
Message-ID: <20070320182005.GG8596@atomide.com>
References: <20070314010641.009385000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070314010641.009385000@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070313 21:12]:
> Add mappings for SDRC ans SMS so that omap2_memory_init() works on the
> 2430.  This also allows the mpurate= command-line option to work.

> --- dev.orig/include/asm-arm/arch-omap/io.h
> +++ dev/include/asm-arm/arch-omap/io.h
> @@ -80,6 +80,13 @@
>  #define OMAP243X_GPMC_PHYS	OMAP243X_GPMC_BASE	/* 0x49000000 */
>  #define OMAP243X_GPMC_VIRT	0xFE000000
>  #define OMAP243X_GPMC_SIZE	SZ_1M
> +#define OMAP243X_SDRC_PHYS      OMAP24XX_SDRC_BASE
> +#define OMAP243X_SDRC_VIRT      0xFD000000
> +#define OMAP243X_SDRC_SIZE      SZ_1M
> +#define OMAP243X_SMS_PHYS       OMAP243X_SMS_BASE
> +#define OMAP243X_SMS_VIRT       0xFC000000
> +#define OMAP243X_SMS_SIZE       SZ_1M
> +
>  #endif
>  

Tabified these & pushing today.

Tony
