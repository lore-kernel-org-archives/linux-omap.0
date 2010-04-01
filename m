From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH] ASoC: OMAP: Fix capture pointer handling for OMAP1510 to work correctly with recent ALSA PCM code
Date: Thu, 1 Apr 2010 21:45:49 +0200
Message-ID: <201004012145.51284.jkrzyszt@tis.icnet.pl>
References: <201003282229.32922.jkrzyszt@tis.icnet.pl> <201003291414.53726.jkrzyszt@tis.icnet.pl> <20100401122520.GF32025@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:34787 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab0DATqo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 15:46:44 -0400
In-Reply-To: <20100401122520.GF32025@rakim.wolfsonmicro.main>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>

Thursday 01 April 2010 14:25:21 Mark Brown napisa=C5=82(a):
> On Mon, Mar 29, 2010 at 02:14:51PM +0200, Janusz Krzysztofik wrote:
> > I should have mention that I was already aware of your patch; appli=
ed
> > alone, it didn't solve the problem for me. However, when configurin=
g ALSA
> > with debugging turned off, I have to use both patches, yours and mi=
ne, in
> > order to get things working.
>
> Any updates on this one?

Hi Mark,

I can only confirm that using 2.6.34-rc3, already containing Jarkko's p=
atch, I=20
still have to apply mine to get sound working on Amstrad Delta.

However, I still don't understand what happened to capture stream handl=
ing=20
that it stopped working for me.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
