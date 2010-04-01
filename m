From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: OMAP: Fix capture pointer handling for
 OMAP1510 to work correctly with recent ALSA PCM code
Date: Thu, 1 Apr 2010 13:25:21 +0100
Message-ID: <20100401122520.GF32025@rakim.wolfsonmicro.main>
References: <201003282229.32922.jkrzyszt@tis.icnet.pl>
 <20100329115459.b44f0d1c.jhnikula@gmail.com>
 <201003291414.53726.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55508 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755783Ab0DAMZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 08:25:23 -0400
Content-Disposition: inline
In-Reply-To: <201003291414.53726.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>

On Mon, Mar 29, 2010 at 02:14:51PM +0200, Janusz Krzysztofik wrote:

> I should have mention that I was already aware of your patch; applied alone, 
> it didn't solve the problem for me. However, when configuring ALSA with 
> debugging turned off, I have to use both patches, yours and mine, in order to 
> get things working.

Any updates on this one?
