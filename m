From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCHv4 7/7] ASoC: TWL6030: Detect power-up
	sequence completion
Date: Fri, 26 Feb 2010 21:27:18 +0000
Message-ID: <20100226212717.GB6615@sirena.org.uk>
References: <1889FA7136B567478A67D4B0F85B0CCE65DD1B19@dlee06.ent.ti.com> <20100224135909.GR18896@rakim.wolfsonmicro.main> <1889FA7136B567478A67D4B0F85B0CCE65DD230C@dlee06.ent.ti.com> <6119755B-D3CB-4E4C-ADA2-8AE64EBE4711@opensource.wolfsonmicro.com> <1889FA7136B567478A67D4B0F85B0CCE65E7E3FF@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:60012 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966162Ab0BZV1T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 16:27:19 -0500
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCE65E7E3FF@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

On Fri, Feb 26, 2010 at 03:04:22PM -0600, Olaya, Margarita wrote:

> In both cases if READYINIT is not set before the timeout runs out it means
> the codec is not powering on and the driver reports an error.

That's kind of my point - because you're checking for the same status
there shouldn't be any need to special case the situation where there's
no interrupt, I'd expect to be able to use wait_for_timeout_interruptible()
for the delay and have the timeout completion interrupt cause that to be
signalled.  No *terribly* important but it makes it clearer what's going
on.
