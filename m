From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 12/33] Add tsc2005 touchscreen driver
Date: Mon, 1 Sep 2008 00:35:03 +0300
Message-ID: <20080831213500.GI9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-12-git-send-email-me@felipebalbi.com> <1220116593-862-13-git-send-email-me@felipebalbi.com> <200808311353.37569.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52450 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222AbYHaVfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:35:43 -0400
Content-Disposition: inline
In-Reply-To: <200808311353.37569.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sun, Aug 31, 2008 at 01:53:37PM -0700, David Brownell wrote:
> On Saturday 30 August 2008, Felipe Balbi wrote:
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -217,6 +217,11 @@ config TOUCHSCREEN_ATMEL_TSADCC
> > =A0=A0=A0=A0=A0=A0=A0=A0 =A0To compile this driver as a module, cho=
ose M here: the
> > =A0=A0=A0=A0=A0=A0=A0=A0 =A0module will be called atmel_tsadcc.
> > =A0
> > +config TOUCHSCREEN_TSC2005
> > +=A0=A0=A0=A0=A0=A0=A0tristate "TSC2005 touchscreen support"
> > +=A0=A0=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0=A0=A0 =A0Say Y here for if you are using the touch=
screen features of TSC2301
>=20
> TSC 2301 or 2005?
> And shouldn't there be a TSC 2301 or 2005 driver to depend on?

My bad, didn't see the typo on linux-omap. I'll fix on both trees and
send patch to l-o soonish.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
