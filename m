From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] watchdog: omap: put struct watchdog_device into
 driver data
Date: Fri, 24 Apr 2015 21:10:59 +0200
Message-ID: <20150424191059.GW19431@pengutronix.de>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1429868913-24049-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150424144448.GC5692@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45614 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757650AbbDXTLE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2015 15:11:04 -0400
Content-Disposition: inline
In-Reply-To: <20150424144448.GC5692@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Lokesh Vutla <lokeshvutla@ti.com>, kernel@pengutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hello Felipe,

On Fri, Apr 24, 2015 at 09:44:48AM -0500, Felipe Balbi wrote:
> On Fri, Apr 24, 2015 at 11:48:32AM +0200, Uwe Kleine-K=F6nig wrote:
> > This way only a single allocation is needed (per device). Also this
> > stops making use of watchdog_{set,get}_drvdata.
>=20
> And this is better because ... ?
a single allocation is better because AFAIK it takes less memory to
allocate a + b bytes in a single piece than in two.

watchdog_{set,get}_drvdata seems ugly to me. Judging from the other
frameworks I know better than wdog I'd say there is no need for these
functions. I didn't know if I should be more explicit about my view in
the commitlog and if so how.

Also I didn't check other wdog drivers, but using this style of
embedding the "framework struct" into driver data is a common idiom for
uart and gpio drivers for example.

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
