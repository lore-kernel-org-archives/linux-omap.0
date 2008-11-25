From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [alsa-devel] [PATCH] ASoC: Fix TW4030 Kconfig dependency
Date: Tue, 25 Nov 2008 20:04:15 +0000
Message-ID: <20081125200411.GA6572@sirena.org.uk>
References: <1227587172-9523-1-git-send-email-arunks@mistralsolutions.com> <200811242044.13438.david-b@pacbell.net> <20081125153013.GH12414@sirena.org.uk> <200811251054.29156.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2355 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbYKYUEa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 15:04:30 -0500
Content-Disposition: inline
In-Reply-To: <200811251054.29156.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: arunks@mistralsolutions.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, steve@sakoman.com

On Tue, Nov 25, 2008 at 10:54:28AM -0800, David Brownell wrote:

> I'm not sure what you mean by "machine driver" ... there seem
> to be two:  arch/arm/mach-omap2/board-*.c for everything except
> ALSA, and then sound/soc/omap/*.c for the ASoC bits.

I meant the arch/arm one.

> As a rule, it's worth avoiding "select" in Kconfig; it doesn't
> work well, since it won't even report missing dependencies much
> less fix the trivial ones.

Right, I'm just thinking that for something like this it might not be
worth turning off the TWL4030 core support given that these sorts of
southbridgeish chips tend to be pretty key to the system.  It was just
an idle thought, anyway.

BTW, it'd also be really handy if you could remove the OMAP dependencies
from TWL4030_CORE - I know it currently needs them to actually be useful
at runtime but it'd mean that it's possible to build things like the
codec driver on other configs which helps when working on subsystems.
