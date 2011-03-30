From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP4 DSS clock setup
Date: Wed, 30 Mar 2011 11:32:09 +0200
Message-ID: <4D92F899.7010606@ti.com>
References: <1301467733.2333.83.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185Ab1C3JcU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 05:32:20 -0400
In-Reply-To: <1301467733.2333.83.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Tomi,

On 3/30/2011 8:48 AM, Valkeinen, Tomi wrote:
> Hi Benoit, Paul,
>
> I've been discussing with Sumit and Archit to understand how the DSS
> clocks are set up on OMAP4. I think I now have some idea how things
> work, but I'm still at loss why things are the way they are.
>
> So, if I look at OMAP4 TRM, Figure 10-4 DSS Clock Tree, there are two
> clocks in PRCM block that are relevant to this discussion: DSS_L3_ICLK
> and DSS_FCLK. To my understanding DSS_L3_ICLK is not really
> controllable, but it is affected by MODULEMODE bit.
>
> Then we have two relevant clocks defined in clock44xx_data.c: dss_fck
> and dss_dss_clk. dss_fck controls the MODULEMODE bit, and dss_dss_clk is
> the TRM's DSS_FCLK.
>
> Was that correct?

Yes. For the moment, but this is not the final state.

> If so, from DSS driver's perspective, the dss_fck sounds very much like
> an interface clock (it's always needed when DSS is used) and dss_dss_clk
> sounds very much like functional clock (it's always needed, except if
> DSI PLL is used for DSS functional clock).
>
> If "dss_fck" would control DSS_FCLK and "dss_ick" would control
> MODULEMODE, they would be about the same as the clocks in OMAP2 and 3,
> and we wouldn't need any omap4 spesific trickery in the DSS driver.
> ("dss_dss_clk" wouldn't be needed).

You cannot play with iclk, because this clock is supposed to be handled 
automatically by the HW. This was the case on OMAP2 & 3 as well BTW.

> Why are the clocks set up in this strange fashion?

There are a lot of historical reasons and some changes from OMAP3 to 
OMAP4 that are not well handle by the current clock fmwk / hwmod fmwk.
We are still trying to mimic OMAP2&3 clock management for OMAP4, and in 
fact we should do the opposite.

The issue is due to the confusion with the MODULEMODE and the real input 
clock state.
The MODULEMODE is just enabling the module (using iclk, fclk, opt clock) 
or whatever clk is used as input clock.
In the case of the DSS, several optional clocks can be used as fclk. 
SYS_CLK, DSSCLK or the output of the DSI.
In theory the MODULEMODE should be directly handled by hwmod since it is 
similar to enable / disable the module. Using a clock to manage the 
MODULEMODE is a temporary hack we are still using for the moment but 
that should be removed at some point.

The clock fmwk should be used only to select / enable the proper 
optional clocks.

In theory the current OMAP2 and OMAP3 iclken/fclken at PRCM level should 
be handled as a OMAP4 MODULEMODE and not as 2 clock nodes like it is the 
case today. Then we will have a consistent module / clock management.

Hope this will help and clarify a little bit the current mess :-)

Bottom-line is that you cannot do much at your level, the whole clock + 
hwmod fmwk should be improved.

Benoit
