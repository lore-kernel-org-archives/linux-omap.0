From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/9] omap: define _toggle_gpio_edge_triggering only for
	OMAP1
Date: Wed, 3 Feb 2010 09:13:13 +0100
Message-ID: <20100203081313.GB11354@pengutronix.de>
References: <20100203022318.26347.34734.stgit@baageli.muru.com> <20100203022555.26347.62876.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33480 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab0BCINR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 03:13:17 -0500
Content-Disposition: inline
In-Reply-To: <20100203022555.26347.62876.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

Hi Tony,

On Tue, Feb 02, 2010 at 06:25:55PM -0800, Tony Lindgren wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> The only usage of _toggle_gpio_edge_triggering is in an
> CONFIG_ARCH_OMAP1 is defined, too.
This sentence is broken, isn't it?  I guess git commit played tricks on
me here and removed a line, something like:

	#ifdef CONFIG_ARCH_OMAP1 block, so only provide it if

Can you add it back?  I'd recommend doing the line break before the "an=
"
in the first line instead of behind it.

Thanks
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
