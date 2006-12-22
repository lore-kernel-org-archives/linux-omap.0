From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon
Date: Fri, 22 Dec 2006 13:08:37 -0800
Message-ID: <20061222210837.GT2449@atomide.com>
References: <458A5728.2060905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <458A5728.2060905@gmail.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [061221 01:43]:
> 
> ARM: OMAP: Fix ethernet IRQF_TRIGGER flag for apollon
> 
> As reported by Kyungmin Park, ethernet IRQF_TRIGGER flag for
> apollon has to be IRQF_TRIGGER_RISING instead of
> IRQF_TRIGGER_HIGH.
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> Index: linux-osk/drivers/net/smc91x.h
> ===================================================================
> --- linux-osk.orig/drivers/net/smc91x.h
> +++ linux-osk/drivers/net/smc91x.h
> @@ -198,7 +198,7 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
>  				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING)
>  #else
>  #define SMC_IRQ_FLAGS		(machine_is_omap_apollon()		\
> -				? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW)
> +				? IRQF_TRIGGER_RISING : IRQF_TRIGGER_LOW)
>  #endif
>  
>  #elif	defined(CONFIG_SH_SH4202_MICRODEV)
> 

Pushing today.

Tony
