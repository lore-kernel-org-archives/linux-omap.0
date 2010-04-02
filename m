From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: OMAP: Fix capture pointer handling for
 OMAP1510 to work correctly with recent ALSA PCM code
Date: Fri, 2 Apr 2010 10:36:56 +0100
Message-ID: <20100402093655.GA11134@rakim.wolfsonmicro.main>
References: <201003282229.32922.jkrzyszt@tis.icnet.pl>
 <201003291414.53726.jkrzyszt@tis.icnet.pl>
 <20100401122520.GF32025@rakim.wolfsonmicro.main>
 <201004012145.51284.jkrzyszt@tis.icnet.pl>
 <20100402111036.3de0e6c7.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40135 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753484Ab0DBJg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Apr 2010 05:36:59 -0400
Content-Disposition: inline
In-Reply-To: <20100402111036.3de0e6c7.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>

On Fri, Apr 02, 2010 at 11:10:36AM +0300, Jarkko Nikula wrote:
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> > However, I still don't understand what happened to capture stream handling 
> > that it stopped working for me.

> While I either don't understand the broke I think there's something in
> the capture DMA pointer which shows up only now. So I'm fine if you
> Janusz like to get your patch in and can have my ack. Or do you want to
> debug it further?

> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Personally I don't mind as long as you guys are happy - Janusz?
