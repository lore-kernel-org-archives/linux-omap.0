From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [RFC PATCH 22/29] OMAPDSS: DISPC: Setup writeback go, enable and
 channel_in functions
Date: Thu, 2 Aug 2012 15:25:35 +0530
Message-ID: <CAF0AtAvnvko_8dkN1aho05JPAEHTi11kak2paJXFODHDC=ifyg@mail.gmail.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
	<1324989432-3625-23-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:58736 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754202Ab2HBJzh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 05:55:37 -0400
Received: by vbbfc26 with SMTP id fc26so8706526vbb.26
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 02:55:35 -0700 (PDT)
In-Reply-To: <1324989432-3625-23-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Dec 27, 2011 at 6:07 PM, Archit Taneja <archit@ti.com> wrote:
> Fill up dispc_wb_go(), dispc_wb_go_busy(), dispc_wb_enable() and
> dispc_wb_get_channel_in()/set_channel_in() with writeback register writes. Make
> a minor modification in dss_wb_write_regs_extra() to pass the plane_id instead
> of the writeback id when calling dispc_wb_set_channel_in().
>
> Setup dispc_wb_enable() as dispc_enable_lcd_out() function and wait for the
> FRAMEDONEWB interrupt while disabling writeback.
>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/apply.c |    2 +-
>  drivers/video/omap2/dss/dispc.c |   68 +++++++++++++++++++++++++++++++++++----
>  drivers/video/omap2/dss/dss.h   |    2 +-
>  3 files changed, 63 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index dd1fd419..57b061f 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -690,7 +690,7 @@ static void dss_wb_write_regs_extra(struct omap_dss_writeback *wb)
>         if (!wp->extra_info_dirty)
>                 return;
>
> -       dispc_wb_set_channel_in(wb->id, wp->channel_in);
> +       dispc_wb_set_channel_in(wb->plane_id, wp->channel_in);
>         dispc_ovl_set_fifo_threshold(wb->plane_id, wp->fifo_low, wp->fifo_high);
>
>         wp->extra_info_dirty = false;
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index c7de56d..cbce120 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -510,12 +510,26 @@ void dispc_mgr_go(enum omap_channel channel)
>
>  bool dispc_wb_go_busy(int id)
>  {
> -       return false;
> +       return REG_GET(DISPC_CONTROL2, 6, 6) == 1;
>  }
>
>  void dispc_wb_go(int id)
>  {
> -       return;
> +       struct omap_dss_writeback *wb = omap_dss_get_writeback(id);
> +       bool enable, go;
> +
> +       enable = REG_GET(DISPC_OVL_ATTRIBUTES(wb->plane_id), 0, 0) == 1;
> +
> +       if (!enable)
> +               return;
> +
> +       go = REG_GET(DISPC_CONTROL2, 6, 6) == 1;
> +       if (go) {
> +               DSSERR("GO bit not down for WB\n");
> +               return;
> +       }
> +
> +       REG_FLD_MOD(DISPC_CONTROL2, 1, 6, 6);
>  }
>
>  static void dispc_ovl_write_firh_reg(enum omap_plane plane, int reg, u32 value)
> @@ -903,16 +917,24 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
>         return channel;
>  }
>
> -void dispc_wb_set_channel_in(int id, enum dss_writeback_channel_in ch_in)
> +void dispc_wb_set_channel_in(int plane, enum dss_writeback_channel_in ch_in)
>  {
> -       return;
> +       REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), ch_in, 18, 16);
>  }
>
>  static enum omap_channel dispc_wb_get_channel_in(int plane)
>  {
> -       /* Return LCD channel for now */
> +       int channel_in = REG_GET(DISPC_OVL_ATTRIBUTES(plane), 18, 16);
>
> -       return OMAP_DSS_CHANNEL_LCD;
> +       switch (channel_in) {
> +       case OMAP_DSS_WB_LCD2_MGR:
> +               return OMAP_DSS_CHANNEL_LCD2;
> +       case OMAP_DSS_WB_TV_MGR:
> +               return OMAP_DSS_CHANNEL_DIGIT;
> +       case OMAP_DSS_WB_LCD1_MGR:
> +       default:
> +               return OMAP_DSS_CHANNEL_LCD;
> +       };
>  }
>

What about other cases of pipelines and overlays here? You have
considered only overlays and that too ignored OMAP_DSS_CHANNEL_LCD3.

The channel_in parameter of DISPC_WB_ATTRIBUTES does handle the
following cases as well:
0x0: Primary LCD overlay output
0x1: Secondary LCD output
0x2: TV overlay output
0x7: Third LCD output

0x3: Graphics pipeline output
0x4: Video1 pipeline output
0x5: Video2 pipeline output
0x6: Video3 pipeline output

>  static void dispc_ovl_set_burst_size(enum omap_plane plane,
> @@ -2138,7 +2160,39 @@ void dispc_mgr_enable(enum omap_channel channel, bool enable)
>
>  void dispc_wb_enable(int id, bool enable)
>  {
> -       return;
> +       struct omap_dss_writeback *wb = omap_dss_get_writeback(id);
> +       enum omap_plane plane = wb->plane_id;
> +       struct completion frame_done_completion;
> +       bool is_on;
> +       int r;
> +       u32 irq;
> +
> +       is_on = REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
> +       irq = DISPC_IRQ_FRAMEDONEWB;
> +
> +       if (!enable && is_on) {
> +               init_completion(&frame_done_completion);
> +
> +               r = omap_dispc_register_isr(dispc_disable_isr,
> +                               &frame_done_completion, irq);
> +
> +               if (r)
> +                       DSSERR("failed to register FRAMEDONEWB isr\n");
> +       }
> +
> +       REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 0, 0);
> +
> +       if (!enable && is_on) {
> +               if (!wait_for_completion_timeout(&frame_done_completion,
> +                                       msecs_to_jiffies(100)))
> +                       DSSERR("timeout waiting for FRAMEDONEWB\n");
> +
> +               r = omap_dispc_unregister_isr(dispc_disable_isr,
> +                               &frame_done_completion, irq);
> +
> +               if (r)
> +                       DSSERR("failed to unregister FRAMEDONEWB isr\n");
> +       }
>  }
>
>  void dispc_lcd_enable_signal_polarity(bool act_high)
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 69b4793..c05658b 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -498,7 +498,7 @@ void dispc_wb_go(int id);
>  int dispc_wb_setup(int id, struct omap_dss_writeback_info *wi,
>                 u16 in_width, u16 in_height);
>  void dispc_wb_enable(int id, bool enable);
> -void dispc_wb_set_channel_in(int id, enum dss_writeback_channel_in ch_in);
> +void dispc_wb_set_channel_in(int plane, enum dss_writeback_channel_in ch_in);
>
>  /* VENC */
>  #ifdef CONFIG_OMAP2_DSS_VENC
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
