From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Thu, 30 Oct 2008 20:39:37 -0700
Message-ID: <20081031033936.GC13227@atomide.com>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <1225418657-31775-3-git-send-email-tony@atomide.com> <1225418657-31775-4-git-send-email-tony@atomide.com> <200810302012.35317.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54761 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbYJaDji (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 23:39:38 -0400
Content-Disposition: inline
In-Reply-To: <200810302012.35317.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081030 20:12]:
> On Thursday 30 October 2008, Tony Lindgren wrote:
> > @@ -212,7 +212,7 @@ static void __init overo_init(void)
> > =A0=A0=A0=A0=A0=A0=A0=A0omap_board_config =3D overo_config;
> > =A0=A0=A0=A0=A0=A0=A0=A0omap_board_config_size =3D ARRAY_SIZE(overo=
_config);
> > =A0=A0=A0=A0=A0=A0=A0=A0omap_serial_init();
> > -=A0=A0=A0=A0=A0=A0=A0hsmmc_init();
> > +=A0=A0=A0=A0=A0=A0=A0hsmmc_init(HSMMC1);
>=20
> Overo has its SDIO WLAN chip (libertas) hard wired to the second cont=
roller,
> as I understand things ... or maybe it's the third one.  :)

OK

> Related:  shouldn't hsmmc_init() accept a set of params, maybe even a=
 struct,
> describing how each controller is wired?
>=20
> 	- which controller (1, 2, 3)
> 	- how many data wires are used (1, 4, 8)
> 	- supported voltages (mask)
> 	- card detect gpio (or negative) ... assume gpio_to_irq(gpio) works
> 	- write protect gpio (or negative)
> 	- callback for updating the voltages
>=20
> That would support more complete functionality ... and get away from
> the current hard-wiring of most of those parameters.

Yeah I don't know what the right solution is.. I was thinking about
passing the struct omap_mmc_platform_data to hsmmc_init, but then
again hsmmc.c does not know anything about the custom configurations
and the power functions. So right now hsmmc.c would only call
omap2_init_mmc() with the custom struct omap_mmc_platform_data.

Maybe we should just let the boards with non-standarad wiring additiona=
lly
initialize the other mmc controllers from board-*.c by calling
omap2_init_mmc()?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
