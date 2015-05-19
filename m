From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: rx51: use flags argument of devm_gpiod_get to set
 direction
Date: Tue, 19 May 2015 14:10:05 +0200
Message-ID: <20150519121005.GD24769@pengutronix.de>
References: <1432021688-25830-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150519081650.GA8310@bitmer.com>
 <20150519104458.GF2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43813 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbbESMKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2015 08:10:15 -0400
Content-Disposition: inline
In-Reply-To: <20150519104458.GF2761@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>

On Tue, May 19, 2015 at 11:44:58AM +0100, Mark Brown wrote:
> On Tue, May 19, 2015 at 11:16:50AM +0300, Jarkko Nikula wrote:
>=20
> > I don't think Fixes tag is justified. Otherwise than that
>=20
> Yes, I don't see any bug fixing here - am I missing something?
It only becomes a bug once the flags parameter becomes mandatory. But
right, currently it's not a bug, just inefficient use of the gpiod
stuff.

=46eel free to drop the Fixes: on application.

Best regards
Uwe



--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
