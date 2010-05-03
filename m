From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] arm: Fix .gitignore for boot/compressed folder
Date: Mon, 3 May 2010 20:43:34 +0200
Message-ID: <20100503184334.GA24866@pengutronix.de>
References: <1267113345-18426-1-git-send-email-saaguirre@ti.com> <20100502122049.GA5553@pengutronix.de> <A24693684029E5489D1D202277BE8944551B8F75@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54947 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab0ECSnj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 14:43:39 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE8944551B8F75@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Albin Tonnerre <albin.tonnerre@free-electrons.com>, Russell King <rmk@arm.linux.org.uk>

On Mon, May 03, 2010 at 10:24:07AM -0500, Aguirre, Sergio wrote:
>=20
>=20
> From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
> Sent: Sunday, May 02, 2010 7:21 AM
> > On Thu, Feb 25, 2010 at 09:55:45AM -0600, Sergio Aguirre wrote:
> > > This should complements changes done in:
> > I think this should read "complement" only, that is, no 's' at the =
end.
> > Other than that,
>=20
> Oops, typo fixed. Thanks for noticing that!
No problem.

> Also... I added arch/arm/boot/compressed/vmlinux to the list, since w=
hen I
> build for my OMAP3 board, it shows in the dirty index.
>=20
> Is it acceptable to add that aswell? If yes, then attached patch cont=
ains
> your ACK + vmlinux added to the list.
This is OK, but IMHO you should note it in the commit log.  (And I thin=
k
most people prefer inline patches over attached ones.)

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
