From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] watchdog: omap: use watchdog_init_timeout
Date: Fri, 24 Apr 2015 21:02:07 +0200
Message-ID: <20150424190207.GU19431@pengutronix.de>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1429868913-24049-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150424144259.GB5692@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45526 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030318AbbDXTCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2015 15:02:16 -0400
Content-Disposition: inline
In-Reply-To: <20150424144259.GB5692@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Lokesh Vutla <lokeshvutla@ti.com>, kernel@pengutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Apr 24, 2015 at 09:42:59AM -0500, Felipe Balbi wrote:
> Hi,
>=20
> On Fri, Apr 24, 2015 at 11:48:31AM +0200, Uwe Kleine-K=F6nig wrote:
> > Instead of (partly) open coding it use the core function. As a side
> > effect the "timeout-sec" devicetree property is used now.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/watchdog/omap-wdt.txt | 9 +++++-=
---
> >  drivers/watchdog/omap_wdt.c                             | 5 +----
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/watchdog/omap-wdt.tx=
t b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> > index c227970671ea..4f18ec38be2f 100644
> > --- a/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> > +++ b/Documentation/devicetree/bindings/watchdog/omap-wdt.txt
> > @@ -1,10 +1,11 @@
> >  TI Watchdog Timer (WDT) Controller for OMAP
> > =20
> >  Required properties:
> > -compatible:
> > -- "ti,omap3-wdt" for OMAP3
> > -- "ti,omap4-wdt" for OMAP4
> > -- ti,hwmods: Name of the hwmod associated to the WDT
> > +- compatible : "ti,omap3-wdt" (for OMAP3) or "ti,omap4-wdt" (for O=
MAP4)
> > +- ti,hwmods : Name of the hwmod associated to the WDT
> > +
> > +Optional properties:
> > +- timeout-sec : default watchdog timeout in seconds
>=20
> adding a new property here ? Why ? In fact, none of these DT binding =
doc
> changes fit in $subject. Sure, watchdog_init_timeout() needs
> timeout-sec, but no OMAP DT today passes it.
watchdog_init_timeout doesn't *need* the new property. After all it's
optional. The other changes are just reformatting to make it match the
usual style and make it understandable. Could have mentioned it in the
commitlog, that's true.

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
