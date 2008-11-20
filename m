From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: (non-hs)mmc vs lockdep
Date: Thu, 20 Nov 2008 21:10:09 +0200
Message-ID: <20081120191008.GG31944@frodo>
References: <ef0d8a250811200202o5852dabct8c5b135b86141f67@mail.gmail.com> <20081120173206.GL4927@atomide.com> <20081120174236.GQ7476@gandalf.research.nokia.com> <200811201056.28399.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:54841 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019AbYKTTKT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2008 14:10:19 -0500
Content-Disposition: inline
In-Reply-To: <200811201056.28399.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

On Thu, Nov 20, 2008 at 10:56:28AM -0800, David Brownell wrote:
> On Thursday 20 November 2008, Felipe Balbi wrote:
> > > > =A0TI OMAP MMC INTERFACE DRIVER
> > > > =A0P: =A0 =A0 Carlos Aguiar, Anderson Briglia and Syed Khasim
> > > > =A0M: =A0 =A0 linux-omap@vger.kernel.org
> > >=20
> > >=20
> > > Yeah sure. Let's also add maintainers for omap subsystems that ha=
ve
> > > maintainers while we're at it.
> >=20
> > sounds good. At least mmc is already there.
>=20
> So, who's going to fix the bug with the non-highspeed MMC controller
> driver whereby it breaks with LOCKDEP enabled?
>=20
> The "BUG_ON(irqs_disabled());" in mmc_omap_start_request() triggers,
> since something inside the latest ARM MM code assumes it's never call=
ed
> with IRQs blocked ... a regression was introduced at some point.  The
> same failure is seen in some other MMC controller drivers.

Well, I haven't seen patches from none of the three maintainers for
quite a while. Maybe someone at TI could take over the driver(s) ??

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
