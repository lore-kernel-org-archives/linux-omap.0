From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 17 Jan 2015 09:04:11 -0800
Message-ID: <20150117170411.GT18552@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <201411252231.45217@pali>
 <20141126175412.GK2817@atomide.com>
 <201501171018.51811@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63774 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751255AbbAQRHq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jan 2015 12:07:46 -0500
Content-Disposition: inline
In-Reply-To: <201501171018.51811@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>, Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [150117 01:21]:
>=20
> Hello, after playing with aes and non-aes version of bootloaders=20
> I found out that code which configure L3 firewall must be in=20
> signed X-Loader part. So probably we cannot change configuration=20
> at runtime...
>=20
> Tony,
> any idea how to dump L3_PM_ADDR_MATCH_* registers from userspace=20
> or from kernel? Now I have configured one N900 with original=20
> Nokia X-Loader (where loading omap aes driver cause kernel crash)=20
> and one N900 with aes X-Loader (where loading omap aes driver is=20
> working).

Hmm maybe give the omapconf too a try? It's at:

https://github.com/omapconf/omapconf

That uses /dev/mem from userspace, then you can just ioremap
them in the kernel code if you need to do something during
runtime. Probably best to access them with a syscon mapping
from the aes driver.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
