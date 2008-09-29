From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 12/23] move twl4030-gpio to drivers/gpio
Date: Tue, 30 Sep 2008 00:01:12 +0300
Message-ID: <20080929210111.GH2445@frodo>
References: <1222707783-18936-1-git-send-email-me@felipebalbi.com> <200809291306.20349.david-b@pacbell.net> <20080929201901.GF2445@frodo> <200809291346.00324.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42358 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbYI2VBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 17:01:20 -0400
Content-Disposition: inline
In-Reply-To: <200809291346.00324.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Mon, Sep 29, 2008 at 01:45:59PM -0700, David Brownell wrote:
> On Monday 29 September 2008, Felipe Balbi wrote:
> > On Mon, Sep 29, 2008 at 01:06:19PM -0700, David Brownell wrote:
> > > On Monday 29 September 2008, Felipe Balbi wrote:
> > > > =A0drivers/{i2c/chips =3D> gpio}/twl4030-gpio.c | =A0 37 ++++++=
+++++++++++++++++----
> > >=20
> > > Best to avoid sending this type of patch except as backup
> > > to a git pull request ... it's unusable to folk who use
> > > quilt and thus don't have access to GIT extensions.
> > >=20
> > > Where "unusable" means "can't apply the patch".
> >=20
> > The good thing with the git extensions for rename detection is that=
 we
> > really see what has changed when you renamed the file and that's wh=
at
> > really matters, right ?
>=20
> That's not all that matters, although I certainly liked being
> able to see that specific diff and confirm "yes, that's the
> stuff I had intended to change".
>=20
> A more basic point of posting patches to lists is that they be
> usable for testing.  And the git rename stuff prevents that.

Well that's one point, yes. But only prevent for those who doesn't use
git, right ? Although we can't really push everybody to drop quilt,
cogito, "patch -p1", own scripts, etc.

Then again, i really can't see why people still use quilt when we have
stgit, which gives you quilt functionality with all git's goodies.
Anyways, everybody should be able to choose a tool that fits better.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
