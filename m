From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH] ASoC: OMAP: Fix capture pointer handling for OMAP1510 to work correctly with recent ALSA PCM code
Date: Fri, 2 Apr 2010 12:51:44 +0200
Message-ID: <201004021251.47488.jkrzyszt@tis.icnet.pl>
References: <201003282229.32922.jkrzyszt@tis.icnet.pl> <20100402111036.3de0e6c7.jhnikula@gmail.com> <20100402093655.GA11134@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:34361 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909Ab0DBKwr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Apr 2010 06:52:47 -0400
In-Reply-To: <20100402093655.GA11134@rakim.wolfsonmicro.main>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>

=46riday 02 April 2010 11:36:56 Mark Brown napisa=C5=82(a):
> On Fri, Apr 02, 2010 at 11:10:36AM +0300, Jarkko Nikula wrote:
> > Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > > However, I still don't understand what happened to capture stream
> > > handling that it stopped working for me.
> >
> > While I either don't understand the broke I think there's something=
 in
> > the capture DMA pointer which shows up only now. So I'm fine if you
> > Janusz like to get your patch in and can have my ack. Or do you wan=
t to
> > debug it further?
> >
> > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
>
> Personally I don't mind as long as you guys are happy - Janusz?

I don't mind either :), please apply.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
