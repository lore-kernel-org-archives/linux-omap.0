From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] update board 2430 file for TWL PIH interrupts
Date: Mon, 11 Dec 2006 13:53:37 -0800
Message-ID: <20061211215336.GK6693@atomide.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE19@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBE0207EE19@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Syed Mohammed, Khasim <x0khasim@ti.com> [061203 12:42]:
> Hi,
> 
>  
> 
> The attached patch updates the board 2430 file to handle TWL PIH
> interrupts.
> 
>  
> 
> Regards,
> 
> Khasim
> 

Content-Description: board2430_twlirq.patch
> This patch updates the board-2430sdp.h for TWL PIH interrupts.
> 
> Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>
> 
> Files Changed:
>  board-2430sdp.h |    7 +++++++
>  1 files changed, 7 insertions(+)
> 
> =============================================================================
> diff -purN linux-omap/include/asm-arm/arch-omap/board-2430sdp.h devpt_branch/include/asm-arm/arch-omap/board-2430sdp.h
> --- linux-omap/include/asm-arm/arch-omap/board-2430sdp.h	2006-11-20 21:56:58.000000000 -0600
> +++ devpt_branch/include/asm-arm/arch-omap/board-2430sdp.h	2006-12-03 13:30:59.000000000 -0600
> @@ -34,6 +34,13 @@
>  #define OMAP24XX_ETHR_GPIO_IRQ		149
>  #define SDP2430_CS0_BASE		0x04000000
>  
> +#define TWL4030_IRQNUM			INT_24XX_SYS_NIRQ
> +
> +/* TWL4030 Primary Interrupt Handler (PIH) interrupts */
> +#define IH_TWL4030_BASE		IH_BOARD_BASE
> +#define IH_TWL4030_END			(IH_TWL4030_BASE+8)
> +#define NR_IRQS			(IH_TWL4030_END)
> +

Pushing this too, slightly modified to apply.

Tony
