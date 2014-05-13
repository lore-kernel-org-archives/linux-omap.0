From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] ARM: dts: Fix OMAP3 ISP functional clock
 configuration
Date: Mon, 12 May 2014 18:06:10 -0700
Message-ID: <20140513010610.GJ5668@atomide.com>
References: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <536B630B.8010303@ti.com>
 <8771357.o1oFFUoBzb@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10926 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbaEMBGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 21:06:18 -0400
Content-Disposition: inline
In-Reply-To: <8771357.o1oFFUoBzb@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140512 16:17]:
> On Thursday 08 May 2014 13:57:15 Tomi Valkeinen wrote:
> > On 21/04/14 13:41, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch set enables rate propagation from the OMAP3 ISP functional
> > > clock to the DPLL4 M5 clock. It copies Tomi Valkeinen's similar patch set
> > > for the OMAP DSS functional clock from the "OMAP: OMAP3 DSS related clock
> > > patches" patch series.
> > > 
> > > Laurent Pinchart (2):
> > >   ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
> > >   ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path
> > >  
> > >  arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
> > >  arch/arm/boot/dts/omap3xxx-clocks.dtsi | 7 ++++---
> > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > These look fine to me.
> > 
> > Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Thank you.
> 
> Tony, could you please pick the patches up for v3.16 ?

I'd like to see acks from Tero on these two, or Tero queue
them along with other clock dts clock changes.

Regards,

Tony
