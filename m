From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 29/33] add omap ehci bus glue
Date: Mon, 1 Sep 2008 00:25:45 +0300
Message-ID: <20080831212541.GE9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-29-git-send-email-me@felipebalbi.com> <1220116593-862-30-git-send-email-me@felipebalbi.com> <200808311409.42950.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60678 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913AbYHaV0H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:26:07 -0400
Content-Disposition: inline
In-Reply-To: <200808311409.42950.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Sun, Aug 31, 2008 at 02:09:42PM -0700, David Brownell wrote:
> On Saturday 30 August 2008, Felipe Balbi wrote:
> > +choice
> > +=A0=A0=A0=A0=A0=A0=A0prompt "PHY/TLL mode"
> > +=A0=A0=A0=A0=A0=A0=A0depends on USB_EHCI_HCD && EXPERIMENTAL && AR=
CH_OMAP34XX
> > +=A0=A0=A0=A0=A0=A0=A0---help---
> > +=A0=A0=A0=A0=A0=A0=A0Choose PHY or TLL mode of operation
> > +
> > +config OMAP_EHCI_PHY_MODE
> > +=A0=A0=A0=A0=A0=A0=A0bool "PHY mode: ISP1504 on Port1/2 (NEW 3430E=
S2.0)"
> > +=A0=A0=A0=A0=A0=A0=A0depends on USB_EHCI_HCD && EXPERIMENTAL && AR=
CH_OMAP34XX
> > +=A0=A0=A0=A0=A0=A0=A0---help---
> > +=A0=A0=A0=A0=A0=A0=A0 =A0EHCI PHY mode. Port1 and Port2 are connec=
ted to ISP1504 transcievers
> > +
> > +config OMAP_EHCI_TLL_MODE
> > +=A0=A0=A0=A0=A0=A0=A0bool "TLL mode: (EXPERIMENTAL)"
> > +=A0=A0=A0=A0=A0=A0=A0depends on USB_EHCI_HCD && EXPERIMENTAL && AR=
CH_OMAP34XX
> > +=A0=A0=A0=A0=A0=A0=A0---help---
> > +=A0=A0=A0=A0=A0=A0=A0OMAP EHCI controller has TLL mode of operatio=
n for all 3 ports.
> > +=A0=A0=A0=A0=A0=A0=A0Use this mode when no transciever is present
>=20
> All that stuff should be platform data, not Kconfig options.

Hmm... someone else will have to fix that. Will drop from the series
from now as well.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
