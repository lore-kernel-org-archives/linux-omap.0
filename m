From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
Date: Wed, 03 Jun 2015 09:19:06 -0700
Message-ID: <20150603161906.6017.98159@quantum>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
 <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36139 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383AbbFCQTK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:19:10 -0400
Received: by pdjm12 with SMTP id m12so10750443pdj.3
        for <linux-omap@vger.kernel.org>; Wed, 03 Jun 2015 09:19:10 -0700 (PDT)
In-Reply-To: <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Quoting Tomi Valkeinen (2015-05-06 03:08:58)
> DESHDCP clock is needed on DRA7 based SoCs to enable the DSS IP. That
> clock is an odd one, as it is not supposed to be any kind of core clock
> for DSS, and we don't even support HDCP, but the clock is still needed
> even for the HWMOD framework to be able to reset the DSS IP.
> 
> As there's no support for multiple core clocks in the HWMOD framework,
> we don't have any obvious place to enable this clock when DSS IP is
> being enabled.
> 
> Furthermore, the HDMI on OMAP5 DSS is the same as on DRA7, and OMAP5
> does not have any such clock configuration bit. This suggests that on
> OMAP5 the DESHDCP clock is always enabled, and for DRA7 we have the
> possibility to gate it.
> 
> So, as we don't have any clean way to enable and disable the clock
> based on the need, this patch enables the clock at boot time, making it
> work similarly to OMAP5.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Michael Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/ti/clk-7xx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
> index 2dd956b9affa..63b8323df918 100644
> --- a/drivers/clk/ti/clk-7xx.c
> +++ b/drivers/clk/ti/clk-7xx.c
> @@ -312,7 +312,7 @@ static struct ti_dt_clk dra7xx_clks[] = {
>  int __init dra7xx_dt_clk_init(void)
>  {
>         int rc;
> -       struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck;
> +       struct clk *abe_dpll_mux, *sys_clkin2, *dpll_ck, *hdcp_ck;
>  
>         ti_dt_clocks_register(dra7xx_clks);
>  
> @@ -348,5 +348,10 @@ int __init dra7xx_dt_clk_init(void)
>         if (rc)
>                 pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
>  
> +       hdcp_ck = clk_get_sys(NULL, "dss_deshdcp_clk");
> +       rc = clk_prepare_enable(hdcp_ck);
> +       if (rc)
> +               pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
> +
>         return rc;
>  }
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
