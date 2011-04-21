From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] omap: Run make savedefconfig on omap2plus_defconfig to
 shrink it
Date: Thu, 21 Apr 2011 10:23:28 +0200
Message-ID: <20110421082328.GK31131@pengutronix.de>
References: <20110421064423.GD13688@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43649 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab1DUIXa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 04:23:30 -0400
Content-Disposition: inline
In-Reply-To: <20110421064423.GD13688@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Apr 20, 2011 at 11:44:23PM -0700, Tony Lindgren wrote:
> This shrinks it down a bit more and makes it easier
> to patch later on.
Maybe pointing out why it's shrinkable would be nice.
E.g.

	After commit

		ffb63e3 (omap2/3/4: Select all omaps and boards by default

	many explicit settings can be dropped from the defconfig.

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
