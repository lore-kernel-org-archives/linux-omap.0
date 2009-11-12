From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] Add ASoC support for DEVKIT8000
Date: Thu, 12 Nov 2009 13:00:33 +0000
Message-ID: <20091112130033.GC11656@sirena.org.uk>
References: <8e4f2cbd8c0fccce7759ee7545699e1d@djdvant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52292 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbZKLNA2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 08:00:28 -0500
Content-Disposition: inline
In-Reply-To: <8e4f2cbd8c0fccce7759ee7545699e1d@djdvant.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Botherway <kbotherway@djdvant.com>
Cc: alsa-devel@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Nov 12, 2009 at 09:24:43PM +1100, Kim Botherway wrote:
> This patch add support for DEVKIT8000, it is a copy of Beagleboard sound
> driver

You forgot your Signed-off-by here.  Please also remember to CC the
maintainers on patch submissions.

If this genuinely is just a straight copy of the Beagleboard driver then
it would be better to do this by changing the existing driver so that it
can be built and loaded on both boards, together with updating the
Kconfig so users can see which driver to use for DEVKIT8000.
