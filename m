From: Tony Lindgren <tony@atomide.com>
Subject: Re: EDMA oftree entry for AM335x
Date: Mon, 4 May 2015 14:42:01 -0700
Message-ID: <20150504214201.GC4810@atomide.com>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com>
 <20150504211150.GU15254@pengutronix.de>
 <20150504212457.GB4810@atomide.com>
 <20150504213300.GV15254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:49086 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbbEDVmE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 17:42:04 -0400
Content-Disposition: inline
In-Reply-To: <20150504213300.GV15254@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Robert Schwebel <r.schwebel@pengutronix.de> [150504 14:34]:
> On Mon, May 04, 2015 at 02:24:57PM -0700, Tony Lindgren wrote:
> > > I tried this, with the patch below, but it doesn't work:
> > 
> > With the above the tptc instances are being probed as separate
> > device entries that do not register with tpcc without the
> > related driver changes. I don't think we even parse the
> > compatible = "ti,tptc3" property currently.
> 
> How useful is it to let the driver warn about wrong devicetrees then,
> when fixing the devicetrees results in a kernel not supporting it...?

It's there so we can NAK new drivers if somebody tries to sneak
in more stuff like that. Of course it should be fixed for the
existing ones, that's the EDMA and McBSP AFAIK.

> Shouldn't these sort of patches being upstreamed only together with the
> full set of changes?

Ideally these sort of patches never got merged. The right way to fix
this is to first fix the driver, only then do the dts changes.
 
> However, thanks for the infos, I'll stay with the warnings for now.

Yes I figured :)

Regards,

Tony
