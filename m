From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Thu, 4 Dec 2014 10:40:34 -0800
Message-ID: <20141204184033.GI2817@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <201411282241.12095@pali>
 <20141128222424.GX2817@atomide.com>
 <201412041934.03384@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11321 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932215AbaLDSmn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2014 13:42:43 -0500
Content-Disposition: inline
In-Reply-To: <201412041934.03384@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141204 10:36]:
>=20
> see last mail in thread (I CCed you):
> "[PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible"
>=20
> There is already some layer for converting ATAGs to DTB and it is=20
> in decompresser: arch/arm/boot/compressed/atags_to_fdt.c
>=20
> I do not know if it can help us to provide /proc/cpuinfo and=20
> /proc/atags in DT boot, but at least this this transfer cmdline=20
> and mem ATAGs to DBT.

Yes that makes sense to me. Sorry forgot about that piece of
code as I have not tinkered with arch/arm/boot/compressed/*
for a few years.

It sounds like there may be some regression also if the cmdline
is not being passed like it already should. But I assume you
already figured that out and have some patches coming :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
