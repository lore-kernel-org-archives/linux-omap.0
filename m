From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 13:24:33 -0800
Message-ID: <20150106212432.GY4081@atomide.com>
References: <20150105230228.GO4081@atomide.com>
 <20150106195454.GW4081@atomide.com>
 <20150106201758.GX4081@atomide.com>
 <201501062134.48963@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39300 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933000AbbAFV2Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 16:28:25 -0500
Content-Disposition: inline
In-Reply-To: <201501062134.48963@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sebastian Reichel <sre@kernel.org>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150106 12:37]:
> On Tuesday 06 January 2015 21:17:59 Tony Lindgren wrote:
> >=20
> > Oh and I have some u-boot patches that I'll post that allow
> > booting n900 with bootz and to use smsc91x tftp booting. I'll
> > try to post those shortly..
>=20
> N900 uboot support is broken, see my email on uboot ML with=20
> bisected commits:
>=20
> http://lists.denx.de/pipermail/u-boot/2015-January/200154.html

Oh my patches are against 2014-10 or something like that. No
idea about the recent regression.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
