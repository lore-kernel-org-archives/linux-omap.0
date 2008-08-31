From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 21/33] add OMAP HighSpeed mmc controller driver
Date: Mon, 1 Sep 2008 00:31:12 +0300
Message-ID: <20080831213105.GG9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-21-git-send-email-me@felipebalbi.com> <1220116593-862-22-git-send-email-me@felipebalbi.com> <200808311406.14234.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49863 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758157AbYHaVbq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:31:46 -0400
Content-Disposition: inline
In-Reply-To: <200808311406.14234.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sun, Aug 31, 2008 at 02:06:13PM -0700, David Brownell wrote:
> On Saturday 30 August 2008, Felipe Balbi wrote:
> > From: Felipe Balbi <felipe.balbi@nokia.com>
> >=20
> > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > ---
> > =A0drivers/mmc/host/Kconfig =A0 =A0 =A0| =A0 13 +-
> > =A0drivers/mmc/host/Makefile =A0 =A0 | =A0 =A01 +
> > =A0drivers/mmc/host/omap_hsmmc.c | 1069 +++++++++++++++++++++++++++=
++++++++++++++
> > =A03 files changed, 1082 insertions(+), 1 deletions(-)
> > =A0create mode 100644 drivers/mmc/host/omap_hsmmc.c
>=20
> OK, this one may need cleanup ... but I don't disagree that it
> should go upstream.
>=20
> Now the process for getting it there involves posting to LKML
> and probably CCing the MMC maintainer...
>=20
> One reason I'd like to see this particular driver upstream is
> so that folk using www.beagleboard.org hardware can stand a
> real chance of using mainline kernels for development.  That's
> a small set of drivers, so that's a very achievable goal.

Agreed. But we're missing omap3 stuff on mainline still, so even if we
have all the drivers there. Mainline has support up to omap2430, if i'm
not wrong. So looks like beagleboard users will have to wait a bit
longer.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
