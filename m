From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated to v2.6.29-rc1, omap-2.6.28 branch added
Date: Fri, 16 Jan 2009 10:51:20 +0200
Message-ID: <20090116085118.GT4128@atomide.com>
References: <20090115154327.GF4128@atomide.com> <200901151401.17763.david-b@pacbell.net> <20090116074443.GQ4128@atomide.com> <200901152359.11433.david-b@pacbell.net> <20090116081245.GS4128@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62506 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506AbZAPIvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 03:51:19 -0500
Content-Disposition: inline
In-Reply-To: <20090116081245.GS4128@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dbrownell@users.sourceforge.net
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090116 10:13]:
> * David Brownell <david-b@pacbell.net> [090116 09:59]:
> > On Thursday 15 January 2009, Tony Lindgren wrote:
> > >=20
> > > > Then when it tries to boot, (a) the HSMMC driver reports
> > > > "error -110" then chokes, so no root FS; and then (b) MUSB
> > > > misdetects the high speed hub as full speed then chokes,
> > > > so no network links either. ....
> > >=20
> > > > That's on a trusty Beagle config. =A0I don't think I'll be
> > > > upgrading anything else just yet...
> > >=20
> > > Hmm, that sounds conservative! :)
> >=20
> > You're just trying to get me to find out what's broken
> > and fix it!  I'm on to that particular dastardly plot...  ;)
>=20
> Oh no, busted!
>=20
> > It'd be somewhat usable if the MMC were live.
>=20
> Seems to work on at least overo, no ideas what might have
> happened to it on beagle.

MMC seems to work also on omap3430sdp.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
