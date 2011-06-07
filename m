From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Tue, 7 Jun 2011 13:08:05 +0100
Message-ID: <20110607120804.GE18544@opensource.wolfsonmicro.com>
References: <20110504094050.GI27860@atomide.com>
 <1304595408.30935.16.camel@deskari>
 <20110505130204.GK11744@opensource.wolfsonmicro.com>
 <1304955274.2215.26.camel@deskari>
 <20110509191912.GA6546@opensource.wolfsonmicro.com>
 <1305030652.2045.49.camel@deskari>
 <20110510134730.GB25877@opensource.wolfsonmicro.com>
 <1305105825.2097.49.camel@deskari>
 <20110511121243.GB5487@opensource.wolfsonmicro.com>
 <1307447098.1858.31.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35897 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752159Ab1FGMIH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Jun 2011 08:08:07 -0400
Content-Disposition: inline
In-Reply-To: <1307447098.1858.31.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Tue, Jun 07, 2011 at 02:44:58PM +0300, Tomi Valkeinen wrote:
> On Wed, 2011-05-11 at 14:12 +0200, Mark Brown wrote:
> > On Wed, May 11, 2011 at 12:23:45PM +0300, Tomi Valkeinen wrote:

> > You need to create a new regulator of some kind and then provide a way
> > for machines to set the supply_regulator in the init_data.

> What should this "new regulator of some kind" be? I was trying out with
> fixed regulator, but I'm not quite sure if that's good here.

It should be a regulator that does what you want.

> I don't want a full controllable regulator, but just a virtual "route"
> regulator, which mirrors the state of the parent regulator.

If it's not doing what you want then make a new one.

> Using a new regulator like this also means that there is a dependency
> between the new regulator and the used source supply. I haven't solved
> this yet, as the twl driver seems to add the regulators at some later
> stage.

I'm sorry but I can't parse what you're saying here at all.
