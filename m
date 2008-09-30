From: Paul Walmsley <paul@booyaka.com>
Subject: Re: [i2c] [PATCH 7/8] i2c-omap: Don't compile in OMAP15xx I2C ISR
 for non-OMAP15xx builds
Date: Mon, 29 Sep 2008 23:36:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0809292336130.27332@utopia.booyaka.com>
References: <1222329234-31473-1-git-send-email-tony@atomide.com> <1222329234-31473-8-git-send-email-tony@atomide.com> <20080929222942.GT2716@fluff.org.uk> <200809291606.37236.david-b@pacbell.net> <alpine.DEB.2.00.0809292335310.27332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2140352629-1222752985=:27332"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41447 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbYI3FgY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 01:36:24 -0400
In-Reply-To: <alpine.DEB.2.00.0809292335310.27332@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>, i2c@lm-sensors.org, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2140352629-1222752985=:27332
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 29 Sep 2008, Paul Walmsley wrote:

> Hello Ben, David,
>=20
> On Mon, 29 Sep 2008, David Brownell wrote:
>=20
> > On Monday 29 September 2008, Ben Dooks wrote:
> > > > -static void __exit omap_i2c_exit_driver(void)
> > > > +static void __devexit omap_i2c_exit_driver(void)
> > >=20
> > > a differerent change to the one advertised.
> > >=20
> > > > =A0{
> > > > =A0=A0=A0=A0=A0=A0platform_driver_unregister(&omap_i2c_driver);
> > > > =A0}
> >=20
> > And incorrect too.
>=20
> Indeed, will split and resubmit.

(and change to __init/__exit)


- Paul
--155748971-2140352629-1222752985=:27332--
