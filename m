From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 5/5] OMAPDSS: HDMI: Add support to dump clocks
 through
Date: Fri, 23 Sep 2011 09:01:08 +0300
Message-ID: <1316757668.1901.12.camel@deskari>
References: <1316678866-17749-1-git-send-email-mythripk@ti.com>
	 <1316678866-17749-2-git-send-email-mythripk@ti.com>
	 <1316678866-17749-3-git-send-email-mythripk@ti.com>
	 <1316678866-17749-4-git-send-email-mythripk@ti.com>
	 <1316678866-17749-5-git-send-email-mythripk@ti.com>
	 <1316678866-17749-6-git-send-email-mythripk@ti.com>
	 <1316692870.2442.24.camel@deskari>
	 <CAP5A+B-Ahwfk4tu3OtvRpfejFbv_jVpiVmoNJW0cGTfiwkG7kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43334 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab1IWGBN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 02:01:13 -0400
Received: by mail-bw0-f54.google.com with SMTP id zs8so4038704bkb.41
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 23:01:12 -0700 (PDT)
In-Reply-To: <CAP5A+B-Ahwfk4tu3OtvRpfejFbv_jVpiVmoNJW0cGTfiwkG7kA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-09-23 at 11:22 +0530, K, Mythri P wrote:

> > - What is dcofreq? Looking at the code, it tells if the pixel clock is >
> > 1000MHz. Why is such a field needed, can't the HDMI driver manage that
> > itself? And if it's needed, why is it called dcofreq, the name doesn't
> > make much sense to me.
> It is DCO frequency, It suggest the frequency selector range ,

The field is not DCO frequency, it's a boolean, 0 or 1. That's why the
name doesn't really make sense to me.

> HDMI_PLL_CONFIGURATION2 (3:1) has to be set accordingly by the driver
> depending on whether the CLKOUTLDO is greater than or less than
> 1000Mhz, but anyways the decision is taken by the driver.

But can't it be done in the ti_hdmi driver, at the same time when
programming the registers? Why do we need to set the boolean beforehand.

> Also the name is as suggested by TRM .

I couldn't find boolean dcofreq in the TRM.

> > - We are doing HDMI PLL calculations in the omapdss drivers hdmi.c file.
> > The PLL calculations are PLL specific, and thus should be in the
> > specific HDMI implementation file, right?
> >
> >> +     seq_printf(s, "DISPC clock source %s (%s)\t(%s)\n",
> >> +                     dss_get_generic_clk_source_name(dispc_clk_src),
> >> +                     dss_feat_get_clk_source_name(dispc_clk_src),
> >> +                     dispc_clk_src == OMAP_DSS_CLK_SRC_FCK ?
> >> +                     "off" : "on");
> >
> > Why do you print DISPC clock source? How is that part of HDMI clock
> > configuration?
> Reason is to check whether the DISPC clock source is PRCM / DSI PLL,
> Because DSI PLL might not be sufficient.

But it's already printed by the DISPC section, and it's not part of
HDMI, so I don't quite see the need.

What do you mean DSI PLL might not be sufficient? We can get higher
DISPC clocks with DSI PLL than with PRCM.

 Tomi


