From: Tony Lindgren <tony@atomide.com>
Subject: Re: Booting n8x0 on mainline without UART
Date: Tue, 22 Feb 2011 09:18:52 -0800
Message-ID: <20110222171852.GK15225@atomide.com>
References: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com>
 <1298370909.6998.9.camel@maggie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33447 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab1BVRTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 12:19:08 -0500
Content-Disposition: inline
In-Reply-To: <1298370909.6998.9.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?utf-8?B?QsO8c2No?= <mb@bu3sch.de>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

* Michael B=C3=BCsch <mb@bu3sch.de> [110222 02:33]:
> On Tue, 2011-02-22 at 10:41 +0530, Anand Gadiyar wrote:=20
> > I'm trying to boot up the mainline kernel on an n800 device. I don'=
t have
> > a functional UART up and running - so I cannot see any console mess=
ages.
>=20
> I don't know about the n800, but for the n810 there are quite some
> patches needed to get it working correctly.
>=20
> https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches-2=
=2E6.37
>=20
> Not all of those patches are strictly required for basic bootup, thou=
gh.

Care to put together a series of patches that could be integrated to
mainline kernel for 2.6.39?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
