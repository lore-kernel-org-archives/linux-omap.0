From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCHv7] media: i2c/adp1653: fix includes
Date: Thu, 9 Apr 2015 14:59:27 +0200
Message-ID: <20150409125927.GC12339@atrey.karlin.mff.cuni.cz>
References: <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd>
 <20150409091017.GA4526@earth>
 <20150409112943.GA31173@amd>
 <20150409121913.GB18713@earth>
 <20150409123155.GB9563@amd>
 <CABxcv=mB=LqO2paGfYq1jCbky=kudT-mS8cJ-pPwdqZYQLeO4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35914 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbbDIM7c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2015 08:59:32 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=mB=LqO2paGfYq1jCbky=kudT-mS8cJ-pPwdqZYQLeO4A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Sakari Ailus <sakari.ailus@iki.fi>, Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, Kumar Gala <galak@codeaurora.org>, Benoit Cousson <bcousson@baylibre.com>, m.chehab@samsung.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, mchehab@osg.samsung.com, hverkuil@xs4all.nl

On Thursday 09 April 2015 14:43:59 Javier Martinez Canillas wrote:
> Hello Pavel,
>=20
> >
> > diff --git a/drivers/media/i2c/adp1653.c b/drivers/media/i2c/adp165=
3.c
> > index d703636..7107ac2 100644
> > --- a/drivers/media/i2c/adp1653.c
> > +++ b/drivers/media/i2c/adp1653.c
> > @@ -35,8 +35,8 @@
> >  #include <linux/module.h>
> >  #include <linux/i2c.h>
> >  #include <linux/slab.h>
> > -#include <linux/of_gpio.h>
> > -#include <linux/gpio.h>
> > +#include <linux/of.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <media/adp1653.h>
> >  #include <media/v4l2-device.h>
> >
>=20
> Please re-spin your previous patch and submit it properly.
>=20
> Best regards,
> Javier

Hi all! What about stopping this meaningless discussion about resending
full patch series when everybody know how to fix is quickly in editor
(e.g with sed under 5s) and not wasting another 10 minutes to generate
new unified diff sent via SMTP protocol?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
