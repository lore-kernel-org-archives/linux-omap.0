From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Sat, 24 Jan 2015 23:08 +0100
Message-ID: <2871852.qm0MoZvdlF@wuerfel>
References: <1421171865-5209-1-git-send-email-tony@atomide.com> <20150115142536.GC512@earth.universe> <201501241300.00723@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:52354 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbAXWIJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 17:08:09 -0500
In-Reply-To: <201501241300.00723@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>

On Saturday 24 January 2015 13:00:00 Pali Roh=E1r wrote:
>=20
> Another regression for DT setup (which does not occur for board code)=
:
>=20
> omap_hsmmc driver does not export slot_name sysfs entry because
> it not supported by DT yet. Entry slot_name is used by userspace
> application to determinate if mmc block device is internal eMMC
> memory or external uSD card. So support for this property also in
> DT is needed.
>=20
> Here is simple patch which fix this problem:
>=20

The sysfs file only exists for the two OMAP drivers, and the naming
is used only by board-n8x0, board-rx51 and board-omap3logic.

It may be better to add a board-specific hack for these to keep the
existing user space working but not spread the use of this file anywher=
e
else.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
