From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Fri, 28 Nov 2014 12:27:19 -0800
Message-ID: <20141128202719.GU2817@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <201411270038.01312@pali>
 <20141127011203.GR2817@atomide.com>
 <201411271232.47231@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11765 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751041AbaK1U3p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 15:29:45 -0500
Content-Disposition: inline
In-Reply-To: <201411271232.47231@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141127 03:34]:
> On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> >=20
> > Thinking about this probably the best long term solution is
> > to pass optional board_revision in the kernel cmdline that
> > can be parsed early and copied to system_rev variable.
> >=20
>=20
> Not possible. Our bootloader is closed & proprietary. I tried to=20
> replace it with u-boot I was not able to do that. So we will use=20
> that Nokia closed bootloader forever and it can provide data only=20
> in ATAG structure.

I'm using just mainline u-boot flashed as kernel for nolo that
then loads the kernel.

=46or passing the board revision using the pass through u-boot is
probably the best long term solution. U-boot can read the ATAGs
from nolo and modify the .dtb for the revision information.

Are you saying there are some issues with that?
=20
> > Or if you can think of some other way to get it, we can set
> > system_rev in pdata-quirks.c.
> >=20
> > Or maybe add some code to copy the ATAGs somewhere where
> > they are out of the way and don't conflict with the device
> > tree data? Then we can query ATAG_REVISION from pdata-quirks.c
> > and set system_rev.
>=20
> If we are able to read ATAG from pdata-quirks, then we can parse=20
> it there and fix problems... But I do not know if address of ATAG=20
> structure is available there...

Are there other ATAGs needed beyond the ATAG_REVISION?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
