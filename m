From: Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH] cbus-retu-wdt: Remove unused nonstandard interfaces
Date: Wed, 09 Mar 2011 18:40:16 +0100
Message-ID: <1299692416.1911.3.camel@marge>
References: <1299082318.13604.14.camel@marge>
	 <20110303094251.GG2644@legolas.emea.dhcp.ti.com>
	 <1299161893.31972.0.camel@maggie>  <20110308230234.GF26463@atomide.com>
	 (sfid-20110309_000259_418108_FFFFFFFFFE7D62D0)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:49575 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757109Ab1CIRkW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 12:40:22 -0500
In-Reply-To: <20110308230234.GF26463@atomide.com> (sfid-20110309_000259_418108_FFFFFFFFFE7D62D0)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, linux-omap <linux-omap@vger.kernel.org>

On Tue, 2011-03-08 at 15:02 -0800, Tony Lindgren wrote:
> * Michael B=C3=BCsch <mb@bu3sch.de> [110303 06:16]:
> > On Thu, 2011-03-03 at 11:42 +0200, Felipe Balbi wrote:=20
> > > On Wed, Mar 02, 2011 at 05:11:58PM +0100, Michael Buesch wrote:
> > > > @@ -175,9 +124,9 @@ static int retu_wdt_release(struct inode
> > > >  	struct retu_wdt_dev *wdev =3D file->private_data;
> > > > =20
> > > >  #ifndef CONFIG_WATCHDOG_NOWAYOUT
> > > > -	retu_wdt_ping_enable(retu_wdt);
> > > > +	retu_wdt_ping_enable(wdev);
> > > >  #endif
> > > > -	clear_bit(0, &retu_wdt->users);
> > > > +	clear_bit(0, &wdev->users);
> > >=20
> > > this hunk isn't part of this patch.
> >=20
> > Well, it's a compiler warning cleanup, so I thought it would be fin=
e
> > to go with the big cleanup patch.
> > Is it necessary to do a separate patch for this?
>=20
> Well looks like I already applied some earlier version of
> this.. Sorry.
>=20
> Anyways, can you please check what's still missing from
> the cbus branch? I've now applied the ones Felipe acked.

The cbus branch seems to contain all patches that I
sent recently.

--=20
Greetings, Michael.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
