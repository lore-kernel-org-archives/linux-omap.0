From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Mon, 11 Apr 2011 12:09:49 +0300
Message-ID: <1302512989.2198.57.camel@deskari>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>
	 <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>
	 <1301489930.15095.51.camel@deskari>
	 <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>
	 <1301900022.2715.12.camel@deskari>
	 <alpine.DEB.2.00.1104081036310.22291@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51815 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752258Ab1DKJJy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Apr 2011 05:09:54 -0400
Received: by mail-fx0-f44.google.com with SMTP id 15so6001888fxm.17
        for <linux-omap@vger.kernel.org>; Mon, 11 Apr 2011 02:09:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104081036310.22291@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, 2011-04-08 at 10:50 -0600, Paul Walmsley wrote:
> Hi Tomi,
> 
> On Mon, 4 Apr 2011, Tomi Valkeinen wrote:

> > Not directly related, but something I've been wondering about is how to
> > abstract the DSI/HDMI PLLs in DSS. What do you think, would it be
> > possible/worth it to create struct clks for the clocks coming out of
> > those PLLs? These would, of course, be DSS internal clks. I'm not very
> > familiar with the clock framework, so I don't really have any idea what
> > this would require and what would be the pros and cons.
> 
> Yes, I think it would be good to try to implement the entire DSS clock 
> tree in the clock framework.  One change to the clock code that we know 
> we'll need is to put a hwmod pointer in the struct clk which tells the 
> clock code that the hwmod needs to be enabled in order to access the 
> clock's registers.  Right now, the clock code assumes that all of the 
> clock registers are accessible, all of the time.

It's not quite that simple, as DSI PLL also needs the vdds_dsi regulator
to be enabled... And to use DSI PLL, not only do you need to access DSI
PLL registers, you also need to use DSI registers.

Is it possible to have the driver create its own clock structs when it's
loaded, and have the code for that clock inside the driver, or are
clocks something that has to be handled in the core platform code?

 Tomi



