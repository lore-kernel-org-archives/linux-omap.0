From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Date: Tue, 14 Aug 2012 17:33:30 +0530
Message-ID: <CAF0AtAt9SakEnavHMFXYZ2+nPXXreGcQNyXiJ7TuarRa1tATXA@mail.gmail.com>
References: <1344425874-28222-1-git-send-email-cmahapatra@ti.com>
	<1344859135-4470-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:48741 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905Ab2HNMDb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 08:03:31 -0400
Received: by qcse13 with SMTP id e13so562327qcs.9
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 05:03:30 -0700 (PDT)
In-Reply-To: <1344859135-4470-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

> +static const struct __initdata dispc_features omap2_dispc_features = {
> +       .hp_max                 =       256,
> +       .vp_max                 =       255,
> +       .sw_max                 =       64,
> +       .sw_start               =       5,
> +       .fp_start               =       15,
> +       .bp_start               =       27,
> +       .calc_scaling           =       dispc_ovl_calc_scaling_24xx,
> +       .calc_core_clk          =       calc_core_clk_24xx,
> +};
> +
> +static const struct __initdata dispc_features omap3_2_1_dispc_features = {
> +       .hp_max                 =       256,
> +       .vp_max                 =       255,
> +       .sw_max                 =       64,
> +       .sw_start               =       5,
> +       .fp_start               =       15,
> +       .bp_start               =       27,
> +       .calc_scaling           =       dispc_ovl_calc_scaling_34xx,
> +       .calc_core_clk          =       calc_core_clk_34xx,
> +};
> +
> +static const struct __initdata dispc_features omap3_3_0_dispc_features = {
> +       .hp_max                 =       4096,
> +       .vp_max                 =       4095,
> +       .sw_max                 =       256,
> +       .sw_start               =       7,
> +       .fp_start               =       19,
> +       .bp_start               =       31,
> +       .calc_scaling           =       dispc_ovl_calc_scaling_34xx,
> +       .calc_core_clk          =       calc_core_clk_34xx,
> +};
> +
> +static const struct __initdata dispc_features omap4_dispc_features = {
> +       .hp_max                 =       4096,
> +       .vp_max                 =       4095,
> +       .sw_max                 =       256,
> +       .sw_start               =       7,
> +       .fp_start               =       19,
> +       .bp_start               =       31,
> +       .calc_scaling           =       dispc_ovl_calc_scaling_44xx,
> +       .calc_core_clk          =       calc_core_clk_44xx,
> +};
> +

Here the dispc_features not only mention the omap name but also the
revision like omap3_3_0_dispc_features which initializes data for
OMAP3430_REV_ES3_0 and higher. May be omap34xx_rev3_0_dispc_features
is a better name for this. For others omap44xx_dispc_features kind of
name should be ok without revision number being mentioned. What d you
say?

> +static int __init dispc_init_features(struct device *dev)
> +{
> +       dispc.feat = devm_kzalloc(dev, sizeof(*dispc.feat), GFP_KERNEL);
> +       if (!dispc.feat) {
> +               dev_err(dev, "Failed to allocate DISPC Features\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (cpu_is_omap24xx()) {
> +               dispc.feat = &omap2_dispc_features;
> +       } else if (cpu_is_omap34xx()) {
> +               if (omap_rev() < OMAP3430_REV_ES3_0)
> +                       dispc.feat = &omap3_2_1_dispc_features;
> +               else
> +                       dispc.feat = &omap3_3_0_dispc_features;
> +       } else {
> +               dispc.feat = &omap4_dispc_features;
> +       }
> +
> +       return 0;
> +}
> +




-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
