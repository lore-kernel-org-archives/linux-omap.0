From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: FLASH: Move Flash specific device info in a
	separate board file
Date: Fri, 23 Nov 2007 13:35:12 -0800
Message-ID: <20071123213512.GK559@atomide.com>
References: <AC2D475575504148943F5EB0938951C4012717DD@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <AC2D475575504148943F5EB0938951C4012717DD@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Choraria, Rohit" <rohitkc@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Choraria, Rohit <rohitkc@ti.com> [071120 06:24]:
> Hi,
> This patch moves the SDP3430 NOR and OneNAND devices to a new file
> board-3430sdp-flash.c. It also adds the support for ethernet on ES2 SDP.

<snip>

> --- linux-omap.orig/include/asm-arm/arch-omap/gpmc.h	2007-11-19 13:36:16.000000000 -0500
> +++ linux-omap/include/asm-arm/arch-omap/gpmc.h	2007-11-20 11:24:38.032203488 -0500
> @@ -14,6 +14,36 @@
>  /* Maximum Number of Chip Selects */
>  #define GPMC_CS_NUM		8
>  
> +#define GPMC_REVISION		0x00
> +#define GPMC_SYSCONFIG		0x10
> +#define GPMC_SYSSTATUS		0x14
> +#define GPMC_IRQSTATUS		0x18
> +#define GPMC_IRQENABLE		0x1C
> +#define GPMC_TIMEOUT_CTRL	0x40
> +#define GPMC_ERR_ADDRESS	0x44
> +#define GPMC_ERR_TYPE		0x48
> +#define GPMC_CONFIG		0x50
> +#define GPMC_STATUS		0x54
> +#define GPMC_PREFETCH_CONFIG1	0x1e0
> +#define GPMC_PREFETCH_CONFIG2	0x1e4
> +#define GPMC_PREFETCH_CONTROL	0x1e8
> +#define GPMC_PREFETCH_STATUS	0x1f0
> +#define GPMC_ECC_CONFIG		0x1F4
> +#define GPMC_ECC_CONTROL	0x1F8
> +#define GPMC_ECC_SIZE_CONFIG	0x1FC
> +#define GPMC_ECC1_RESULT	0x200
> +#define GPMC_ECC2_RESULT	0x204
> +#define GPMC_ECC3_RESULT	0x208
> +#define GPMC_ECC4_RESULT	0x20C
> +#define GPMC_ECC5_RESULT	0x210
> +#define GPMC_ECC6_RESULT	0x214
> +#define GPMC_ECC7_RESULT	0x218
> +#define GPMC_ECC8_RESULT	0x21C
> +#define GPMC_ECC9_RESULT	0x220
> +
> +#define GPMC_CS0_BASE		0x60
> +#define GPMC_CS_SIZE		0x30
> +
...

How about actually starting to use the generic gpmc code rather than
moving the defines around?

Tony
