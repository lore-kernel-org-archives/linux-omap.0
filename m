From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] some drivers switch away from OMAP-specific GPIO calls
Date: Fri, 26 Sep 2008 10:41:22 +0300
Message-ID: <20080926074109.GB7962@atomide.com>
References: <200809241935.57001.david-b@pacbell.net> <20080925125311.GT5222@atomide.com> <200809250952.12282.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51968 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbYIZHij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 03:38:39 -0400
Content-Disposition: inline
In-Reply-To: <200809250952.12282.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080925 19:52]:
> On Thursday 25 September 2008, Tony Lindgren wrote:
> > >=20
> > > This updates most of the OMAP drivers which are in mainline to
> > > switch to using the cross-platform GPIO calls instead of the
> > > older OMAP-specific ones.
> > >=20
> > > This is all fairly brainless/obvious stuff. =A0Probably the
> > > most interesting bit is to observe that the omap-keypad
> > > code seems to now have a portable core that could work with
> > > non-OMAP matrix keypads. =A0(That would improve with hardware
> > > IRQ debouncing enabled, of course...)
> >=20
> > Do you want push this to mainline as part of gpiolib patches?
>=20
> I'l send it now that I have your Signed-off-By.
> CC a few subsystem maintainers ... but I see no
> point in splitting this into mini-patchlets.

OK sounds good to me.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
