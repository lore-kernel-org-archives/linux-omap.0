From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [patch] omap: usb: ehci: fix use of hcd->regs
Date: Fri, 12 Sep 2008 20:50:33 +0300
Message-ID: <20080912175033.GB7132@frodo>
References: <20080912121024.GG759@gandalf.research.nokia.com> <200809120932.57016.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41565 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbYILRun (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 13:50:43 -0400
Content-Disposition: inline
In-Reply-To: <200809120932.57016.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Sep 12, 2008 at 09:32:56AM -0700, David Brownell wrote:
> On Friday 12 September 2008, Felipe Balbi wrote:
> > - =A0 =A0 =A0 hcd->regs =3D (void __iomem *) (int) IO_ADDRESS(hcd->=
rsrc_start);
> > + =A0 =A0 =A0 hcd->regs =3D ioremap(hcd->rsrc_start, hcd->rsrc_len)=
;
>=20
> This is missing its sibling iounmap() ...

God... thanks Dave. Good catch. Patch coming soonish.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
