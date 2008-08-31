From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 30/33] add omap backlight support
Date: Mon, 1 Sep 2008 00:44:17 +0300
Message-ID: <20080831214415.GL9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-30-git-send-email-me@felipebalbi.com> <1220116593-862-31-git-send-email-me@felipebalbi.com> <200808311412.47568.david-b@pacbell.net> <20080831212317.GD9887@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:36281 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbYHaVow (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:44:52 -0400
Content-Disposition: inline
In-Reply-To: <20080831212317.GD9887@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, Sep 01, 2008 at 12:23:20AM +0300, Felipe Balbi wrote:
> On Sun, Aug 31, 2008 at 02:12:47PM -0700, David Brownell wrote:
> > On Saturday 30 August 2008, Felipe Balbi wrote:
> > > ---
> > > =A0drivers/video/backlight/Kconfig =A0 | =A0 =A09 ++
> > > =A0drivers/video/backlight/Makefile =A0| =A0 =A01 +
> > > =A0drivers/video/backlight/omap_bl.c | =A0218 +++++++++++++++++++=
++++++++++++++++++
> > > =A03 files changed, 228 insertions(+), 0 deletions(-)
> > > =A0create mode 100644 drivers/video/backlight/omap_bl.c
> >=20
> > How is this different from drivers/video/backlight/omap1_bl.c
> > which is already upstream?
> >=20
> > Looks to me like this is an old version of the same code, and
> > this driver should have been removed ... double check to make
> > sure no bugfixes are missing upstream.
>=20
> Weird that git marked this one as new file :-s
>=20
> I'm dropping from the series.

The problem is on linux-omap. It has a file without Makefile and Kconfi=
g
entries. I'm sending a patch soonish.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
