From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH] OMAPDSS: Cleanup DSSDBG with dynamic pr_debug function
Date: Tue, 25 Sep 2012 15:00:49 +0530
Message-ID: <CAF0AtAukV_5FXXc79yuXr50+1XXWNiFKdN5MWLgRy2N6Ux-adg@mail.gmail.com>
References: <1348552998-6596-1-git-send-email-cmahapatra@ti.com>
	<1348554291.2342.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:33507 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753502Ab2IYJav (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 05:30:51 -0400
Received: by vcbfo13 with SMTP id fo13so7365724vcb.19
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 02:30:50 -0700 (PDT)
In-Reply-To: <1348554291.2342.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

>> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
>> index 6354bb8..cb86d94 100644
>> --- a/drivers/video/omap2/dss/apply.c
>> +++ b/drivers/video/omap2/dss/apply.c
>> @@ -559,7 +559,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
>>       struct mgr_priv_data *mp;
>>       int r;
>>
>> -     DSSDBGF("%d", ovl->id);
>> +     DSSDBG("%d", ovl->id);
>
> I don't think this is good. It's true that dyn-debug can print the
> function name, but that's optional. The debug message should be somehow
> sensible independently, but in this case only a number is printed which
> is totally meaningless.
>
> Either the messages should be modified to give a hint what's going on,
> or the DSSDBGF could be kept for now. In the above case the debug
> message could be something like "writing ovl %d regs".
>
> However, I think it'd be easier just to keep the DSSDBGF for now, and
> remove it gradually.
>
>>       if (!op->enabled || !op->info_dirty)
>>               return;
>> @@ -594,7 +594,7 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
>>       struct ovl_priv_data *op = get_ovl_priv(ovl);
>>       struct mgr_priv_data *mp;
>>
>> -     DSSDBGF("%d", ovl->id);
>> +     DSSDBG("%d", ovl->id);
>>
>>       if (!op->extra_info_dirty)
>>               return;
>> @@ -618,7 +618,7 @@ static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
>>       struct mgr_priv_data *mp = get_mgr_priv(mgr);
>>       struct omap_overlay *ovl;
>>
>> -     DSSDBGF("%d", mgr->id);
>> +     DSSDBG("%d", mgr->id);
>>
>>       if (!mp->enabled)
>>               return;
>> @@ -644,7 +644,7 @@ static void dss_mgr_write_regs_extra(struct omap_overlay_manager *mgr)
>>  {
>>       struct mgr_priv_data *mp = get_mgr_priv(mgr);
>>
>> -     DSSDBGF("%d", mgr->id);
>> +     DSSDBG("%d", mgr->id);
>>
>>       if (!mp->extra_info_dirty)
>>               return;
>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
>> index 8d815e3..8304cc6b 100644
>> --- a/drivers/video/omap2/dss/dsi.c
>> +++ b/drivers/video/omap2/dss/dsi.c
>> @@ -1525,8 +1525,6 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
>>       u8 regn_start, regn_end, regm_start, regm_end;
>>       u8 regm_dispc_start, regm_dispc_end, regm_dsi_start, regm_dsi_end;
>>
>> -     DSSDBGF();
>> -
>>       dsi->current_cinfo.clkin = cinfo->clkin;
>>       dsi->current_cinfo.fint = cinfo->fint;
>>       dsi->current_cinfo.clkin4ddr = cinfo->clkin4ddr;
>> @@ -2334,8 +2332,6 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
>>       int r;
>>       u32 l;
>>
>> -     DSSDBGF();
>> -
>>       r = dss_dsi_enable_pads(dsi->module_id, dsi_get_lane_mask(dssdev));
>>       if (r)
>>               return r;
>> @@ -2686,7 +2682,7 @@ static void dsi_vc_initial_config(struct platform_device *dsidev, int channel)
>>  {
>>       u32 r;
>>
>> -     DSSDBGF("%d", channel);
>> +     DSSDBG("%d", channel);
>>
>>       r = dsi_read_reg(dsidev, DSI_VC_CTRL(channel));
>>
>> @@ -2718,7 +2714,7 @@ static int dsi_vc_config_source(struct platform_device *dsidev, int channel,
>>       if (dsi->vc[channel].source == source)
>>               return 0;
>>
>> -     DSSDBGF("%d", channel);
>> +     DSSDBG("%d", channel);
>>
>>       dsi_sync_vc(dsidev, channel);
>>
>> @@ -3475,7 +3471,7 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
>>       int r, i;
>>       unsigned mask;
>>
>> -     DSSDBGF();
>> +     DSSDBG("");
>
> This debug message is even less meaningful than the overlay number =).
> Again, I think either keep the DSSDBGF, or print something sensible,
> like "entering ULPS".
>

I dont think it would be wise enough to update code for one and keep
the older version for another when both DSSDBG and DSSDBGF are almost
one and the same. Its better to add something meaningful to the prints
as you have mentioned like "writing ovl %d regs" and "DSI entering
ULPS".

>>
>>       WARN_ON(!dsi_bus_is_locked(dsidev));
>>
>> @@ -4184,7 +4180,7 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
>>       unsigned long pck;
>>       int r;
>>
>> -     DSSDBGF("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
>> +     DSSDBG("ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
>>
>>       mutex_lock(&dsi->lock);
>>
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
>> index 5e9fd769..3a2caab 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -29,38 +29,20 @@
>>
>>  #ifdef DEBUG
>>  extern bool dss_debug;
>
> You still left the dss_debug option here, even if it's not used by the
> DSSDBG anymore. What's your plan about this?
>
>  Tomi
>

dss_debug and DEBUG need to remain here as it is being used by
functions omap_dispc_irq_handler() and _dsi_print_reset_status() in
dispc.c and dsi.c. I am little bit unsure of how to deal with it.
There could be a single print in omap_dispc_irq_handler() but it is a
bit tricky in _dsi_print_reset_status().

May be a macro like this one can be used in _dsi_print_reset_status()

#define DSI_FLD_GET(fld, start, end)\
      FLD_GET(dsi_read_reg(dsidev, DSI_##fld), start, end);

pr_debug("PLL (%d) CIO (%d) \n PHY (%x%x%x, %d, %d, %d) \n",
                 DSI_FLD_GET(PLL_STATUS, 0, 0),
                 DSI_FLD_GET(COMPLEXIO_CFG1, 29, 29),
                 DSI_FLD_GET(DSIPHY_CFG5, bo, bo),
                 DSI_FLD_GET(DSIPHY_CFG5, b1, b1),
   ..................................................);
This could be defined at the beginning of the function and later at its end.

As you had previously mentioned a print like

#define PIS(x) (status & DSI_IRQ_##x) ? (#x " ") : ""

pr_debug("DSI IRQ: 0x%x: %s%s%s",
        status,
        PIS(WAKEUP),
        PIS(RESYNC),
        PIS(PLL_LOCK));

could help in print_irq_status() but I am still unsure how to deal
with conditional statements in print_irq_status() like
if (dss_has_feature(FEAT_MGR_LCD3))
                PIS(SYNC_LOST3);
Should we use approach like

pr_debug("DSI IRQ: 0x%x: %s%s%s%s...",
        status,
        PIS(WAKEUP),
        PIS(RESYNC),
        PIS(PLL_LOCK)
        dss_has_feature(FEAT_MGR_LCD3) ? PIS(SYNC_LOST3) : ""
  ...................................... );


-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
