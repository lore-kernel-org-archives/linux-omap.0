From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: kernel panic with latest DSS
Date: Thu, 11 Mar 2010 10:24:51 +0100
Message-ID: <18410E43-78D3-4406-879B-37712FCE8B5C@student.utwente.nl>
References: <5e088bd91003091158l6cfa0b76u204e5432389d573@mail.gmail.com> <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:42899 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab0CKJY6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 04:24:58 -0500
Received: by ewy8 with SMTP id 8so1731638ewy.28
        for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 01:24:56 -0800 (PST)
In-Reply-To: <5e088bd91003101016s4148751es1a142c21d1540564@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <Tomi.Valkeinen@nokia.com>


Op 10 mrt 2010, om 19:16 heeft Steve Sakoman het volgende geschreven:

> On Tue, Mar 9, 2010 at 11:58 AM, Steve Sakoman <sakoman@gmail.com> wrote:
>> I just updated all my Beagle and Overo DSS patches to apply on the
>> latest linux-omap head.
>> 
>> I ran into a slight issue with parsing defaults, but saw that Tomi had
>> already posted a workaround for that.
>> 
>> With that patch applied I get pretty good results until I try to do
>> something like play a DVD or display video from a webcam.
>> 
>> At that point I get a kernel panic.  See below.
> 
> I did a little more research on this.
> 
> The issue occurs in the following section of code in
> drivers/video/omap2/dss/dispc.c:
> 
> unsigned long dispc_fclk_rate(void)
> {
> 	unsigned long r = 0;
> 
> 	if (dss_get_dispc_clk_source() == DSS_SRC_DSS1_ALWON_FCLK)
> 		r = dss_clk_get_rate(DSS_CLK_FCK1);
> 	else
> #ifdef CONFIG_OMAP2_DSS_DSI
> 		r = dsi_get_dsi1_pll_rate();
> #else
> 	BUG();
> #endif
> 	return r;
> }
> 
> Since my machines don't have DSI displays CONFIG_OMAP2_DSS_DSI is not
> defined and the BUG() call is triggered.
> 
> I don't know enough about what *should* be happening here to propose a
> fix, but I'll continue looking.

Not that you need the DSI_PLL config to get tighter timings to do e.g. 74.25MHz for 720p60. I had to rediscover that this week on DM37xx.....

regards,

Koen