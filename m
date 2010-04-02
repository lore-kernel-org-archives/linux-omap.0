From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC][PATCH] ASoC: OMAP: Fix capture pointer handling for
 OMAP1510 to work correctly with recent ALSA PCM code
Date: Fri, 2 Apr 2010 11:10:36 +0300
Message-ID: <20100402111036.3de0e6c7.jhnikula@gmail.com>
References: <201003282229.32922.jkrzyszt@tis.icnet.pl>
	<201003291414.53726.jkrzyszt@tis.icnet.pl>
	<20100401122520.GF32025@rakim.wolfsonmicro.main>
	<201004012145.51284.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:64057 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704Ab0DBIKj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Apr 2010 04:10:39 -0400
Received: by ewy20 with SMTP id 20so541024ewy.1
        for <linux-omap@vger.kernel.org>; Fri, 02 Apr 2010 01:10:37 -0700 (PDT)
In-Reply-To: <201004012145.51284.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>

On Thu, 1 Apr 2010 21:45:49 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> Thursday 01 April 2010 14:25:21 Mark Brown napisa=C5=82(a):
> > Any updates on this one?
>=20
> Hi Mark,
>=20
> I can only confirm that using 2.6.34-rc3, already containing Jarkko's=
 patch, I=20
> still have to apply mine to get sound working on Amstrad Delta.
>=20
> However, I still don't understand what happened to capture stream han=
dling=20
> that it stopped working for me.
>=20
While I either don't understand the broke I think there's something in
the capture DMA pointer which shows up only now. So I'm fine if you
Janusz like to get your patch in and can have my ack. Or do you want to
debug it further?

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
