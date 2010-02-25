From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCHv4 2/7] ASoC: TWL6030: Add twl6030 codec
 driver
Date: Thu, 25 Feb 2010 10:17:35 +0000
Message-ID: <20100225101735.GF10141@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B14@dlee06.ent.ti.com>
 <1267007881.3274.136.camel@odin>
 <20100224104256.GB9018@sirena.org.uk>
 <1889FA7136B567478A67D4B0F85B0CCE65DD22F0@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46594 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756695Ab0BYKRk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Feb 2010 05:17:40 -0500
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65DD22F0@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 24, 2010 at 05:57:25PM -0600, Olaya, Margarita wrote:

> > A switch statement would be nicer here.

> You mean something like this?

> 	switch (reg) {
> 	case TWL6030_REG_ASICID:
> 	case TWL6030_REG_ASICREV:
> 	case TWL6030_REG_STATUS:
> 		continue;
> 	default:
> 	break:
> 	}

Yes.
