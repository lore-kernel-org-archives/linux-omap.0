From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: EDMA oftree entry for AM335x
Date: Mon, 4 May 2015 23:33:00 +0200
Message-ID: <20150504213300.GV15254@pengutronix.de>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com>
 <20150504211150.GU15254@pengutronix.de>
 <20150504212457.GB4810@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32936 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbbEDVdD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 17:33:03 -0400
Content-Disposition: inline
In-Reply-To: <20150504212457.GB4810@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Mon, May 04, 2015 at 02:24:57PM -0700, Tony Lindgren wrote:
> > I tried this, with the patch below, but it doesn't work:
> 
> With the above the tptc instances are being probed as separate
> device entries that do not register with tpcc without the
> related driver changes. I don't think we even parse the
> compatible = "ti,tptc3" property currently.

How useful is it to let the driver warn about wrong devicetrees then,
when fixing the devicetrees results in a kernel not supporting it...?

Shouldn't these sort of patches being upstreamed only together with the
full set of changes?

However, thanks for the infos, I'll stay with the warnings for now.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
