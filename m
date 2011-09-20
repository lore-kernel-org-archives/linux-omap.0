From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Tue, 20 Sep 2011 18:42:28 +0300
Message-ID: <1316533348.18781.14.camel@deskari>
References: <1316522954-16594-1-git-send-email-mythripk@ti.com>
	 <1316522954-16594-2-git-send-email-mythripk@ti.com>
	 <1316522954-16594-3-git-send-email-mythripk@ti.com>
	 <1316522954-16594-4-git-send-email-mythripk@ti.com>
	 <1316522954-16594-5-git-send-email-mythripk@ti.com>
	 <1316522954-16594-6-git-send-email-mythripk@ti.com>
	 <1316525477.1949.20.camel@deskari>
	 <CAP5A+B8inCnMnvrjDbtHUQ=t86HiOXvM6W+gPUVBAHcQLwH8=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58803 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751103Ab1ITPmd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 11:42:33 -0400
Received: by mail-bw0-f41.google.com with SMTP id zs2so632616bkb.28
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 08:42:32 -0700 (PDT)
In-Reply-To: <CAP5A+B8inCnMnvrjDbtHUQ=t86HiOXvM6W+gPUVBAHcQLwH8=A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2011-09-20 at 21:06 +0530, K, Mythri P wrote:
> Hi,
> 
> On Tue, Sep 20, 2011 at 7:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > On Tue, 2011-09-20 at 18:19 +0530, mythripk@ti.com wrote:
> >> From: Mythri P K <mythripk@ti.com>
> >>
> >> Add support to dump the HDMI regm, regn, and other clock parameters.
> >
> > This patch doesn't work at all. It's checking for CONFIG_OMAP2_DSS_HDMI,
> > whereas the actual define is CONFIG_OMAP4_DSS_HDMI. And even after
> > fixing that, the output is:
> >
> > HDMI Clock Info
> > regm            104regmf 104
> > dcofreq 0regsd 1
> > DSS_FCK (DSS_FCLK)      (off)
> > hdmi fclk source = 3
> >
> These are the reg m , mf , dcofreq , by default the HDMI clock input is sysclk ,
> These values are based on the pixel clock.I suppose all the other
> clock values are
> printed via dss / dispc clock dump , is there any other dump that is missing?

I don't know, as the output was so garbled that I didn't look any
further.

But just look at the outputs from other interfaces, mainly DSI. Make the
output format similar, and print relevant information in the same way.

 Tomi


