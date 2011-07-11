From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
Subject: Re: [PATCH 00/22] Tahvo cleanups and Retu optimization
Date: Mon, 11 Jul 2011 16:19:33 +0200
Message-ID: <20110711161933.6293e6c6@maggie>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
	<20110711132842.10606a31@maggie>
	<20110711131231.GB2680@legolas.emea.dhcp.ti.com>
	<20110711154126.082c1514@maggie>
	<20110711134551.GC2680@legolas.emea.dhcp.ti.com>
	<20110711155123.23c33a13@maggie>
	<20110711140326.GE2680@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bues.ch ([80.190.117.144]:56986 "EHLO bues.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751948Ab1GKOTq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 10:19:46 -0400
In-Reply-To: <20110711140326.GE2680@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Mon, 11 Jul 2011 17:03:28 +0300
=46elipe Balbi <balbi@ti.com> wrote:

> Hi,
>=20
> On Mon, Jul 11, 2011 at 03:51:23PM +0200, Michael B=C3=BCsch wrote:
> > On Mon, 11 Jul 2011 16:45:53 +0300
> > Felipe Balbi <balbi@ti.com> wrote:
> >=20
> > > On Mon, Jul 11, 2011 at 03:41:26PM +0200, Michael B=C3=BCsch wrot=
e:
> > > > On Mon, 11 Jul 2011 16:12:32 +0300
> > > > Felipe Balbi <balbi@ti.com> wrote:
> > > > > > Are you planning to implement a backlight driver for tahvo?=
 I'm actually
> > > > > > using the functionality that you removed in this patchset i=
n the OpenWRT
> > > > > > distribution.
> > > > >=20
> > > > > if you have some extra documentation available, I could imple=
ment it
> > > > > whenever I have some extra couple hours to play with this aga=
in... I
> > > > > have no docs at all, but a led-tahvo.c would be really simple=
 to get
> > > > > done :-)
> > > >=20
> > > > All I have is the old code. No docs. It seems rather simple, th=
ough.
> > > > Only a PWM register. That's pretty straightforward.
> > >=20
> > > cool, any pointers would be good ;-)
> >=20
> > Pointers to what? How PWM works?
> > http://en.wikipedia.org/wiki/Pulse_width_modulation
> >=20
> > You probably don't need to know the details, though.
> > Just write a 0 to the register to turn the LED off. And write
> > a 0xF (or 0x7F depending on tahvo revision) to the register to
> > turn it fully on. Any value in between to dim the LED.
>=20
> no, not to PWM... pointers to the code using the old interface ;-)

Oh, got it now. :D

This patch connects the tahvo backlight API to the MIPID/omapfb backlig=
ht API:
https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches-2.6=
=2E38/820-backlight-fixes.patch

The actual backlight control is done in userspace:
http://bues.ch/gitweb?p=3Dpwrtray.git;a=3Dsummary
http://bues.ch/gitweb?p=3Dpwrtray.git;a=3Dblob;f=3Dbackend/backlight_om=
apfb.c;hb=3DHEAD
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
