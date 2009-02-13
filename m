From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Add support for TPS6235x support
Date: Fri, 13 Feb 2009 23:02:02 +0000
Message-ID: <20090213230201.GA6447@sirena.org.uk>
References: <1233723366-13053-1-git-send-email-mani.pillai@ti.com> <20090204115110.GA29849@sirena.org.uk> <200902131415.54104.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3310 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758291AbZBMXCO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 18:02:14 -0500
Content-Disposition: inline
In-Reply-To: <200902131415.54104.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Manikandan Pillai <mani.pillai@ti.com>, linux-omap@vger.kernel.org

On Fri, Feb 13, 2009 at 02:15:53PM -0800, David Brownell wrote:

> So what's the plan for merging it then?  I suspect it
> relates to board-specific init ... regulator_register()
> having changed signature for the 2.6.30 merge window,
> and this FIXME remaining un-addressed:

Yes, it'll need to be updated for mainline.  I'd expect the updated
version to be submitted via linux-kernel to myself and Liam (it's Liam
who'd be doing the actual merge with Linus).

> >        /* FIXME board init code should provide init_data->driver_data
> >         * saying how to configure this regulator:  how big is the
> >         * inductor (affects light PFM mode optimization), slew rate,
> >         * PLL multiplier, and so forth.
> >         */

> Maybe there should be a <linux/regulator/tps6235x.h>
> header with that board-specific data, and the framework
> data that's now thankfully not required to be held in
> the platform_data.  (That init_data->driver_data was

I'd expect that would be done for whatever data is required - it's the
standard thing and it's not new for regulator drivers either.  I've no
specific knowledge of this chip so I can't really assess what's vital to
get implemented prior to merge and what can be added in further patches
later.
