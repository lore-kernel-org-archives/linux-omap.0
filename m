From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Wed, 26 Nov 2014 09:54:12 -0800
Message-ID: <20141126175412.GK2817@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <20131207232205.GS26766@atomide.com>
 <201411252208.17594@pali>
 <201411252231.45217@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51154 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbaKZR4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 12:56:42 -0500
Content-Disposition: inline
In-Reply-To: <201411252231.45217@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>, Sebastian Reichel <sre@ring0.de>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141125 13:33]:
> On Tuesday 25 November 2014 22:08:17 Pali Roh=C3=A1r wrote:
> > On Sunday 08 December 2013 00:22:06 Tony Lindgren wrote:
> > > * Sebastian Reichel <sre@ring0.de> [131207 15:04]:
> > > > On Sat, Dec 07, 2013 at 01:11:37PM -0800, Tony Lindgren
> >=20
> > wrote:
> > > > > > I asked Pali to send me his copy of the updated NOLO
> > > > > > bootloader, so that I can test this. I just checked
> > > > > > the omap documentation (I only have access to the
> > > > > > public one) and crypto related stuff is not
> > > > > > documented for the L3_PM_READ_PERMISSION register.
> > > > > > There are a couple of reserved bits, which may be
> > > > > > used for this, though.
> > > > > >=20
> > > > > > I also CC'd Joel Fernandes, since he worked on the
> > > > > > driver before and may have access to the
> > > > > > documentation.
> > > > >=20
> > > > > Looks like at least the 36xx public version referenced
> > > > > here has them:
> > > > >=20
> > > > > http://www.spinics.net/lists/linux-omap/msg21857.html
> > > > >=20
> > > > > I'd assume the registers are the same for 34xx since we
> > > > > don't have them defined separately in the kernel.
> > > >=20
> > > > I can't find it in the omap36xx documentation either.
> > > > Maybe I search at the wrong position. I tried to find
> > > > something crypto related in
> > > >=20
> > > > Table 9-89. L3_PM_READ_PERMISSION_i
> > >=20
> > > Hmm maybe it's done based on the address in
> > > L3_PM_ADDR_MATCH_k?
> > >=20
> > > I guess the thing to do would be to compare the register
> > > output between the two different firmware versions.
> > >=20
> > > Regards,
> > >=20
> > > Tony
> >=20
> > Tony, if you can tell me how to read those registers I can
> > provide output from both bootloaders (one that enable aes
> > support in L3 firewall and one which not).
> >=20
> > Also I can test other patches or provide other logs if you
> > need something more...

> CCing Nishanth Menon

Maybe just try dumping out the L3_PM_ADDR_MATCH_* registers
during the boot?

> Problem is that when L3 firewall is not configured by signed=20
> bootloader then loading omap aes driver cause kernel crash. We=20
> need some code which can check if omap aes is enabled or not at=20
> runtime in kernel...
>=20
> More details with full email tread conversation is there:
> http://thread.gmane.org/gmane.linux.ports.arm.omap/108397/

AFAIK we can't change the configuration, but it should be
readable somewhere. Sorry don't know which registers would
show the configuration other than the L3_PM_ADDR_MATCH_*
registers.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
