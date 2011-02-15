From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] regulator: twl: add clk32kg to twl-regulator
Date: Mon, 14 Feb 2011 16:01:43 -0800
Message-ID: <20110215000143.GV20795@atomide.com>
References: <1297343690-4557-1-git-send-email-balajitk@ti.com>
 <20110211111906.GF7180@opensource.wolfsonmicro.com>
 <20110214211558.GL20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52531 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab1BOABy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 19:01:54 -0500
Content-Disposition: inline
In-Reply-To: <20110214211558.GL20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Balaji T K <balajitk@ti.com>, lrg@slimlogic.co.uk, sameo@linux.intel.com, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110214 13:14]:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [110211 03:17]:
> > On Thu, Feb 10, 2011 at 06:44:50PM +0530, Balaji T K wrote:
> > > In OMAP4 Blaze and Panda, 32KHz clock to WLAN is supplied from Phoenix TWL6030.
> > > The 32KHz clock state (ON/OFF) is configured in CLK32KG_CFG_[GRP, TRANS, STATE]
> > > register. This follows the same register programming model as other regulators
> > > in TWL6030. So add CLK32KG as pseudo regulator.
> > > 
> > > Signed-off-by: Balaji T K <balajitk@ti.com>
> > 
> > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > 
> > Though I can see someone wanting an adaption to the clock API on top of
> > this at some point.
> 
> Samuel should queue this one, I'll queue 2/2 of this series. These
> can be queued separately.

Oops no they can't, the second patch depends on clk32kg. Samuel, can
you please queue both? Will reply to the second one with my ack.

Tony
