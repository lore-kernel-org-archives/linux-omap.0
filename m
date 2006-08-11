From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: Use read/write_reg functions for PRCM.
Date: Fri, 11 Aug 2006 14:12:48 +0300
Message-ID: <20060811111247.GN6720@atomide.com>
References: <1150285041.3056.263790643@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1150285041.3056.263790643@webmail.messagingengine.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Komal Shah <komal_shah802003@yahoo.com> [060614 14:39]:
> This patch will break the pm.c and pm-domain.c if CONFIG_PM is enabled.

No problem. I'd actually prefer to have a patch that does not touch pm.c
and pm-domain.c. There's another patch coming for PM stuff that already
does not need prcm-regs.h much any longer.
 
> pm.c changes.
> - Use prcm_read/write_reg for preg(...)?? _or_ get function
>   for each of that reg.
> 
> - get/set_reg functions for INTC registers??
> 
> - get_reg functions for SDRC_DLLA/B for using with
>   omap2_sram_suspend ??
> 
> - Adding proc based register information as in OMAP1?
> 
> pm-domain.c
> - Add if (cpu_is_omap2420()) and assigning prcm_base at init.
> - Use prcm_readl/writel for other registers which uses _reg32 
>   based access as of now.

In general looks OK to me, could you please refresh and repost all your
pending patches? Let's plan on starting to integrate this as soon as we
have verified the generic irq stuff has not broken anything.

Regards,

Tony
