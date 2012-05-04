From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 24/25] OMAPDSS: DSI: improve DSI module id handling
Date: Fri, 4 May 2012 14:39:15 +0530
Message-ID: <4FA39CBB.6010500@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com> <1336053481-25433-25-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47558 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928Ab2EDJJz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 May 2012 05:09:55 -0400
In-Reply-To: <1336053481-25433-25-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 03 May 2012 07:28 PM, Tomi Valkeinen wrote:
> We currently use the id of the dsi platform device (dsidev->id) as the
> DSI hardware module ID. This works because we assign the ID manually in
> arch/arm/mach-omap2/display.c at boot time.
>
> However, with device tree the platform device IDs are automatically
> assigned to an arbitrary number, and we can't use it.

If this number is arbitrary we would need to change the "dsi_pdev_map" 
approach of mapping a dsi module and it's corresponding platform device.
Currently dsi_pdev_map is:

static struct platform_device *dsi_pdev_map[MAX_NUM_DSI];

So we either need to increase the array size to take larger arbitrary 
numbers, or do something else.

We would also need to fix the usage of dsi_get_dsidev_from_id(), as 
right now we manually pass 0 and 1 to it only, for example:

static void dsi1_dump_irqs(struct seq_file *s)
{
         struct platform_device *dsidev = dsi_get_dsidev_from_id(0);

         dsi_dump_dsidev_irqs(dsidev, s);
}

The immediate solution that comes to mind is to maintain 2 id's, one 
which is sequential, and the other which the DT has created, and keep an 
array to map these. But this seems messy!

Archit

