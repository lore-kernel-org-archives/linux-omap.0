From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP4 DSS clock setup
Date: Mon, 11 Apr 2011 12:20:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104111211010.2837@utopia.booyaka.com>
References: <1301467733.2333.83.camel@deskari>  <4D92F899.7010606@ti.com>  <1301483027.4045.16.camel@deskari>  <4D931E21.8090305@ti.com>  <1301489930.15095.51.camel@deskari>  <alpine.DEB.2.00.1104011925510.27897@utopia.booyaka.com>  <1301900022.2715.12.camel@deskari>
  <alpine.DEB.2.00.1104071054390.29552@utopia.booyaka.com>  <1302241893.2102.21.camel@deskari>  <alpine.DEB.2.00.1104080753070.22291@utopia.booyaka.com> <1302512700.2198.53.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36471 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab1DKSU3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Apr 2011 14:20:29 -0400
In-Reply-To: <1302512700.2198.53.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Taneja, Archit" <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Hi

On Mon, 11 Apr 2011, Tomi Valkeinen wrote:
> On Fri, 2011-04-08 at 08:55 -0600, Paul Walmsley wrote:
> > On Fri, 8 Apr 2011, Tomi Valkeinen wrote:
> 
> > > and not the clock used for the pixel clock? If so, I'm fine with having 
> > > "fck" to be what it is currently, but then we need a new name for the 
> > > clock used for pixel clock, which is consistent on all platforms.
> > 
> > If there is a separate PRCM-provided clock used only for the pixel clock, 
> > then that clock should have an alias name of "system_pixel_ck" or 
> > something similar that is meaningful to the DSS driver.  I think the 
> > problem in this case is that "dss_dss_clk" is (optionally) used for two 
> > purposes: optionally as a "main PRCM-provided functional clock" and 
> > optionally as a system-provided pixel clock.
> 
> Not only for pixel clock, but in the end it'll come out as pixel clock.
> I'm not sure what exactly is a "functional clock" here. I mean, one
> could think it as a basic functionality of DSS to read the pixels,
> manipulate them, and output them (with the rate of the pixel clock).

Broadly speaking, a functional clock is defined negatively - 'anything 
that's not an interface clock.'  That's why the term 'functional clock' is 
not so useful by itself.  But when we talk about a module's 'main 
functional clock,' that means the functional clock that is needed for 
register accesses to work. 
 
> However, I think there is one difference between the clock used just to
> enable the DSS registers, and the one used to output pixels: we need to
> be able to adjust the rate of the clock. Thus we need to have a common
> (omap2/3/4) clock name for it to be able to clk_get() it.
>
> Should that clock name be just the "main" clock provided automatically,
> or something else?

Are you referring here to the system DPLL and its output dividers, or are 
you referring to the DSS module's internal dividers?


- Paul
