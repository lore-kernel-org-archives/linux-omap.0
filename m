From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] omap: define _toggle_gpio_edge_triggering only for
 OMAP1
Date: Wed, 3 Feb 2010 09:25:57 -0800
Message-ID: <20100203172557.GE22747@atomide.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
 <20100203022555.26347.62876.stgit@baageli.muru.com>
 <20100203081313.GB11354@pengutronix.de>
 <20100203165754.GA22747@atomide.com>
 <20100203171026.GO11354@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63221 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932656Ab0BCR0K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 12:26:10 -0500
Content-Disposition: inline
In-Reply-To: <20100203171026.GO11354@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [100203 09:07]=
:
> Hello Tony,
>=20
> On Wed, Feb 03, 2010 at 08:57:55AM -0800, Tony Lindgren wrote:
> > BTW, looks like with "git show --pretty=3Demail" the From: field ge=
ts
> > messed up in the patch below. Author name shows OK in git though.
> >=20
> > I wonder if that's a git bug for --pretty=3Demail? Using version
> > 1.6.6.1 it seems.
> That's not a bug, but a feature.  This is normal rfcforgotthenumber m=
ail
> header quoting.  (2822?)

Oh right, the email headers need to be ASCII still. Was not aware of
how umlauts should be encoded into the name though. It seems that
all my fellow Finns have erased the umlauts from their email addresses,
at least in my aliases file.

Tony

>=20
> >=20
> > Tony
>=20
> > From 9198bcd39f558dd56823f1c9983e2252fc99a501 Mon Sep 17 00:00:00 2=
001
> > From: =3D?UTF-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koeni=
g@pengutronix.de>
>=20
> Thanks
> Uwe
>=20
> --=20
> Pengutronix e.K.                              | Uwe Kleine-K=C3=B6nig=
            |
> Industrial Linux Solutions                    | http://www.pengutroni=
x.de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
