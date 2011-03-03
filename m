From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus-retu-wdt: Remove unused nonstandard interfaces
Date: Thu, 3 Mar 2011 16:27:53 +0200
Message-ID: <20110303142752.GT2644@legolas.emea.dhcp.ti.com>
References: <1299082318.13604.14.camel@marge>
 <20110303094251.GG2644@legolas.emea.dhcp.ti.com>
 <1299161893.31972.0.camel@maggie>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:59838 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757914Ab1CCO14 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 09:27:56 -0500
Received: by mail-bw0-f44.google.com with SMTP id 13so1386286bwz.31
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 06:27:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299161893.31972.0.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Thu, Mar 03, 2011 at 03:18:13PM +0100, Michael B=FCsch wrote:
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

I think so, yes. It'll keep the history nice and clean.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