>
> Instead of using dsidev->id during operation, this patch stores the
> value of dsidev->id to a private field of the dsi driver at probe(). The
> future device tree code can thus set the private field with some other
> way.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dsi.c |   46 +++++++++++++++++++----------------------
>   1 file changed, 21 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 6cc92a8..ce964dd 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -256,6 +256,8 @@ struct dsi_data {
>   	struct platform_device *pdev;
>   	void __iomem	*base;
>
> +	int module_id;
> +
>   	int irq;
>
>   	struct clk *dss_clk;
> @@ -358,11 +360,6 @@ struct platform_device *dsi_get_dsidev_from_id(int module)
>   	return dsi_pdev_map[module];
>   }
>
> -static inline int dsi_get_dsidev_id(struct platform_device *dsidev)
> -{
> -	return dsidev->id;
> -}
> -
>   static inline void dsi_write_reg(struct platform_device *dsidev,
>   		const struct dsi_reg idx, u32 val)
>   {
> @@ -1181,10 +1178,9 @@ static unsigned long dsi_get_txbyteclkhs(struct platform_device *dsidev)
>   static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
>   {
>   	unsigned long r;
> -	int dsi_module = dsi_get_dsidev_id(dsidev);
>   	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
>
> -	if (dss_get_dsi_clk_source(dsi_module) == OMAP_DSS_CLK_SRC_FCK) {
> +	if (dss_get_dsi_clk_source(dsi->module_id) == OMAP_DSS_CLK_SRC_FCK) {
>   		/* DSI FCLK source is DSS_CLK_FCK */
>   		r = clk_get_rate(dsi->dss_clk);
>   	} else {
> @@ -1683,7 +1679,7 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
>   	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
>   	struct dsi_clock_info *cinfo =&dsi->current_cinfo;
>   	enum omap_dss_clk_source dispc_clk_src, dsi_clk_src;
> -	int dsi_module = dsi_get_dsidev_id(dsidev);
> +	int dsi_module = dsi->module_id;
>
>   	dispc_clk_src = dss_get_dispc_clk_source();
>   	dsi_clk_src = dss_get_dsi_clk_source(dsi_module);
> @@ -1755,7 +1751,6 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
>   	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
>   	unsigned long flags;
>   	struct dsi_irq_stats stats;
> -	int dsi_module = dsi_get_dsidev_id(dsidev);
>
>   	spin_lock_irqsave(&dsi->irq_stats_lock, flags);
>
> @@ -1772,7 +1767,7 @@ static void dsi_dump_dsidev_irqs(struct platform_device *dsidev,
>   #define PIS(x) \
>   	seq_printf(s, "%-20s %10d\n", #x, stats.dsi_irqs[ffs(DSI_IRQ_##x)-1]);
>
> -	seq_printf(s, "-- DSI%d interrupts --\n", dsi_module + 1);
> +	seq_printf(s, "-- DSI%d interrupts --\n", dsi->module_id + 1);
>   	PIS(VC0);
>   	PIS(VC1);
>   	PIS(VC2);
> @@ -2272,7 +2267,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
>
>   	DSSDBGF();
>
> -	r = dss_dsi_enable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
> +	r = dss_dsi_enable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
>   	if (r)
>   		return r;
>
> @@ -2382,20 +2377,21 @@ err_cio_pwr:
>   		dsi_cio_disable_lane_override(dsidev);
>   err_scp_clk_dom:
>   	dsi_disable_scp_clk(dsidev);
> -	dss_dsi_disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
> +	dss_dsi_disable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
>   	return r;
>   }
>
>   static void dsi_cio_uninit(struct omap_dss_device *dssdev)
>   {
>   	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
> +	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
>
>   	/* DDR_CLK_ALWAYS_ON */
>   	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 0, 13, 13);
>
>   	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
>   	dsi_disable_scp_clk(dsidev);
> -	dss_dsi_disable_pads(dsi_get_dsidev_id(dsidev), dsi_get_lane_mask(dssdev));
> +	dss_dsi_disable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
>   }
>
>   static void dsi_config_tx_fifo(struct platform_device *dsidev,
> @@ -4277,7 +4273,7 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
>   static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
>   {
>   	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
> -	int dsi_module = dsi_get_dsidev_id(dsidev);
> +	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
>   	int r;
>
>   	r = dsi_pll_init(dsidev, true, true);
> @@ -4289,7 +4285,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
>   		goto err1;
>
>   	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
> -	dss_select_dsi_clk_source(dsi_module, dssdev->clocks.dsi.dsi_fclk_src);
> +	dss_select_dsi_clk_source(dsi->module_id, dssdev->clocks.dsi.dsi_fclk_src);
>   	dss_select_lcd_clk_source(dssdev->manager->id,
>   			dssdev->clocks.dispc.channel.lcd_clk_src);
>
> @@ -4328,7 +4324,7 @@ err3:
>   	dsi_cio_uninit(dssdev);
>   err2:
>   	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
> -	dss_select_dsi_clk_source(dsi_module, OMAP_DSS_CLK_SRC_FCK);
> +	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
>   	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
>
>   err1:
> @@ -4342,7 +4338,6 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
>   {
>   	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
>   	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
> -	int dsi_module = dsi_get_dsidev_id(dsidev);
>
>   	if (enter_ulps&&  !dsi->ulps_enabled)
>   		dsi_enter_ulps(dsidev);
> @@ -4355,7 +4350,7 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
>   	dsi_vc_enable(dsidev, 3, 0);
>
>   	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
> -	dss_select_dsi_clk_source(dsi_module, OMAP_DSS_CLK_SRC_FCK);
> +	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
>   	dss_select_lcd_clk_source(dssdev->manager->id, OMAP_DSS_CLK_SRC_FCK);
>   	dsi_cio_uninit(dssdev);
>   	dsi_pll_uninit(dsidev, disconnect_lanes);
> @@ -4616,7 +4611,7 @@ static void dsi_put_clocks(struct platform_device *dsidev)
>   static int __init omap_dsihw_probe(struct platform_device *dsidev)
>   {
>   	u32 rev;
> -	int r, i, dsi_module = dsi_get_dsidev_id(dsidev);
> +	int r, i;
>   	struct resource *dsi_mem;
>   	struct dsi_data *dsi;
>   	struct omap_dss_board_info *pdata = dsidev->dev.platform_data;
> @@ -4625,8 +4620,9 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
>   	if (!dsi)
>   		return -ENOMEM;
>
> +	dsi->module_id = dsidev->id;
>   	dsi->pdev = dsidev;
> -	dsi_pdev_map[dsi_module] = dsidev;
> +	dsi_pdev_map[dsi->module_id] = dsidev;
>   	dev_set_drvdata(&dsidev->dev, dsi);
>
>   	spin_lock_init(&dsi->irq_lock);
> @@ -4712,7 +4708,7 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
>   		if (dssdev->type != OMAP_DISPLAY_TYPE_DSI)
>   			continue;
>
> -		if (dssdev->phy.dsi.module != dsi_module)
> +		if (dssdev->phy.dsi.module != dsi->module_id)
>   			continue;
>
>   		r = dsi_init_display(dssdev);
> @@ -4729,15 +4725,15 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
>
>   	dsi_runtime_put(dsidev);
>
> -	if (dsi_module == 0)
> +	if (dsi->module_id == 0)
>   		dss_debugfs_create_file("dsi1_regs", dsi1_dump_regs);
> -	else if (dsi_module == 1)
> +	else if (dsi->module_id == 1)
>   		dss_debugfs_create_file("dsi2_regs", dsi2_dump_regs);
>
>   #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
> -	if (dsi_module == 0)
> +	if (dsi->module_id == 0)
>   		dss_debugfs_create_file("dsi1_irqs", dsi1_dump_irqs);
> -	else if (dsi_module == 1)
> +	else if (dsi->module_id == 1)
>   		dss_debugfs_create_file("dsi2_irqs", dsi2_dump_irqs);
>   #endif
>   	return 0;

