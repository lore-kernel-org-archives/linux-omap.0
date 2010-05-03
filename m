From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] arm: Fix .gitignore for boot/compressed folder
Date: Mon, 3 May 2010 14:01:11 -0500
Message-ID: <A24693684029E5489D1D202277BE8944551B92A4@dlee02.ent.ti.com>
References: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
 <20100502122049.GA5553@pengutronix.de>
 <A24693684029E5489D1D202277BE8944551B8F75@dlee02.ent.ti.com>
 <20100503184334.GA24866@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54581 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755521Ab0ECTBa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 15:01:30 -0400
In-Reply-To: <20100503184334.GA24866@pengutronix.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Albin Tonnerre <albin.tonnerre@free-electrons.com>, Russell King <rmk@arm.linux.org.uk>



> -----Original Message-----
=46rom: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
Sent: Monday, May 03, 2010 1:44 PM
> On Mon, May 03, 2010 at 10:24:07AM -0500, Aguirre, Sergio wrote:
> >
> >
> > From: Uwe Kleine-K=F6nig [mailto:u.kleine-koenig@pengutronix.de]
> > Sent: Sunday, May 02, 2010 7:21 AM
> > > On Thu, Feb 25, 2010 at 09:55:45AM -0600, Sergio Aguirre wrote:
> > > > This should complements changes done in:
> > > I think this should read "complement" only, that is, no 's' at th=
e
> end.
> > > Other than that,
> >
> > Oops, typo fixed. Thanks for noticing that!
> No problem.
>=20
> > Also... I added arch/arm/boot/compressed/vmlinux to the list, since=
 when
> I
> > build for my OMAP3 board, it shows in the dirty index.
> >
> > Is it acceptable to add that aswell? If yes, then attached patch
> contains
> > your ACK + vmlinux added to the list.
> This is OK, but IMHO you should note it in the commit log.  (And I th=
ink
> most people prefer inline patches over attached ones.)

Ok, sure. Will resend inlined patch w/commit description changed.

Thanks again.

Regards,
Sergio

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
