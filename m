From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 8/8] ARM: DTS: dra7x: Integrate sDMA crossbar
Date: Thu, 9 Apr 2015 12:01:27 -0700
Message-ID: <20150409190126.GT18048@atomide.com>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-9-git-send-email-peter.ujfalusi@ti.com>
 <20150409151846.GR18048@atomide.com>
 <5526C9E5.4070601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:43335 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006AbbDITFF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 15:05:05 -0400
Content-Disposition: inline
In-Reply-To: <5526C9E5.4070601@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de, maxime.ripard@free-electrons.com

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150409 11:55]:
> On 04/09/2015 06:18 PM, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [150409 02:37]:
> >> The sDMA requests are routed through the DMA crossbar and without the
> >> crossbar only peripherals using DMA request 0-127 can be used.
> > 
> > I assume this can be merged separately from the driver
> > changes?
> 
> Unfortunately not. We need to have the drivers in place for the DTS changes to
> work.

Right but just merging the driver changes presumably won't
break things?

Regards,

Tony
