From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Mon, 11 Apr 2011 12:05:00 +0300
Message-ID: <1302512700.2198.53.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>
	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
	 <1301900022.2715.12.camel@deskari>
	 <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>
	 <1302241893.2102.21.camel@deskari>
	 <alpine.DEB.2.00.1104080753070.22291@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:39098 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339Ab1DKJFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 05:05:06 -0400
Received: by fxm3 with SMTP id 3so5371360fxm.16
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 02:05:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104080753070.22291@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 2011-04-08 at 08:55 -0600, Paul Walmsley wrote:
> Hi
> 
> On Fri, 8 Apr 2011, Tomi Valkeinen wrote:

> > and not the clock used for the pixel clock? If so, I'm fine with having 
> > "fck" to be what it is currently, but then we need a new name for the 
> > clock used for pixel clock, which is consistent on all platforms.
> 
> If there is a separate PRCM-provided clock used only for the pixel clock, 
> then that clock should have an alias name of "system_pixel_ck" or 
> something similar that is meaningful to the DSS driver.  I think the 
> problem in this case is that "dss_dss_clk" is (optionally) used for two 
> purposes: optionally as a "main PRCM-provided functional clock" and 
> optionally as a system-provided pixel clock.

Not only for pixel clock, but in the end it'll come out as pixel clock.
I'm not sure what exactly is a "functional clock" here. I mean, one
could think it as a basic functionality of DSS to read the pixels,
manipulate them, and output them (with the rate of the pixel clock).

However, I think there is one difference between the clock used just to
enable the DSS registers, and the one used to output pixels: we need to
be able to adjust the rate of the clock. Thus we need to have a common
(omap2/3/4) clock name for it to be able to clk_get() it.

Should that clock name be just the "main" clock provided automatically,
or something else?

 Tomi


