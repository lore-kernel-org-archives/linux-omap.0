From: Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Subject: Re: Booting n8x0 on mainline without UART
Date: Tue, 22 Feb 2011 23:28:58 +0100
Message-ID: <1298413738.14780.1.camel@maggie>
References: <3064ff5376f174fcd54b321764d8e2a0@mail.gmail.com>
	 <1298370909.6998.9.camel@maggie>  <20110222171852.GK15225@atomide.com>
	 (sfid-20110222_181915_489338_FFFFFFFF8D327BF5)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:54174 "EHLO
	bu3sch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab1BVW3F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 17:29:05 -0500
In-Reply-To: <20110222171852.GK15225@atomide.com> (sfid-20110222_181915_489338_FFFFFFFF8D327BF5)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Tue, 2011-02-22 at 09:18 -0800, Tony Lindgren wrote:=20
> * Michael B=C3=BCsch <mb@bu3sch.de> [110222 02:33]:
> > On Tue, 2011-02-22 at 10:41 +0530, Anand Gadiyar wrote:=20
> > > I'm trying to boot up the mainline kernel on an n800 device. I do=
n't have
> > > a functional UART up and running - so I cannot see any console me=
ssages.
> >=20
> > I don't know about the n800, but for the n810 there are quite some
> > patches needed to get it working correctly.
> >=20
> > https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches=
-2.6.37
> >=20
> > Not all of those patches are strictly required for basic bootup, th=
ough.
>=20
> Care to put together a series of patches that could be integrated to
> mainline kernel for 2.6.39?

As I just said in the other thread: The patchset is not ready for
inclusion. The omap tree CBUS code is more advanced, in fact.

--=20
Greetings Michael.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
