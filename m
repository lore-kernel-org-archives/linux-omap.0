From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] omap: Run make savedefconfig on omap2plus_defconfig to
 shrink it
Date: Thu, 21 Apr 2011 10:53:03 +0200
Message-ID: <20110421085303.GN31131@pengutronix.de>
References: <20110421064423.GD13688@atomide.com>
 <20110421082328.GK31131@pengutronix.de>
 <20110421084910.GF13688@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40773 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1DUIxF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 04:53:05 -0400
Content-Disposition: inline
In-Reply-To: <20110421084910.GF13688@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thu, Apr 21, 2011 at 01:49:10AM -0700, Tony Lindgren wrote:
> * Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> [110421 01:20]:
> > On Wed, Apr 20, 2011 at 11:44:23PM -0700, Tony Lindgren wrote:
> > > This shrinks it down a bit more and makes it easier
> > > to patch later on.
> > Maybe pointing out why it's shrinkable would be nice.
> > E.g.
> >=20
> > 	After commit
> >=20
> > 		ffb63e3 (omap2/3/4: Select all omaps and boards by default
> >=20
> > 	many explicit settings can be dropped from the defconfig.
>=20
> Good point, updated patch below.
>=20
> Regards,
>=20
> Tony
>=20
>=20
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 20 Apr 2011 23:37:06 -0700
> Subject: [PATCH] omap: Run make savedefconfig on omap2plus_defconfig =
to shrink it
>=20
> After commit ffb63e3 (omap2/3/4: Select all omaps and boards by defau=
lt)
> may explicit settings can be dropped from the defconfig.
s/may/many/

I think ffb63e3 doesn't explain all changes, but ok.

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
