From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] cbus-retu-wdt: Remove unused nonstandard interfaces
Date: Tue, 8 Mar 2011 15:02:35 -0800
Message-ID: <20110308230234.GF26463@atomide.com>
References: <1299082318.13604.14.camel@marge>
 <20110303094251.GG2644@legolas.emea.dhcp.ti.com>
 <1299161893.31972.0.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:14683 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800Ab1CHXCu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 18:02:50 -0500
Content-Disposition: inline
In-Reply-To: <1299161893.31972.0.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?utf-8?B?QsO8c2No?= <mb@bu3sch.de>
Cc: balbi@ti.com, linux-omap <linux-omap@vger.kernel.org>

* Michael B=C3=BCsch <mb@bu3sch.de> [110303 06:16]:
> On Thu, 2011-03-03 at 11:42 +0200, Felipe Balbi wrote:=20
> > On Wed, Mar 02, 2011 at 05:11:58PM +0100, Michael Buesch wrote:
> > > @@ -175,9 +124,9 @@ static int retu_wdt_release(struct inode
> > >  	struct retu_wdt_dev *wdev =3D file->private_data;
> > > =20
> > >  #ifndef CONFIG_WATCHDOG_NOWAYOUT
> > > -	retu_wdt_ping_enable(retu_wdt);
> > > +	retu_wdt_ping_enable(wdev);
> > >  #endif
> > > -	clear_bit(0, &retu_wdt->users);
> > > +	clear_bit(0, &wdev->users);
> >=20
> > this hunk isn't part of this patch.
>=20
> Well, it's a compiler warning cleanup, so I thought it would be fine
> to go with the big cleanup patch.
> Is it necessary to do a separate patch for this?

Well looks like I already applied some earlier version of
this.. Sorry.

Anyways, can you please check what's still missing from
the cbus branch? I've now applied the ones Felipe acked.

At least this patch needs to be refreshed to apply on
top of the cbus branch.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
