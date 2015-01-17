From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 17 Jan 2015 09:41:26 -0800
Message-ID: <20150117174125.GV18552@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <201501171018.51811@pali>
 <20150117170411.GT18552@atomide.com>
 <201501171829.18354@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44778 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbAQRpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2015 12:45:01 -0500
Content-Disposition: inline
In-Reply-To: <201501171829.18354@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>, Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150117 09:32]:
> On Saturday 17 January 2015 18:04:11 Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150117 01:21]:
> > > Hello, after playing with aes and non-aes version of
> > > bootloaders I found out that code which configure L3
> > > firewall must be in signed X-Loader part. So probably we
> > > cannot change configuration at runtime...
> > >=20
> > > Tony,
> > > any idea how to dump L3_PM_ADDR_MATCH_* registers from
> > > userspace or from kernel? Now I have configured one N900
> > > with original Nokia X-Loader (where loading omap aes driver
> > > cause kernel crash) and one N900 with aes X-Loader (where
> > > loading omap aes driver is working).
> >=20
> > Hmm maybe give the omapconf too a try? It's at:
> >=20
> > https://github.com/omapconf/omapconf
> >=20
> > That uses /dev/mem from userspace, then you can just ioremap
> > them in the kernel code if you need to do something during
> > runtime. Probably best to access them with a syscon mapping
> > from the aes driver.
> >=20
> > Regards,
> >=20
> > Tony
>=20
> https://github.com/omapconf/omapconf/wiki
>=20
> Legacy TI OMAP platforms (OMAP[1-2-3]) are not supported.

Oh OK. Well at least you can look at the code if you want to
do it from the user space :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
