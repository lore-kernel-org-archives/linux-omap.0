From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 21/33] add OMAP HighSpeed mmc controller driver
Date: Sun, 31 Aug 2008 14:51:18 -0700
Message-ID: <200808311451.18565.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <200808311406.14234.david-b@pacbell.net> <20080831213105.GG9887@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:25157 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753989AbYHaVvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:51:20 -0400
In-Reply-To: <20080831213105.GG9887@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sunday 31 August 2008, Felipe Balbi wrote:
>=20
> > One reason I'd like to see this particular driver upstream is
> > so that folk using www.beagleboard.org hardware can stand a
> > real chance of using mainline kernels for development. =A0That's
> > a small set of drivers, so that's a very achievable goal.
>=20
> Agreed. But we're missing omap3 stuff on mainline still,

=46ixable, I'd expect.  :)


> so even if we=20
> have all the drivers there. Mainline has support up to omap2430, if i=
'm
> not wrong. So looks like beagleboard users will have to wait a bit
> longer.

Well, it's not a 2.6.27 goal.  But I'd think it should be very
possible for 2.6.28 merging.

However, I'll re-emphasize that doing that means submitting the
patches for real, not to the OMAP list.  And since mainline is
now at RC5, there's not a lot of time yet to get this new code
reviewed and entered into the MMC queue...

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
