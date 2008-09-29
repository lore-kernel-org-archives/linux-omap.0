From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 12/23] move twl4030-gpio to drivers/gpio
Date: Mon, 29 Sep 2008 13:45:59 -0700
Message-ID: <200809291346.00324.david-b@pacbell.net>
References: <1222707783-18936-1-git-send-email-me@felipebalbi.com> <200809291306.20349.david-b@pacbell.net> <20080929201901.GF2445@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:36427 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752071AbYI2UqE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Sep 2008 16:46:04 -0400
In-Reply-To: <20080929201901.GF2445@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

On Monday 29 September 2008, Felipe Balbi wrote:
> On Mon, Sep 29, 2008 at 01:06:19PM -0700, David Brownell wrote:
> > On Monday 29 September 2008, Felipe Balbi wrote:
> > > =A0drivers/{i2c/chips =3D> gpio}/twl4030-gpio.c | =A0 37 ++++++++=
+++++++++++++++----
> >=20
> > Best to avoid sending this type of patch except as backup
> > to a git pull request ... it's unusable to folk who use
> > quilt and thus don't have access to GIT extensions.
> >=20
> > Where "unusable" means "can't apply the patch".
>=20
> The good thing with the git extensions for rename detection is that w=
e
> really see what has changed when you renamed the file and that's what
> really matters, right ?

That's not all that matters, although I certainly liked being
able to see that specific diff and confirm "yes, that's the
stuff I had intended to change".

A more basic point of posting patches to lists is that they be
usable for testing.  And the git rename stuff prevents that.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
