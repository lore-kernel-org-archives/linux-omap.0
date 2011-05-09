From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Mon, 9 May 2011 21:19:12 +0200
Message-ID: <20110509191912.GA6546@opensource.wolfsonmicro.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
 <1304494704-7285-2-git-send-email-archit@ti.com>
 <20110504094050.GI27860@atomide.com>
 <1304595408.30935.16.camel@deskari>
 <20110505130204.GK11744@opensource.wolfsonmicro.com>
 <1304955274.2215.26.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40282 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751821Ab1EITTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 15:19:08 -0400
Content-Disposition: inline
In-Reply-To: <1304955274.2215.26.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Mon, May 09, 2011 at 06:34:34PM +0300, Tomi Valkeinen wrote:

> The first is that we want to avoid unnecessary board file changes, and
> as almost all boards configure the DSS powers the same way, it'd be nice
> to have a default config for these.

Right, makes sense.

> The second thing is that even if the power source for vdds_dsi may be
> configured differently on different boards, the same vdds_dsi goes to
> multiple DSS HW blocks inside OMAP, each represented by a separate
> omap_device. So it'd be much nicer to configure just the vdds_dsi power
> in the board file, but let the omap display code configure the
> regulators properly for all the DSS HW blocks in that particular OMAP.

For this I'd suggest setting up an arrangement with supplies where you
have one thing on the OMAP is supplied by board configuration and then
it has child supplies within the device but right now that's not so easy
to do.  I was just writing some stuff for that this afternoon but it'll
be next week before I can test it properly.
