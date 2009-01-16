From: David Brownell <david-b@pacbell.net>
Subject: Re: Git tree updated to v2.6.29-rc1, omap-2.6.28 branch added
Date: Thu, 15 Jan 2009 23:59:11 -0800
Message-ID: <200901152359.11433.david-b@pacbell.net>
References: <20090115154327.GF4128@atomide.com> <200901151401.17763.david-b@pacbell.net> <20090116074443.GQ4128@atomide.com>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:46709 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753213AbZAPH7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Jan 2009 02:59:13 -0500
In-Reply-To: <20090116074443.GQ4128@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 15 January 2009, Tony Lindgren wrote:
>=20
> > Then when it tries to boot, (a) the HSMMC driver reports
> > "error -110" then chokes, so no root FS; and then (b) MUSB
> > misdetects the high speed hub as full speed then chokes,
> > so no network links either. ....
>=20
> > That's on a trusty Beagle config. =A0I don't think I'll be
> > upgrading anything else just yet...
>=20
> Hmm, that sounds conservative! :)

You're just trying to get me to find out what's broken
and fix it!  I'm on to that particular dastardly plot...  ;)

It'd be somewhat usable if the MMC were live.

- dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
