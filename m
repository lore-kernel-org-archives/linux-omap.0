From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap:
	usb: ehci: fix use of hcd->regs)
Date: Fri, 12 Sep 2008 22:29:54 +0300
Message-ID: <20080912192953.GG7132@frodo>
References: <20080912121024.GG759@gandalf.research.nokia.com> <20080912182255.GD7132@frodo> <20080912183819.GE7132@frodo> <200809121216.27116.david-b@pacbell.net> <20080912192158.GG10675@atomide.com> <20080912192809.GF7132@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40881 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbYILTaF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 15:30:05 -0400
Content-Disposition: inline
In-Reply-To: <20080912192809.GF7132@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Sep 12, 2008 at 10:28:16PM +0300, Felipe Balbi wrote:
> On Fri, Sep 12, 2008 at 12:21:59PM -0700, Tony Lindgren wrote:
> > * David Brownell <david-b@pacbell.net> [080912 12:18]:
> > > On Friday 12 September 2008, Felipe Balbi wrote:
> > > > =A0=A0=A0=A0=A0=A0=A0=A0/* Enusre bit is set */
> > >=20
> > > My Cortex Mark-I (cerebral, humanoid) treats that as a compile er=
ror ... :)
> >=20
> > Have you tried preprocessing with squint? :)
>=20
> ehehe, it's not in my diff, so it wasn't me. :-p
> I'll fix it in the final clean up

btw, when the "virtual clock" structure come from Hiroshi and/or Paul,
the clock handling on ehci-omap could get some rewriting as well ;-)

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
