From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/29] ARM: OMAP1: Move board-ams-delta.h from plat to
 mach
Date: Thu, 20 Sep 2012 10:12:41 -0700
Message-ID: <20120920171134.GB28835@atomide.com>
References: <20120919205732.28074.43697.stgit@muffinssi>
 <20120919210543.28074.10214.stgit@muffinssi>
 <20120920011630.GB17666@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:32288 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751424Ab2ITRMp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 13:12:45 -0400
Content-Disposition: inline
In-Reply-To: <20120920011630.GB17666@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mtd@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [120919 19:05]:
> On Wed, Sep 19, 2012 at 02:05:43PM -0700, Tony Lindgren wrote:
> > This is only used by omap1.
> > 
> > And to fix things properly, this should not be included
> > from the drivers at all.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> or I can apply it if that's easier.

Thanks I'll do a series for Arnd on top of the multiplatform
changes to avoid more merge conflicts.

Regards,

Tony
