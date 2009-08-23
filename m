From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [RFC][PATCH 1/3 v2] ARM: OMAP: DMA: Add support
	for DMA channel self linking on OMAP1510
Date: Sun, 23 Aug 2009 19:49:43 +0100
Message-ID: <20090823184943.GA6994@opensource.wolfsonmicro.com>
References: <200908101050.02530.jkrzyszt@tis.icnet.pl> <200908231945.40187.jkrzyszt@tis.icnet.pl> <20090823180543.GA6167@opensource.wolfsonmicro.com> <200908232038.05593.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48293 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933623AbZHWStm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Aug 2009 14:49:42 -0400
Content-Disposition: inline
In-Reply-To: <200908232038.05593.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jarkko Nikula <jhnikula@gmail.com>

On Sun, Aug 23, 2009 at 08:38:05PM +0200, Janusz Krzysztofik wrote:
> Sunday 23 August 2009 20:05:43 Mark Brown wrote:

> > then what are the other 
> > patches that depend on this? Nobody reported any issues in testing with 
> > the other OMAP patches.

> Dependency on patch 1/3 is not compile time, but run time, and OMAP1510 
> specific, that's probably why nobody has reported any issues.

OK, given that and the fact that you're reporting that none of these
files are afected by any of the other patches it sounds like it'd be
better to keep it in the OMAP tree unless Tony says otherwse.
