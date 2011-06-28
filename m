From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/7] OMAP4: Add modulemode support to hwmod framework
 (part 2)
Date: Tue, 28 Jun 2011 12:20:44 +0300
Message-ID: <1309252844.1825.63.camel@deskari>
References: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
	 <1309244182.1825.28.camel@deskari>  <4E098D59.7040108@ti.com>
	 <1309249797.1825.52.camel@deskari>  <4E099B81.8080002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:38783 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754815Ab1F1JUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Jun 2011 05:20:49 -0400
Received: by mail-bw0-f42.google.com with SMTP id 19so76271bwa.1
        for <linux-omap@vger.kernel.org>; Tue, 28 Jun 2011 02:20:47 -0700 (PDT)
In-Reply-To: <4E099B81.8080002@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-06-28 at 11:14 +0200, Cousson, Benoit wrote:
> On 6/28/2011 10:29 AM, Valkeinen, Tomi wrote:

> > My current pm_runtime patch set removes the omapdss clock aliases from
> > arch/arm/mach-omap2/clock44xx_data.c, as the driver uses the opt-clock
> > names. Isn't that correct way?
> 
> Yes, it is, but we need to take care of the name. The names are local to 
> the device, so previously I had to prefix with dss_ every clocks 
> affected to the dss_core. Since now, most of them are connected only to 
> the relevant hwmod, we can use alias like "fck" if the role of the clock 
> is the functional one.

Ok.

> > The opt-clocks that my patch set gets are:
> >
> > - dss_clk
> 
> So that one was the DSS PRCM modulemode and will not exist anymore.

No, that was dss_dss_clk. It was named "dss_clk", as that is what the
TRM's clock tree shows. All the names in my patch set are from the clock
tree image.

> > - sys_clk
> 
> That one is OK.
> 
> > - hdmi_clk
> 
> I guess that one should be name "fck", since only the HDMI hwmod will 
> use it.

Ok. So the names shouldn't be the ones in the TRM, but more general
ones?

> > - rfbi_iclk
> 
> Should be named "ick", but I'm not even sure that one is needed.

rfbi needs to know the rate of the clock, so it needs to clk_get() it.

> > - tv_clk
> > - tv_dac_clk
> 
> Why do you have two clocks for the tv? I can only see the dss_tv_fclk in 
> the spec.

OMAP3430 has a separate dac clock.

> > Additionally these are used to configure the clk rates:
> > - dpll4_m4_ck
> > - dpll_per_m5x2_ck
> >
> > The "dss_clk" opt-clock is a bit of an odd-ball. The same clock is used
> > as a main-clk and an opt-clock. The driver uses the clock to change the
> > clock rates. If the driver can get the main-clock with some built-in
> > alias, like "fck", then this opt-clock is not needed. But I wasn't aware
> > of such a method.
> 
> Maybe because I've just introduced it :-)
> OMAP: omap_device: Create clkdev entry for hwmod main_clk
> 
> It was not done like that before. Only the opt_clk were used, because 
> the main_clk was not relevant. With that series, the main_clk represents 
> real clock, and thus can be exposed with "fck" alias.

Ok. This will allow removal of the "dss_clk" opt-clocks in my patch set.

 Tomi


