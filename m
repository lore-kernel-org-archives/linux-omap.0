From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCHv3 3/4] Add ASoC support for DevKit8000
Date: Thu, 11 Feb 2010 16:42:28 +0000
Message-ID: <20100211164227.GA18464@sirena.org.uk>
References: <1265829784-19224-1-git-send-email-swirl@gmx.li> <1265885388.3179.8.camel@odin> <20100211131418.9521c603.jhnikula@gmail.com> <201002111702.54783.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59207 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127Ab0BKQmb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 11:42:31 -0500
Content-Disposition: inline
In-Reply-To: <201002111702.54783.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, Thomas Weber <swirl@gmx.li>, "weber@corscience.de" <weber@corscience.de>, "tony@atomride.com" <tony@atomride.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Thu, Feb 11, 2010 at 05:02:54PM +0200, Peter Ujfalusi wrote:
> On Thursday 11 February 2010 13:14:18 ext Jarkko Nikula wrote:

> > Yeah, after thinking twice, we don't have zillions of options for e.g.
> > Intel HDA either. If we ever figure out some common OMAP+TWL4030

> Well, I really doubt that we can find a way to have a common driver for this 
> combination. You can attach quite a big variety of amps to the outputs (some 
> controlled with GPIO, some like the tpa6130 has i2c interface, etc).
> To have some kind of "infrastructure" to support all of the possible scenarios 
> is just does not worth the effort IMHO.

On the other hand there's probably going to be a bunch of boards which
can use the same driver by virtue of having copied the audio subsystem
en masse from one of the reference designs.
