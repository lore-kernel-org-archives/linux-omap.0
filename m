From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Run make savedefconfig on omap2plus_defconfig to
 shrink it
Date: Thu, 21 Apr 2011 01:59:18 -0700
Message-ID: <20110421085918.GG13688@atomide.com>
References: <20110421064423.GD13688@atomide.com>
 <20110421082328.GK31131@pengutronix.de>
 <20110421084910.GF13688@atomide.com>
 <20110421085303.GN31131@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33207 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752268Ab1DUI7W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 04:59:22 -0400
Content-Disposition: inline
In-Reply-To: <20110421085303.GN31131@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [110421 01:49]=
:
> On Thu, Apr 21, 2011 at 01:49:10AM -0700, Tony Lindgren wrote:
> > * Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [110421 01=
:20]:
> > > On Wed, Apr 20, 2011 at 11:44:23PM -0700, Tony Lindgren wrote:
> > > > This shrinks it down a bit more and makes it easier
> > > > to patch later on.
> > > Maybe pointing out why it's shrinkable would be nice.
> > > E.g.
> > >=20
> > > 	After commit
> > >=20
> > > 		ffb63e3 (omap2/3/4: Select all omaps and boards by default
> > >=20
> > > 	many explicit settings can be dropped from the defconfig.
> >=20
> > Good point, updated patch below.
> >=20
> > Regards,
> >=20
> > Tony
> >=20
> >=20
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Wed, 20 Apr 2011 23:37:06 -0700
> > Subject: [PATCH] omap: Run make savedefconfig on omap2plus_defconfi=
g to shrink it
> >=20
> > After commit ffb63e3 (omap2/3/4: Select all omaps and boards by def=
ault)
> > may explicit settings can be dropped from the defconfig.
> s/may/many/

Oops, thanks will update.
=20
> I think ffb63e3 doesn't explain all changes, but ok.

Yeah..

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
