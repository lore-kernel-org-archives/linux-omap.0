From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 5/5] OMAPDSS: HDMI: Add support to dump clocks
 through
Date: Fri, 23 Sep 2011 10:03:46 +0300
Message-ID: <1316761426.1901.41.camel@deskari>
References: <1316678866-17749-1-git-send-email-mythripk@ti.com>
	 <1316678866-17749-2-git-send-email-mythripk@ti.com>
	 <1316678866-17749-3-git-send-email-mythripk@ti.com>
	 <1316678866-17749-4-git-send-email-mythripk@ti.com>
	 <1316678866-17749-5-git-send-email-mythripk@ti.com>
	 <1316678866-17749-6-git-send-email-mythripk@ti.com>
	 <1316692870.2442.24.camel@deskari>
	 <CAP5A+B-Ahwfk4tu3OtvRpfejFbv_jVpiVmoNJW0cGTfiwkG7kA@mail.gmail.com>
	 <1316757668.1901.12.camel@deskari>
	 <CAP5A+B_igRKKLadqqrRo7NVGP=uKbTmpnmajfDSD8neLJyYYxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56020 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750956Ab1IWHDv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 03:03:51 -0400
Received: by mail-bw0-f43.google.com with SMTP id s6so3831065bka.2
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 00:03:49 -0700 (PDT)
In-Reply-To: <CAP5A+B_igRKKLadqqrRo7NVGP=uKbTmpnmajfDSD8neLJyYYxQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-09-23 at 12:10 +0530, K, Mythri P wrote:
> Hi,
> 
> On Fri, Sep 23, 2011 at 11:31 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Fri, 2011-09-23 at 11:22 +0530, K, Mythri P wrote:
> >
> >> > - What is dcofreq? Looking at the code, it tells if the pixel clock is >
> >> > 1000MHz. Why is such a field needed, can't the HDMI driver manage that
> >> > itself? And if it's needed, why is it called dcofreq, the name doesn't
> >> > make much sense to me.
> >> It is DCO frequency, It suggest the frequency selector range ,
> >
> > The field is not DCO frequency, it's a boolean, 0 or 1. That's why the
> > name doesn't really make sense to me.
> >
> >> HDMI_PLL_CONFIGURATION2 (3:1) has to be set accordingly by the driver
> >> depending on whether the CLKOUTLDO is greater than or less than
> >> 1000Mhz, but anyways the decision is taken by the driver.
> >
> > But can't it be done in the ti_hdmi driver, at the same time when
> > programming the registers? Why do we need to set the boolean beforehand.
> >
> It can be done, It is not a boolean , boolean logic is used to
> determine the value 0x2 / 0x4.
> Page # 101. (DCO frequency).

The code says:

        pi->dcofreq = phy > 1000 * 100;                                          

so it is a boolean.

> > What do you mean DSI PLL might not be sufficient? We can get higher
> > DISPC clocks with DSI PLL than with PRCM.
> Well , from the older calculation / values passed to DSI ,
> it was seen that DSI PLL was in the order of 156Mhz, and PRCM with 186Mhz.
> This had resulted in underflow issues with HDMI.

But that's just up to the particular configuration used. DSI PLL can be
configured to reach the maximum DSS FCLK, but with PRCM this is not
usually possible.

I see your point that it is relevant for HDMI to work properly, but
there are many other things that are also needed for HDMI to work
properly and we don't print them. And as the DISPC clk source is already
printed above in the DISPC section, I don't see the need for that here.

 Tomi


