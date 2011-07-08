From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Fri, 8 Jul 2011 23:28:05 +0900
Message-ID: <20110708083733.GA18860@opensource.wolfsonmicro.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
 <1310041672-18634-2-git-send-email-peter.ujfalusi@ti.com>
 <20110707155742.GC16325@opensource.wolfsonmicro.com>
 <4E15DFAA.7030508@ti.com>
 <20110707165329.GG16325@opensource.wolfsonmicro.com>
 <1310068516.3569.22.camel@CNA0741383>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37401 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752788Ab1GHO2P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 10:28:15 -0400
Content-Disposition: inline
In-Reply-To: <1310068516.3569.22.camel@CNA0741383>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, Jul 07, 2011 at 08:55:16PM +0100, Liam Girdwood wrote:
> On 07/07/11 17:53, Mark Brown wrote:

> > My comment was more that the changelog should say why it's not suitable
> > given that it involves a near total rewrite of the driver which is a
> > pretty big step, I'm fine with the actual change.  I guess that the
> > current McPDM driver configures some things that should be moved to the
> > DMA driver?

> I cant think of anything thing atm that could be moved to DMA driver,
> McPDM mostly uses ABE for moving PCM data around.

Well, I'm just guessing here since the changelog was so uninformative :)

> It's not that simple in this situation. We also have a PM dependency on
> the CODEC here too, it supplies our interface clock via the DAI so we
> have to be very careful how we interact with the ABE and CODEC. The
> critical thing here is the pop reduction and a subsequent ABE patch will
> also introduce some hard timing constraints here too.

This definitely feels like it needs sorting in a better way than just
inserting random delays into drivers - the clocking dependencies are far
from unique, for example, and would normally be managed by the machine
drivers with the current infrastructure.  Right now it's all sounding
far too fragile due to the lack of any explicit indication of what's
going on and the fact that things are going to be spread over a bunch of
different drivers.

If we just insert random delays into the drivers the chances of anyone
understanding what the code is supposed to be doing in the future seem
low which isn't going to be nice when people do different designs.
