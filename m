From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 22:22:13 +0200
Message-ID: <20110415202213.GP31990@pengutronix.de>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
 <20110415201107.GO31990@pengutronix.de>
 <20110415201925.GK4423@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52332 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab1DOUWU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 16:22:20 -0400
Content-Disposition: inline
In-Reply-To: <20110415201925.GK4423@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 15, 2011 at 09:19:25PM +0100, Russell King - ARM Linux wrot=
e:
> On Fri, Apr 15, 2011 at 10:11:07PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux =
wrote:
> > > This is work in progress.
> > >=20
> > > We have two SoCs using SRAM, both with their own allocation syste=
ms,
> > > and both with their own ways of copying functions into the SRAM.
> > I havn't checked the details, but maybe the code in
> > arch/arm/plat-mxc/iram_alloc.c could be migrated to your approach, =
too?
>=20
> Its already in there now that I have replies from Nguyen Dinh.  It
> looks like this presently:
>=20
>  arch/arm/plat-mxc/Kconfig                   |    2 +-
>  arch/arm/plat-mxc/include/mach/iram.h       |   24 +++++++--
>  arch/arm/plat-mxc/iram_alloc.c              |   50 +++++------------=
---
>=20
> and if we get rid of the iram_alloc/iram_free wrappers around the
> sram_pool (now pv_pool) alloc/free in iram.h, in the same way I've
> done for Davinci, then we get less new additions too.
Great!

Thanks,
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
