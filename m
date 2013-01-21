From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 0/2] OMAP3 ISP: Simplify clock usage
Date: Mon, 21 Jan 2013 11:04:51 -0800
Message-ID: <20130121190451.3982.51699@quantum>
References: <1357652634-17668-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <3133387.jv7osGsLR0@avalon> <20130121171812.GJ15361@atomide.com>
 <4222427.SJZRgZMHGN@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36221 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3AUTEz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 14:04:55 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so3559710pad.6
        for <linux-omap@vger.kernel.org>; Mon, 21 Jan 2013 11:04:55 -0800 (PST)
In-Reply-To: <4222427.SJZRgZMHGN@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Paul Walmsley <paul@pwsan.com>

Quoting Laurent Pinchart (2013-01-21 10:54:38)
> Hi Tony,
> 
> On Monday 21 January 2013 09:18:12 Tony Lindgren wrote:
> > * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [130121 05:37]:
> > > On Monday 14 January 2013 17:10:15 Mike Turquette wrote:
> > > > Quoting Laurent Pinchart (2013-01-08 05:43:52)
> > > > 
> > > > > Hello,
> > > > > 
> > > > > Now that the OMAP3 supports the common clock framework, clock rate
> > > > > back-propagation is available for the ISP clocks. Instead of setting
> > > > > the cam_mclk parent clock rate to control the cam_mclk clock rate, we
> > > > > can mark the dpll4_m5x2_ck_3630 and cam_mclk clocks as supporting
> > > > > back-propagation, and set the cam_mclk rate directly. This simplifies
> > > > > the ISP clocks configuration.
> > > > 
> > > > I'm pleased to see this feature get used on OMAP.  Plus your driver gets
> > > > a negative diffstat :)
> > > > 
> > > > Reviewed-by: Mike Turquette <mturquette@linaro.org>
> > > 
> > > Thanks.
> > > 
> > > Would you like to take the arch/ patch in your tree, or should I push it
> > > through the linux-media tree along with the omap3isp patch ?
> > 
> > The arch/arm/*omap* clock changes need to be queued by Paul to avoid
> > potential stupid merge conflicts when the clock data gets moved to
> > live under drivers/clk/omap.
> 
> OK. The omap3isp patch can go through Paul's tree as well, it won't conflict 
> with other changes to the driver in this merge window.
> 
> Paul, can you take both patches together ? If so I'll send you a pull request.
> 

+1

I don't take in driver changes/adaptations through the clk tree unless
it is necessary to avoid painful conflicts or merge ordering issues.
This has only happened a few times for MFD devices, etc.  Typically the
clk-next branch is only used for changes to the clk framework core or
clk drivers.

Regards,
Mike

> -- 
> Regards,
> 
> Laurent Pinchart
