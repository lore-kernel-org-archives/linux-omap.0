From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCHv3 10/10] CLK: TI: always enable DESHDCP clock
Date: Wed, 27 May 2015 21:22:13 -0700
Message-ID: <20150528042213.22384.12243@quantum>
References: <1430906938-26128-1-git-send-email-tomi.valkeinen@ti.com>
 <1430906938-26128-11-git-send-email-tomi.valkeinen@ti.com>
 <555C744C.6070901@ti.com> <555C74E8.5010105@ti.com>
 <555CE1BF.4050506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34540 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbbE1EWT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2015 00:22:19 -0400
Received: by pdbki1 with SMTP id ki1so32534565pdb.1
        for <linux-omap@vger.kernel.org>; Wed, 27 May 2015 21:22:19 -0700 (PDT)
In-Reply-To: <555CE1BF.4050506@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>

Quoting Stephen Boyd (2015-05-20 12:34:23)
> On 05/20/15 04:50, Tero Kristo wrote:
> >
> >>>
> >>> @@ -348,5 +348,10 @@ int __init dra7xx_dt_clk_init(void)
> >>>       if (rc)
> >>>           pr_err("%s: failed to set USB_DPLL M2 OUT\n", __func__);
> >>>
> >>> +    hdcp_ck = clk_get_sys(NULL, "dss_deshdcp_clk");
> >>> +    rc = clk_prepare_enable(hdcp_ck);
> >>> +    if (rc)
> >>> +        pr_err("%s: failed to set dss_deshdcp_clk\n", __func__);
> >>> +
> >>>       return rc;
> >>>   }
> >>>
> >>
> >> You should rather use the assigned-clock properties in DT to accomplish
> >> this, the manual clock tweaks under the drivers/clk/ti/clk-* files
> >> should be converted to DT setup also.
> >
> > Now that I sent this, I realize we only have support to set_parent /
> > set_rate through the assigned-clock props, no enable. Any plans to
> > extend this support Mike/Stephen?
> >
> >
> 
> Enable falls under the "critical clocks" discussion that is ongoing. I
> assume that this is some sort of critical clock that can't be turned off?

Just chiming in on the "critical clock" discussion. I'm not planning to
merge something that lets Devicetree nodes call clk_enable on a clock.
That's what drivers are for.

The assigned-rate and assigned-parent stuff that Tero mentioned is more
like configuration data for a downstream clock consumer. Clock
gating/ungating does not fall under this type of configuration data in
my opinion.

I think that Tomi's patch to call clk_prepare_enable from
dra7xx_dt_clk_init is a reasonable solution to the problem.

Regards,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
