From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: Self modifying code in ARM 11 architectures
Date: Wed, 25 May 2011 13:45:19 +0200
Message-ID: <20110525114519.GC12200@pengutronix.de>
References: <BANLkTi=mVsYiubqtJO2BmWvExMvUFRg6dg@mail.gmail.com>
 <BANLkTimyju7eEgtCpb_U6s8LNHk-_FGK4Q@mail.gmail.com>
 <BANLkTinrj-dkJShzTQuhYSOWkK4QSEnQgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57899 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141Ab1EYLp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 May 2011 07:45:26 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinrj-dkJShzTQuhYSOWkK4QSEnQgQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashok Babu <ashok3d@gmail.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm@vger.kernel.org

Hello,

On Wed, May 25, 2011 at 01:18:37PM +0530, Vimal Singh wrote:
> CC'ing correct ARM mailing list.
>=20
> On Tue, May 24, 2011 at 3:48 PM, Ashok Babu <ashok3d@gmail.com> wrote=
:
> > Hi All,
> >
> > I am no success in booting up the ARM1176 processor with the
> > linux-2.6.32 kernel.
> > While googling about the ARM=A0Harvard=A0architecture, I came to kn=
ow that
> > we have to flush/invalidate the D-Cache and I-Cache
> > when using the self modifying codes.
> >
> > So here my questions/doubts :
> > 1) Is'nt it the kernel itself is self modifying code with lots of
> > function pointers ?
Code that uses function pointer isn't usually called self-modifying.

> > =A0 =A0 If yes, how is synchronization b/w d-cache and i-cache hand=
led in
> > the kernel ?
> > 2) Can this be the reason for the kernel not booting for me ?
> > =A0 =A0 Because If i disable the I-Cache in the config, then the ke=
rnel
> > boots up without any issues.
> > Any pointers on this will be of great help.
Does your bootloader correctly disables the I-Cache before giving contr=
ol
to Linux?

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
