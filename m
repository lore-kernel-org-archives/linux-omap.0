From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: DMIC: Adding the OMAP DMIC driver
Date: Wed, 29 Dec 2010 12:11:04 +0000
Message-ID: <20101229121103.GC3017@opensource.wolfsonmicro.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
 <1293509826-23253-2-git-send-email-dlambert@ti.com>
 <20101228111424.GB2239@legolas.emea.dhcp.ti.com>
 <AANLkTi=6iWz0jdakBBgw2OEOjADvS2YmCN0ebKODQ7Ke@mail.gmail.com>
 <20101229094738.GA2254@legolas.emea.dhcp.ti.com>
 <1293618931.3451.17.camel@odin>
 <20101229104432.GB2254@legolas.emea.dhcp.ti.com>
 <1293623571.3451.51.camel@odin>
 <20101229115628.GB3017@opensource.wolfsonmicro.com>
 <20101229115924.GA2222@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34504 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752210Ab0L2MKx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 07:10:53 -0500
Content-Disposition: inline
In-Reply-To: <20101229115924.GA2222@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "Lambert, David" <dlambert@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Wed, Dec 29, 2010 at 01:59:24PM +0200, Felipe Balbi wrote:
> On Wed, Dec 29, 2010 at 11:56:28AM +0000, Mark Brown wrote:

> >The other thing with McBSP is that it's a generic programmable serial
> >port and so need not be tied to audio use (though as I understand it
> >other uses are very rare).

> So why is it still tied to OMAP-only ? There's no abstraction layer
> around McBSP so OMAP McBSP driver has to export a whole bunch of symbols
> for its users:

As far as I know the hardware has not been used on other platforms - all
the people who care specifically about the driver are using OMAP and
don't see any reason to do the work.  There's really no pressure to do
this.
