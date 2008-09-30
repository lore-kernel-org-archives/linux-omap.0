From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [i2c] [PATCH 7/8] i2c-omap: Don't compile in OMAP15xx I2C ISR
 for non-OMAP15xx builds
Date: Mon, 29 Sep 2008 23:35:55 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809292335310.27332@utopia.booyaka.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-8-git-send-email-tony@atomide.com> <20080929222942.GT2716@fluff.org.uk> <200809291606.37236.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-729274875-1222752955=:27332"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41436 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYI3Ffz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 01:35:55 -0400
In-Reply-To: <200809291606.37236.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>, i2c@lm-sensors.org, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-729274875-1222752955=:27332
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Ben, David,

On Mon, 29 Sep 2008, David Brownell wrote:

> On Monday 29 September 2008, Ben Dooks wrote:
> > > -static void __exit omap_i2c_exit_driver(void)
> > > +static void __devexit omap_i2c_exit_driver(void)
> >=20
> > a differerent change to the one advertised.
> >=20
> > > =A0{
> > > =A0=A0=A0=A0=A0=A0platform_driver_unregister(&omap_i2c_driver);
> > > =A0}
>=20
> And incorrect too.

Indeed, will split and resubmit.



- Paul
--155748971-729274875-1222752955=:27332--
