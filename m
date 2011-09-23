From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 5/5] OMAPDSS: HDMI: Add support to dump clocks through
Date: Fri, 23 Sep 2011 13:45:45 +0300
Message-ID: <1316774745.6909.2.camel@deskari>
References: <1316770341-19140-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55329 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753141Ab1IWKpt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 06:45:49 -0400
Received: by mail-bw0-f50.google.com with SMTP id zt19so4079800bkb.23
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 03:45:48 -0700 (PDT)
In-Reply-To: <1316770341-19140-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Fri, 2011-09-23 at 15:02 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> Add support to dump the HDMI PLL dividers such as regm, regn etc
> and other clock dumps such as pixel clock rate, TMDS clock rate.
> 
> changes since V2:
> Add pixel clock and TMDS clock dump and remove dcofreq and DISPC clock source
> print.

Let's drop this fifth patch for now, I think the hdmi pll code needs a
bit cleaning up before we can have a good dump clocks support.

I'll take the patches 1-4 and apply to dss2 master.

Btw, this patch, and the 4th patch, still have broken subject. I guess
this is fourth time I mention it. I'll fix it myself in the patches I
apply.

 Tomi


