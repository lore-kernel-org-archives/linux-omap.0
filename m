From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Problem with DSS clocks & accessing registers
Date: Mon, 7 Mar 2011 17:03:20 +0200
Message-ID: <1299510200.2281.199.camel@deskari>
References: <1299486149.2281.77.camel@deskari>  <4D74E2D5.2000705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37770 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1CGPDb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 10:03:31 -0500
In-Reply-To: <4D74E2D5.2000705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Taneja, Archit" <archit@ti.com>, "Semwal, Sumit" <sumit.semwal@ti.com>

On Mon, 2011-03-07 at 07:51 -0600, Cousson, Benoit wrote:
> + Rajendra
> 
> Hi Tomi,
> 
> On 3/7/2011 9:22 AM, Valkeinen, Tomi wrote:
> > Hi Kevin, Paul,
> >
> > We currently have a small problem with OMAP4 DSS. When we enable the DSS
> > clocks, it seems that the DSS registers are not always accessible right
> > after the clock enable.
> 
> What clocks are you talking about? As you know, the DSS has a bunch of 
> functional clocks available depending of the use case.

In this case the clocks for DISPC, iclk and fclk. On OMAP4 fclk is
DSS_FCLK and iclk is not used, I believe. The problem is probably also
in all the other DSS modules.

> > I understood that on OMAP4 the clock framework doesn't guarantee that
> > the registers are accessible after enabling clocks, and pm_runtime will
> > handle this. Is this correct?
> 
> The point is that there is no status at clock level but only one status 
> at module level. That's why this check does not have anything to do at 
> clock level.
> So hwmod with handle that status (OMAP4430_CM_DSS_DSS_CLKCTRL) during 
> the hwmod_enable that is indirectly called by pm_runtime, through 
> omap_device API.

Ah. Ok. How does CM_DSS_DSS_CLKCTRL show that the DSS module is ready?
IDLEST is 0?

> > I have made a small hack fix for this. I added udelay(10) in the DSS
> > code which enables the clocks and this seem to remove the problem. The
> > delay is only called when DSS thinks the clocks have been off, so in
> > practice the delay shouldn't be visible. Is this fix acceptable for now,
> > until we get pm_runtime support to DSS?
> 
> Cannot you use omap_device for the moment? Relying on a udelay is not a 
> very safe method, even temporally.

Yes, udelay is not very good option even as a hack, except if we can
wait some amount of time which we know will always be enough. Can we?

I have to say I'm not very familiar with omap_device, as I haven't been
really working with them (nor hwmods). Sumit or Archit can perhaps fill
in, but my understanding is that work on that area is going on, but it's
not ready yet. So I'm looking for some temporary quick solution for this
so that DSS driver doesn't randomly crash on OMAP4.

 Tomi


