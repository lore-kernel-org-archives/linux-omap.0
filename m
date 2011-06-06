From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/27] OMAP: DSS2: Use PM runtime & HWMOD support
Date: Mon, 06 Jun 2011 16:21:14 +0300
Message-ID: <1307366474.1910.44.camel@deskari>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
	 <1307095237-14805-20-git-send-email-tomi.valkeinen@ti.com>
	 <871uzahnib.fsf@ti.com> <1307122985.2016.72.camel@deskari>
	 <87hb86a5mm.fsf@ti.com> <1307174504.1777.24.camel@lappyti>
	 <4DECCE90.6070201@ti.com> <1307365290.1910.39.camel@deskari>
	 <4DECD2D7.6030207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46321 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756978Ab1FFNVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 09:21:19 -0400
In-Reply-To: <4DECD2D7.6030207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

On Mon, 2011-06-06 at 15:15 +0200, Cousson, Benoit wrote:
> On 6/6/2011 3:01 PM, Valkeinen, Tomi wrote:
> > On Mon, 2011-06-06 at 14:56 +0200, Cousson, Benoit wrote:

> > In this long term solution, if the dss_fclk is the main_clk, how does
> > the framework handle the situation when we want to switch from the
> > standard DSS fclk to the one from DSI PLL?
> 
> That part cannot be done by the hwmod fmwk anyway. The goal of the fmwk 
> is to ensure that the module is accessible by the driver whatever the 
> PRCM clock used.
> Enabling the DSI PLL will require the PRCM clock to be enabled first.
> 
> Using the DSI PLL as the fclk is doable, but is it really useful or needed?

Yes, it's useful and needed. It gives us much finer control to the clock
frequencies, and so allows us to go to higher frequencies and also more
exactly to the required pixel clock.

> Assuming you need that mode, you will always have to explicitly switch 
> from DSI to PRCM clock before trying to disable the DSS.
> This is something you will have to do inside the DSS driver. It should 
> be transparent to the hwmod fmwk.

This sounds ok.

I think the main question is how do we disable the standard DSS fclk
from PRCM when using DSI PLL? As far as I know, disabling that clock
will allow some areas of OMAP to be shut down even while DSS is working.
So from power management point of view it sounds a needed feature.

If the clock is main_clk for the HWMOD, it sounds to me it's always
enabled if the HWMOD is enabled?

 Tomi


