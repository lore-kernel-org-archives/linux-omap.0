From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: move dss device clock configuration
Date: Fri, 01 Apr 2011 11:39:44 +0300
Message-ID: <1301647184.3393.29.camel@deskari>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
	 <1301566266-11187-2-git-send-email-tomi.valkeinen@ti.com>
	 <4D957923.2030902@ti.com> <1301641628.3393.5.camel@deskari>
	 <4D958407.1080505@ti.com> <1301644231.3393.20.camel@deskari>
	 <4D958A91.90807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34674 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753088Ab1DAIju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 04:39:50 -0400
In-Reply-To: <4D958A91.90807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Fri, 2011-04-01 at 13:49 +0530, Archit Taneja wrote:

> But there are some parameters which might get common across dss devices.
> Things like dispc clock source, dispc core clock divider will be shared 
> across the panels. We had discussed the possibility of declaring this 
> common info in omap_dss_board_info or as a separate common_clocks 
> structure. Each device could pick this filled up common_clocks struct, 
> or fill it up its own way (for the use cases which has only one panel on 
> at a time). I was wondering if it would be easy to move to this approach 
> with your patch. dispc itself would now have some common clock stuff and 
> per panel clock stuff. Is that a very clean approach?

I don't know =). I think the simplest solution is to have full divisor
info for each dss_device. And it's up to the board file writer to make
sure the divisors match for all the displays that can be enabled at the
same time.

I don't think that is perfect, but trying to share the data sounds a bit
confusing. Especially as there are just a divisor and a clock source
that are shared. If we have a lot of common data, then a shared struct
would of course be better.

> Anyway, I think it would be good to have a channel struct, as there are 
> more things to put in dispc clocks, it should look something like:
> 
> struct clocks {
> 		struct {
> 			struct {
> 				u16 lck_div;
> 				u16 pck_div;
> 				enum clock_source lcd_clk_src;
> 			} channel;
> 			...
> 			...
> 			u16 core_clk_div;
> 		} dispc;
> 		...
> 		...
> };

In my original patch I had:

        struct {
                struct {
                        u16 fck_div;
                } dss;

                struct {
                        u16 lck_div;
                        u16 pck_div;

                        bool fclk_from_dsi_pll;
                } dispc;

		...
	};

Which I removed due to comments and slight confusion how to handle the
DSS_FCLK divisor and the clock source.

Adding the clock source there needs some more work, moving the enum to
public include file, and implementing the support. If you agree that
this patch in its current form is an improvement, I'd like to go forward
with this and work on the clock source later.

 Tomi


