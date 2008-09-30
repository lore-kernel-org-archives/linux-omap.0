From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 09/25] i2c: move twl4030-madc to new registration style
Date: Wed, 1 Oct 2008 01:28:25 +0300
Message-ID: <20080930222823.GQ2445@frodo>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com> <1222800189-29737-9-git-send-email-me@felipebalbi.com> <1222800189-29737-10-git-send-email-me@felipebalbi.com> <200809301445.19900.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57807 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbYI3W2q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 18:28:46 -0400
Content-Disposition: inline
In-Reply-To: <200809301445.19900.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Mikko Ylinen <mikko.k.ylinen@nokia.com>

On Tue, Sep 30, 2008 at 02:45:19PM -0700, David Brownell wrote:
> On Tuesday 30 September 2008, Felipe Balbi wrote:
> > =A0=A0=A0=A0=A0=A0=A0=A0ret =3D request_irq(TWL4030_MODIRQ_MADC, tw=
l4030_madc_irq_handler,
>=20
> Likewise:  pass the IRQ through a platform driver resource.
> These TWL4030_MODIRQ_* symbols should vanish.
>=20
> (To fix later.  No reason to hold up this batch of patches
> any longer...)

True, i'll cook a patch for it tomorrow :-D

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
