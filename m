From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Wed, 26 Nov 2014 11:10:28 -0800
Message-ID: <20141126191027.GM2817@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <20141126172857.GA26157@amd>
 <20141126181934.GL2817@atomide.com>
 <201411261957.08860@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64725 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaKZTM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 14:12:59 -0500
Content-Disposition: inline
In-Reply-To: <201411261957.08860@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141126 10:59]:
> On Wednesday 26 November 2014 19:19:35 Tony Lindgren wrote:
> >=20
> > Maybe Pali can try to restart that discussion? To me it seems
> > the /proc/cpuinfo should be the same as it's a user
> > interface. Sorry forgot the details of the previous
> > discussion..
> >=20
>=20
> Yes, two days ago I again wrote emails about this problem...
>=20
> E.g. one of them, see: https://lkml.org/lkml/2014/11/24/774
>=20
> > And with which app was that? Sorry I forgot..
> >=20
>=20
> More applications/libraries for N900 which running on Maemo 5=20
> system. Some of them are Nokia proprietary, some of them are open=20
> source and some are mine.
>=20
> Basically problem is that non DT boot provides this info in=20
> /proc/cpuinfo:
>=20
> Hardware        : Nokia RX-51 board
> Revision        : 0012
>=20
> New DT boot provides this:
>=20
> Hardware        : Generic OMAP3 (Flattened Device Tree)
> Revision        : 0000

Oh you can easily fix that by adding a n900 specific
DT_MACHINE_START entry to mach-omap2/board-generic.c.

The revision entry you can populate too in pdata-quirks.c,
or maybe add something generic to populate it based on the
cmdline or a dts entry as I believe that comes from the
legacy ATAGs. I think that's just the system_rev or some
other *_rev global in the kernel.

Regards,

Tony=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
