From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAP: DSS2: Have separate irq handlers for DISPC
 and DSI
Date: Fri, 18 Feb 2011 14:26:51 +0200
Message-ID: <1298032011.24062.88.camel@deskari>
References: <1298028108-20224-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44826 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab1BRM0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 07:26:54 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1ICQsI4020852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 06:26:54 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1ICQr2B021043
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 06:26:53 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1ICQrjo013335
	for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 06:26:53 -0600 (CST)
In-Reply-To: <1298028108-20224-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

On Fri, 2011-02-18 at 05:21 -0600, Taneja, Archit wrote:
> Currently, the core DSS platform device requests for an irq line for OMAP2 and
> OMAP3. Make DISPC and DSI platform devices request for a shared IRQ line.
> 
> On OMAP3, the logical OR of DSI and DISPC interrupt lines goes to the MPU. There
> is a register DSS_IRQSTATUS which tells if the interrupt came from DISPC or DSI.
> 
> On OMAP2, there is no DSI, only DISPC interrupts goto the MPU. There is no
> DSS_IRQSTATUS register.
> 
> Hence, it makes more sense to have separate irq handlers corresponding to the
> DSS sub modules instead of having a common handler.
> 
> Since on OMAP3 the logical OR of the lines goes to MPU, the irq line is shared
> among the IRQ handlers.
> 
> The hwmod irq info has been removed for DSS to DISPC and DSI for OMAP2 and OMAP3
> hwmod databases. The Probes of DISPC and DSI now request for irq handlers.
> 

<snip>

> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index cc58208..8e308ab 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -32,6 +32,7 @@
>  #include <linux/delay.h>
>  #include <linux/workqueue.h>
>  #include <linux/hardirq.h>
> +#include <linux/interrupt.h>
> 
>  #include <plat/sram.h>
>  #include <plat/clock.h>
> @@ -178,6 +179,7 @@ struct dispc_irq_stats {
>  static struct {
>         struct platform_device *pdev;
>         void __iomem    *base;
> +       int irq;
> 
>         u32     fifo_size[3];
> 
> @@ -2865,7 +2867,7 @@ static void print_irq_status(u32 status)
>   * but we presume they are on because we got an IRQ. However,
>   * an irq handler may turn the clocks off, so we may not have
>   * clock later in the function. */
> -void dispc_irq_handler(void)
> +static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
>  {
>         int i;
>         u32 irqstatus;
> @@ -2878,6 +2880,12 @@ void dispc_irq_handler(void)
> 
>         irqstatus = dispc_read_reg(DISPC_IRQSTATUS);
> 
> +       /* IRQ is not for us */
> +       if (!irqstatus) {
> +               spin_unlock(&dispc.irq_lock);
> +               return IRQ_HANDLED;

I think this should return IRQ_NONE.

And would this be more optimal:

irqstatus = dispc_read_reg(DISPC_IRQSTATUS);
irqenable = dispc_read_reg(DISPC_IRQENABLE);

if (!(irqstatus & irqenable))
	exit;

That way we would exit quick even if there are irqstatus bits up for
interrupts we are not interested in.

For DSI this method probably doesn't work, as there are multiple
irqstatus registers there.

> +       }
> +
>  #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
>         spin_lock(&dispc.irq_stats_lock);
>         dispc.irq_stats.irq_count++;
> @@ -2928,6 +2936,8 @@ void dispc_irq_handler(void)
>         }
> 
>         spin_unlock(&dispc.irq_lock);
> +
> +       return IRQ_HANDLED;
>  }
> 
>  static void dispc_error_worker(struct work_struct *work)
> @@ -3322,6 +3332,7 @@ int dispc_setup_plane(enum omap_plane plane,
>  static int omap_dispchw_probe(struct platform_device *pdev)
>  {
>         u32 rev;
> +       int r = 0;
>         struct resource *dispc_mem;
> 
>         dispc.pdev = pdev;
> @@ -3338,12 +3349,27 @@ static int omap_dispchw_probe(struct platform_device *pdev)
>         dispc_mem = platform_get_resource(dispc.pdev, IORESOURCE_MEM, 0);
>         if (!dispc_mem) {
>                 DSSERR("can't get IORESOURCE_MEM DISPC\n");
> -               return -EINVAL;
> +               r = -EINVAL;
> +               goto fail0;
>         }
>         dispc.base = ioremap(dispc_mem->start, resource_size(dispc_mem));
>         if (!dispc.base) {
>                 DSSERR("can't ioremap DISPC\n");
> -               return -ENOMEM;
> +               r = -ENOMEM;
> +               goto fail0;
> +       }
> +       dispc.irq = platform_get_irq(dispc.pdev, 0);
> +       if (dispc.irq < 0) {
> +               DSSERR("omap2 dispc: platform_get_irq failed\n");
> +               r = -ENODEV;
> +               goto fail1;
> +       }
> +
> +       r = request_irq(dispc.irq, omap_dispc_irq_handler, IRQF_SHARED,
> +               "OMAP DISPC", dispc.pdev);
> +       if (r < 0) {
> +               DSSERR("omap2 dispc: request_irq failed\n");
> +               goto fail1;
>         }
> 
>         enable_clocks(1);
> @@ -3359,12 +3385,15 @@ static int omap_dispchw_probe(struct platform_device *pdev)
>                FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
> 
>         enable_clocks(0);
> -
> +fail1:
> +       iounmap(dispc.base);
> +fail0:
>         return 0;
>  }
> 
>  static int omap_dispchw_remove(struct platform_device *pdev)
>  {
> +       free_irq(dispc.irq, NULL);
>         iounmap(dispc.base);
>         return 0;
>  }
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 1802057..a68f4ea 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -222,6 +222,7 @@ static struct
>  {
>         struct platform_device *pdev;
>         void __iomem    *base;
> +       int irq;
> 
>         struct dsi_clock_info current_cinfo;
> 
> @@ -494,13 +495,17 @@ static void print_irq_status_cio(u32 status)
>  static int debug_irq;
> 
>  /* called from dss */
> -void dsi_irq_handler(void)
> +static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
>  {
>         u32 irqstatus, vcstatus, ciostatus;
>         int i;
> 
>         irqstatus = dsi_read_reg(DSI_IRQSTATUS);
> 
> +       /* IRQ is not for us */
> +       if (!irqstatus)
> +               return IRQ_HANDLED;

IRQ_NONE.


> +
>  #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
>         spin_lock(&dsi.irq_stats_lock);
>         dsi.irq_stats.irq_count++;
> @@ -578,9 +583,9 @@ void dsi_irq_handler(void)
>  #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
>         spin_unlock(&dsi.irq_stats_lock);
>  #endif
> +       return IRQ_HANDLED;
>  }
> 
> -
>  static void _dsi_initialize_irq(void)
>  {
>         u32 l;
> @@ -3294,12 +3299,25 @@ static int dsi_init(struct platform_device *pdev)
>                 r = -ENOMEM;
>                 goto err1;
>         }
> +       dsi.irq = platform_get_irq(dsi.pdev, 0);
> +       if (dsi.irq < 0) {
> +               DSSERR("omap2 dsi: platform_get_irq failed\n");

No need to prefix this with "omap2 dsi". DSSERR already does that. And
the same comment for other prints.

Otherwise I think this looks good.

 Tomi


