From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/6] net: cpsw: Support for am335x chip MACIDs
Date: Thu, 13 Feb 2014 20:33:01 +0100
Message-ID: <20140213193301.GD17650@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <52B1D4C7.6030004@ti.com>
 <20131218170818.GR4970@saruman.home>
 <52B1D722.3040500@ti.com>
 <20131218171301.GT4970@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44399 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbaBMTdK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 14:33:10 -0500
Content-Disposition: inline
In-Reply-To: <20131218171301.GT4970@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Markus Pargmann <mpa@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hello,

On Wed, Dec 18, 2013 at 11:13:01AM -0600, Felipe Balbi wrote:
> On Wed, Dec 18, 2013 at 10:40:58PM +0530, Mugunthan V N wrote:
> > On Wednesday 18 December 2013 10:38 PM, Felipe Balbi wrote:
> > > On Wed, Dec 18, 2013 at 10:30:55PM +0530, Mugunthan V N wrote:
> > >> On Wednesday 18 December 2013 10:17 PM, Markus Pargmann wrote:
> > >> Mac ID is to be filled by U-Boot and this kind of approach is al=
ready
> > >> rejected in linux-omap list.
> > >>
> > >> If proper ethaddr/eth*addr is populated in U-boot environment va=
riable
> > >> then mac-address dt property in ethernet* device nodes will be p=
opulated
> > >> before boot kernel in U-boot. So I don't think this patch series=
 is
> > >> required.
> > > but will u-boot read MACID from control module ?
> > >
> > Yes, U-Boot will read the MACID from control module and if a custom=
er
> > wants to have his own MACID, U-boot ENV variable ethaddr/eth1addr m=
ust
> > be updated.
>=20
> cool, then I agree this series shouldn't be applied ;-)
But even then I'd suggest to take at least patches 1 and 2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
