From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 5/5] OMAPDSS: HDMI: Add support to dump clocks
 through
Date: Thu, 22 Sep 2011 15:01:10 +0300
Message-ID: <1316692870.2442.24.camel@deskari>
References: <1316678866-17749-1-git-send-email-mythripk@ti.com>
	 <1316678866-17749-2-git-send-email-mythripk@ti.com>
	 <1316678866-17749-3-git-send-email-mythripk@ti.com>
	 <1316678866-17749-4-git-send-email-mythripk@ti.com>
	 <1316678866-17749-5-git-send-email-mythripk@ti.com>
	 <1316678866-17749-6-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:32831 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799Ab1IVMBQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 08:01:16 -0400
Received: by bkaq10 with SMTP id q10so2805675bka.31
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 05:01:13 -0700 (PDT)
In-Reply-To: <1316678866-17749-6-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Thu, 2011-09-22 at 13:37 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Add support to dump the HDMI regm, regn, and other clock parameters.

The subjects of this and previous patch seem to be still broken. And
while at it, you could fix missing periods and misplaced spaces (like
"foo ,bar") in the descriptions of this patch series.

> +void hdmi_dump_clocks(struct seq_file *s)
> +{
> +	enum omap_dss_clk_source dispc_clk_src;
> +
> +	dispc_clk_src = dss_get_dispc_clk_source();
> +
> +	if (hdmi_runtime_get())
> +		return;
> +
> +	seq_printf(s, "- HDMI PLL -\n");
> +
> +	seq_printf(s, "regm\t%u\n", hdmi.ip_data.pll_data.regm);
> +
> +	seq_printf(s, "regmf\t%u\n", hdmi.ip_data.pll_data.regmf);
> +
> +	seq_printf(s, "dcofreq\t%u\n", hdmi.ip_data.pll_data.dcofreq);
> +
> +	seq_printf(s, "regsd\t%u\n", hdmi.ip_data.pll_data.regsd);

Printing the dividers is fine, but I think we're usually more interested
in the resulting clocks. So you should print also the clocks. Possibly
internal clocks (like Fint for DSI) also, but at least the output
clocks. I believe for HDMI PLL they are CLKOUTLDO and CLKDCOLDO.

Looking at the dividers also brings up two things not directly related
to this patch:

- What is dcofreq? Looking at the code, it tells if the pixel clock is >
1000MHz. Why is such a field needed, can't the HDMI driver manage that
itself? And if it's needed, why is it called dcofreq, the name doesn't
make much sense to me.

- We are doing HDMI PLL calculations in the omapdss drivers hdmi.c file.
The PLL calculations are PLL specific, and thus should be in the
specific HDMI implementation file, right?

> +	seq_printf(s, "DISPC clock source %s (%s)\t(%s)\n",
> +			dss_get_generic_clk_source_name(dispc_clk_src),
> +			dss_feat_get_clk_source_name(dispc_clk_src),
> +			dispc_clk_src == OMAP_DSS_CLK_SRC_FCK ?
> +			"off" : "on");

Why do you print DISPC clock source? How is that part of HDMI clock
configuration?

> +
> +	seq_printf(s, "hdmi %s source rate = %lu\n",
> +			hdmi.ip_data.pll_data.refsel == HDMI_REFSEL_SYSCLK ?
> +			"sysclk" : "pclk/ref1/ref2",
> +			clk_get_rate(hdmi.sys_clk));

Here I think it would be better to use the same format as the already
existing outputs (DSI). And as the PLL source is base clock, it's more
logical to print it first, like DSI does.

 Tomi


