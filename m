From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: OMAP: Fix capture pointer handling for
 OMAP1510 to work correctly with recent ALSA PCM code
Date: Fri, 2 Apr 2010 17:12:30 +0100
Message-ID: <20100402161230.GB15928@rakim.wolfsonmicro.main>
References: <201003282229.32922.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43499 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752153Ab0DBQMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Apr 2010 12:12:32 -0400
Content-Disposition: inline
In-Reply-To: <201003282229.32922.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Mar 28, 2010 at 10:29:29PM +0200, Janusz Krzysztofik wrote:

> The patch reuses the method for software emulation of missing hardware 
> pointer, already implemented for playback on OMAP1510. It's possible that 
> event if a hardware pointer is available for capture on this machine, its 
> behaviour may be not compatible with what upper layer expects.

Applied, thanks.
