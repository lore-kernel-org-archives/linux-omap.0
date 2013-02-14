From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: Build error: OMAP randconfig / mvebu
Date: Thu, 14 Feb 2013 09:49:28 -0300
Message-ID: <20130214124927.GB11345@localhost>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk>
 <201302141127.07378.arnd@arndb.de>
 <20130214120650.GA11345@localhost>
 <201302141221.16267.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54916 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759809Ab3BNMth (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 07:49:37 -0500
Content-Disposition: inline
In-Reply-To: <201302141221.16267.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, arm@kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Arnd,

On Thu, Feb 14, 2013 at 12:21:16PM +0000, Arnd Bergmann wrote:
> On Thursday 14 February 2013, Ezequiel Garcia wrote:
> > Now, using the random config there's a new error, unrelated to the
> > previous one:
> >=20
> > ERROR: "twl6030_interrupt_unmask" [drivers/usb/otg/twl6030-usb.ko] =
undefined!
> > ERROR: "twl_i2c_read_u8" [drivers/usb/otg/twl6030-usb.ko] undefined=
!
> > ERROR: "twl_i2c_write_u8" [drivers/usb/otg/twl6030-usb.ko] undefine=
d!
> > ERROR: "twl6030_interrupt_mask" [drivers/usb/otg/twl6030-usb.ko] un=
defined!
>=20
> Yes, I guess that is an unrelated error. However, my patch also wasn'=
t
> correct because it is not allowed to have an empty list of objects.
>=20
> There is an updated patch below, I could add that straight to the bra=
nch
> that caused the problem if it looks ok to you.

The compile error is fixed here with this patch also.

Thanks,

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
