From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 2/5] I2C: TWL4030: Kconfig and Makefile changes
Date: Thu, 3 Apr 2008 15:07:26 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742903F1415B@dlee13.ent.ti.com>
References: <1207224865-21527-1-git-send-email-felipe.balbi@nokia.com> <1207224865-21527-2-git-send-email-felipe.balbi@nokia.com> <200804031113.11115.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49139 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbYDCUHi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 16:07:38 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200804031113.11115.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>

> On Thursday 03 April 2008, Felipe Balbi wrote:
> > +config TWL4030_MADC
> > +=A0=A0=A0=A0=A0=A0=A0tristate "TWL4030 MADC Driver"
> > +=A0=A0=A0=A0=A0=A0=A0depends on TWL4030_CORE
> > +
>=20
> Again, what's a MADC?

It's an 'upset C' of course ;)

Really:

It's a 10-bit analog-to-digital converter combined with a 16-input anal=
og multiplexer.  Multiplexed-ADC I suppose.  It is used by processor gr=
oups, battery charger and USB sub-chip.

8 of the 16 inputs are externally useable and the other 8 are used by b=
attery, speaker, usb.

On the lines of documentation a public 3430 TRM should be here any day =
if not already.  I'm not sure on T2, though I'll ask the question.

Regards,
Richard W.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
